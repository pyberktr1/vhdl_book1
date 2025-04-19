# NENET Simulation wave data converter
# Reads a binary file nenet_wav.bin
# to convert a wave file
# Author: Bilgehan ERKAL
# 17.03.2025 (dd.mm.yyyy)

# use wave module to handle wave files
import wave

# open binary file in read mode
rawf = open("nenet_wav.bin", "rb")
rawf.seek(0,2)# seek the end of the file
# report number of samples in the file
nsamples = rawf.tell()
rawf.seek(0,0) # rewind bin file
fs = 48000 # sampling frequency (Hz)
duration = nsamples / fs # duration in seconds

# report file properties
print("the file holds %i samples "%nsamples)
print("the duration is %f seconds "%duration)

samples = [] # array that holds samples
# draw raw samples from file
for i in range (0,nsamples):
    # we amplify the samples 16 times
    # to set the bit resolution to 8-bits
    samples.append(ord(rawf.read(1))*16)
# create wave file
with wave.open("snd.wav", mode="wb") as wavf:
    # mono recording
    wavf.setnchannels(1)
    # 8-bits
    wavf.setsampwidth(1)
    # 48KSps
    wavf.setframerate(fs)
    # write samples to file
    wavf.writeframes(bytes(samples))
    print("wave file created succesfully")
# always close the bin file   
rawf.close()
