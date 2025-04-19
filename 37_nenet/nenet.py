# NENET Simulation data set calculator
# Prepares a binary file nenet_data.bin
# for storing calculated values
# the file will be used in VHDL simulations
# for compare and verification of hardware
# Author: Bilgehan ERKAL
# 16.03.2025 (dd.mm.yyyy)

# output array
no = []
# output cell address
# first row last element 
nrow = 0
ncol = 3
# number of rounds
# determines the number of data samples
n_round = 101

# initial data set
ndata = [ [0x3, 0x5, 0xe, 0x9],
          [0x1, 0xa, 0xf, 0xb],
	      [0x2, 0xc, 0x7, 0xd] ]
# temporary calculation storage
ndata_new = [ [0x3, 0x5, 0xe, 0x9],
              [0x1, 0xa, 0xf, 0xb],
	          [0x2, 0xc, 0x7, 0xd] ]

# calculate new nenet output value
def calc():
    # new_value = ((m1*m2)%16) + a1)%16
    for i in range(0,3):
        for j in range(0,4):
            ndata_new[i][j] = (((ndata[i][(j+3)%4]*ndata[(i+1)%3][j])%16) +
                                 ndata[(i+2)%3][j])%16
    # update ndata
    for i in range(0,3):
        for j in range(0,4):
            ndata[i][j] = ndata_new[i][j]
        
    # append new element to output array
    no.append(ndata[nrow][ncol])

# make necessary number of rounds    
for i in range (0,n_round):
    calc()

#convert data for writing to binary file   
send = bytes(bytearray(no))
# write to file
with open("nenet_data.bin", "wb") as rawf:
    rawf.write(send)

#read and dump the contents of the binary data file
with open("nenet_data.bin", "rb") as rawf:
    print(rawf.read(101))
 
