# RAW binary data to wave file converter
# Reads a binary file rawf2.bin
# to convert to a wave file
# Author: Bilgehan ERKAL
# 24.03.2025 (dd.mm.yyyy)

# use wave module to handle wave files
import wave

# open binary file in read mode
rawf = open("rawf2.bin", "rb")
rawf.seek(0,2)# seek the end of the file
# report number of bytes in the file
nbytes = rawf.tell()
rawf.seek(0,0) # rewind bin file
nbits = 16 # bit resolution
# number of samples in the file
nsamples = nbytes//(nbits//8)
fs = 48000 # sampling frequency (Hz)
duration = nsamples / fs # duration in seconds

# report file properties
print("the file holds %i samples "%nsamples)
print("the duration is %f seconds "%duration)

samples = [] # array that holds samples
# draw raw samples from file
for i in range (0,nsamples):
    # we use a little endian byte order
    for j in range (0,(nbits//8)):
        samples.append(ord(rawf.read(1)))
        
# create wave file
with wave.open("wav_snd.wav", mode="wb") as wavf:
    # mono recording
    wavf.setnchannels(1)
    # n-bits
    wavf.setsampwidth(nbits//8)
    # 48KSps
    wavf.setframerate(fs)
    # write samples to file
    wavf.writeframes(bytes(samples))
    print("wave file created succesfully")
# always close the bin file   
rawf.close()
