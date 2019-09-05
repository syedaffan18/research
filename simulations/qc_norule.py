#import numpy as np

from sympy import symbols,simplify

#box simulations 
#binary number conversion 
def bin_c(x,b):
    binNumber = bin(x)[2:]
    appBits = b - len(binNumber)
    if appBits < 0:
        return "not possible"
    binNumber = binNumber.zfill(appBits + (len(binNumber)))
    return binNumber
##
##box = np.matrix([],
##                [],
##                [],
##                [],
##                [],
##                [],
##                [],
##                [])

#box = np.full((8,8),1/8)

x = symbols('x')
y = symbols('y')

##box =          ([1/4,0,0,1/4,0,1/4,1/4,0],
##                [1/4,0,0,1/4,0,1/4,1/4,0],
##                [1/4,0,0,1/4,0,1/4,1/4,0],
##                [1/4,0,0,1/4,0,1/4,1/4,0],
##                [1/4,0,0,1/4,0,1/4,1/4,0],
##                [1/4,0,0,1/4,0,1/4,1/4,0],
##                [1/4,0,0,1/4,0,1/4,1/4,0],
##                [0,1/4,1/4,0,1/4,0,0,1/4])

box =          ([1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8],
                [1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8],
                [1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8],
                [1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8],
                [1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8],
                [1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8],
                [1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8],
                [1/8 - x/8,1/8 + x/8,1/8 + x/8,1/8 - x/8,1/8 + x/8,1/8 - x/8,1/8 - x/8,1/8 + x/8])



def fn(inp,f): #concatenating input1, out1, out2 to calculate the value of the function
    idx = int (inp,2)
    val = bin_c(f,2**(len(inp)))[idx]
    return val 
    


def nlb():

    corr = 0
    count = 0
    f2 = int('0011',2) #int local stochastic function for alice 
    g2 = int('0011',2) #int local stochastic function for bob
    h2 = int('0011',2) #int local stochastic function for charlie
    f3 = int('01101001',2) #int local stochastic function for alice 
    g3 = int('01101001',2) #int local stochastic function for bob
    h3 = int('01101001',2) #int local stochastic function for charlie
##
##    for f3 in range (0,255):
##        for g3 in range (0,255):
##            for h3 in range (0,255):
    wired = ([0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0])

    for i in range (0,8): #inputs 
        inp1 = bin_c (i,3) #input to the first box
        x = int(inp1[0])
        y = int(inp1[1])
        z = int(inp1[2])
        for j in range (0,8): #outputs
            out1 = bin_c(j,3) #output to the first box
            prob1 = box[i][j] 
            #print ("prob[",inp1,"][",out1,"]",   prob1)
            #the input to the second box is the same as that of the first box 
            for k in range (0,8):
                out2 = bin_c(k,3)#output to the second box
                prob2 = box[i][k]
                aliceBits = inp1[0]+out1[0]+out2[0]
                bobBits = inp1[1]+out1[1]+out2[1]
                charBits = inp1[2]+out1[2]+out2[2]
                #final bits of alice, bob, and charlie
                a = int(fn(aliceBits,f3))
                b = int(fn(bobBits,g3))
                c = int(fn(charBits,h3))

                #print ("input", i)

               #wired[i][int(str(a)+str(b)+str(c),2)]= str(wired[i][int(str(a)+str(b)+str(c),2)]) +  "+" + str((prob1*prob2))

                wired[i][int(str(a)+str(b)+str(c),2)] = wired[i][int(str(a)+str(b)+str(c),2)] + (prob1*prob2)
                
##                            if (a ^ b ^ c == x & y & z):
##                                corr = corr + (prob1*prob2)
####                                print(str(a)+str(b)+str(c),"==", str(x)+str(y)+str(z))
####                                print("satisfied", "corr: ", corr)
##                            else:
##                                corr = corr - (prob1*prob2)
####                                print(str(a)+str(b)+str(c),"==", str(x)+str(y)+str(z))
####                                print("satisfied", "corr: ", corr)
    print ("Wiring for f3: ,",f3, "for g3: ",g3, "for h3: ", h3)
    beautify(wired)
    print ('\n')
  
    
    #corr = 0

def beautify(matrix):
    s = [[str(e) for e in row] for row in matrix]
    lens = [max(map(len, col)) for col in zip(*s)]
    fmt = '\t'.join('{{:{}}}'.format(x) for x in lens)
    table = [fmt.format(*row) for row in s]
    print ('\n'.join(table))                 
                

nlb()
            

            
                
                

            

            
            
