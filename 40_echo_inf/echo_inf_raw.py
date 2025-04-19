# INFINITE ECHO Simulation data set calculator
# Prepares a echo wave file echo_snd2.wav
# the file will be used to show echo effects
# on wave files converted to raw binary files
# Author: Bilgehan ERKAL
# 27.03.2025 (dd.mm.yyyy)

# use wave module to handle wave files
import wave

# output array
no     = []
# output array for waveform
no_wform = []
# echo array
echo   = []
# waveform array
wform  = []
# define number of input port bits here
nbits  = 16
# sample frequency (hz)
fs     = 48000
# gain input bit depth
ngain  = 5
# gain input
gain   = 7
gain   = gain % 2**(ngain-1)
# delay line elements (td = ndelay/fs seconds)
ndelay = 4800 # min value = 3
# number of samples
nsamples = 0

# calculate waveform
def calc_waveform():
    global nsamples
    # open binary file in read mode
    rawf = open("rawf.bin", "rb")
    rawf.seek(0,2)# seek the end of the file
    # report number of bytes in the file
    nbytes = rawf.tell()
    rawf.seek(0,0) # rewind bin file
    # number of samples in the file
    nsamples = nbytes//(nbits//8)
    fs = 48000 # sampling frequency (Hz)
    duration = nsamples / fs # duration in seconds
    # report file properties
    print("the file holds %i bytes "%nbytes)
    print("the file holds %i samples "%nsamples)
    print("the duration is %f seconds "%duration)
    # draw raw samples from file
    for i in range (0,nsamples):
        wform.append(0)
        # we use a little endian byte order
        for j in range (0,(nbits//8)):
            wform[i] = wform[i] + (2**(j*8))*ord(rawf.read(1))
        # convert raw data to signed integer
        if (wform[i]>32767):
            wform[i] = wform[i] - 2**16

# calculate echo
def calc_echo():  
    # create echo
    for i in range(0, nsamples):
        # output of delay/gain stages
        if (i<=ndelay):
            gain_out = 0
        else: 
            gain_out = echo[i-ndelay-1] * gain
        # 21-bits, attenuated by truncating 3 LSB
        # so set to 18-bits (attenuated 2^3=8 times)
        adder_in2 = gain_out >> 3
        # adder_in2 amplified by extracting 2 MSBs
        # so set to 16-bits while it is amplified
        # 2^2 = 4 times
        adder_out = wform[i] + adder_in2
        # 17-bit adder_out truncated to 16-bits 
        echo.append(adder_out >> 1) 
        
# calculate bindata for echo       
def calc_no():
    # create byte ordered samples (little endian)
    for i in range(0, nsamples):
        for j in range (0, nbits//8):
            no.append(echo[i] % 256)
            echo[i] = echo[i] >> 8

# calculate bindata for waveform
def calc_no_wform():
    # create byte ordered samples (little endian)
    for i in range(0, nsamples):
        for j in range (0, nbits//8):
            no_wform.append(wform[i] % 256)
            wform[i] = wform[i] >> 8

# calculate results
calc_waveform()
calc_echo()
calc_no()
calc_no_wform()

#convert data for writing to binary file   
send = bytes(bytearray(no_wform))
# write to file
with open("wform2.bin", "wb") as rawf:
    rawf.write(send)

#read and dump the contents of the binary data file
with open("wform2.bin", "rb") as rawf:
    print(rawf.read(101))
print() 
# create wave file
with wave.open("wform_snd2.wav", mode="wb") as wavf:
    # mono recording
    wavf.setnchannels(1)
    # 16-bits
    wavf.setsampwidth(2)
    # 48KSps
    wavf.setframerate(fs)
    # write samples to file
    wavf.writeframes(bytes(send))
    print("wave file for waveform created succesfully")
print()
#convert data for writing to binary file   
send = bytes(bytearray(no))
# write to file
with open("echo2.bin", "wb") as rawf:
    rawf.write(send)

#read and dump the contents of the binary data file
with open("echo2.bin", "rb") as rawf:
    print(rawf.read(101))
print() 
# create wave file
with wave.open("echo_snd2.wav", mode="wb") as wavf:
    # mono recording
    wavf.setnchannels(1)
    # 16-bits
    wavf.setsampwidth(2)
    # 48KSps
    wavf.setframerate(fs)
    # write samples to file
    wavf.writeframes(bytes(send))
    print("wave file for echo output created succesfully")

