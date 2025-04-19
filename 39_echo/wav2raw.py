# Wave file to RAW binary data converter
# Reads a wave file wavf
# to convert to a binary file
# Author: Bilgehan ERKAL
# 24.03.2025 (dd.mm.yyyy)

# use wave module to handle wave files
import wave
# open and transfer data from wave file
with wave.open("a1.wav") as wavf:
    header   = wavf.getparams()
    samples  = wavf.readframes(header.nframes)
# print wave file info    
print(header)

# open binary file in write mode
rawf = open("rawf.bin", "wb")
# write all samples to binary file
rawf.write(bytes(samples))
print()
print("bindata written successfully")
# always close the bin file   
rawf.close()
