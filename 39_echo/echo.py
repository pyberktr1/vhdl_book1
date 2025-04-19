# ECHO MIKE Simulation data set calculator
# Prepares a binary file wform.bin
# for storing calculated values
# the file will be used in VHDL simulations
# for compare and verification of hardware
# Author: Bilgehan ERKAL
# 22.03.2025 (dd.mm.yyyy)

# use wave module to handle wave files
import wave

# output array
no     = []
# output array for waveform
no_wform = []
# echo array
echo   = []
# input signal array
ins    = []
# waveform array
wform  = []
# define number of input port bits here
nbits  = 16
# sample frequency (hz)
fs     = 48000
# gain input bit depth
ngain  = 5
# gain input
gain   = 15
gain   = gain % (2**(ngain-1))
# delay line elements (td = ndelay/fs seconds)
ndelay = 4800 # min value = 3

# calculate waveform
def calc_waveform():
    w = -2**(nbits-1)
    for i in range (0, 2**nbits):
        # append new element to output array
        wform.append(w)
        w = w + 1

# calculate echo
def calc_echo():
    # create echo
    for i in range(0, 2**nbits):
        # output of delay/gain stages
        if (i<ndelay):
            gain_out = 0
        else:
            # output will be 16+5 = 21-bits
            gain_out = wform[i-ndelay] * gain
        # gain_out will be attentuated 5-bits
        # and adjusted to 16-bits before addition
        # so the sum output will be 17-bits
        adder_out = wform[i] + (gain_out >> ngain)
        # the sum will be attenuated by a factor of 2
        # and it will be truncated to 16-bits
        echo.append(adder_out >> 1)
        
# calculate bindata for echo       
def calc_no():
    # create byte ordered samples (little endian)
    for i in range(0, 2**nbits):
        for j in range (0, nbits//8):
            no.append(echo[i] % 256)
            echo[i] = echo[i] >> 8

# calculate bindata for waveform
def calc_no_wform():
    # create byte ordered samples (little endian)
    for i in range(0, 2**nbits):
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
with open("wform.bin", "wb") as rawf:
    rawf.write(send)

#read and dump the contents of the binary data file
with open("wform.bin", "rb") as rawf:
    print(rawf.read(101))
print() 
# create wave file
with wave.open("wform_snd.wav", mode="wb") as wavf:
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
with open("echo.bin", "wb") as rawf:
    rawf.write(send)

#read and dump the contents of the binary data file
with open("echo.bin", "rb") as rawf:
    print(rawf.read(101))
print() 
# create wave file
with wave.open("echo_snd.wav", mode="wb") as wavf:
    # mono recording
    wavf.setnchannels(1)
    # 16-bits
    wavf.setsampwidth(2)
    # 48KSps
    wavf.setframerate(fs)
    # write samples to file
    wavf.writeframes(bytes(send))
    print("wave file for echo output created succesfully")

