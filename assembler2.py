import re

#Return a list containing every occurrence of "ai":
def calReg(opCodeStr,srcDest):
    
    numIndex = -1369789
    varNum = -1369789
    addressField = list("000000")
    Reg = re.findall("[R-r][0-9]", opCodeStr)
    
    #check if the str is register or not
    if('R' in opCodeStr or 'r' in opCodeStr):
    #check if the register number 
        if(Reg[0][1] == str(0)):
            addressField[3:] = "000"
        elif(Reg[0][1] == str(1)):
            addressField[3:] = "001"
        elif(Reg[0][1] == str(2)):
            addressField[3:] = "010"
        elif(Reg[0][1] == str(3)):
            addressField[3:] = "011"
        elif(Reg[0][1] == str(4)):
            addressField[3:] = "100"
        elif(Reg[0][1] == str(5)):
            addressField[3:] = "101"
        elif(Reg[0][1] == str(6)):
            addressField[3:] = "110"
    #check the register addressing mode
        #indexMode = re.findall("[0-9]+\(", instruction)
        
        #check auto inc
        if(")+" in opCodeStr):
            #indicating src
            if(srcDest == 0):
                addressField[0:2] = "01"
            #indicating dest
            else:
                addressField[1:3] = "01"
        #check auto dec
        elif("-(" in opCodeStr):
            #indicating src
            if(srcDest == 0):
                addressField[0:2] = "10"
            #indicating dest
            else:
                addressField[1:3] = "10"
                    
                        
        #check index
        #we need to insert the number in binary format
        indexMode = re.findall("[0-9]+\(", opCodeStr)
        if(len(indexMode) > 0):
            #indicating src
            if(srcDest == 0):
                addressField[0:2] = "11"
            #indicating dest
            else:
                addressField[1:3] = "11"
            numIndex = int(indexMode[0][0:len(indexMode[0])-1])

        #check indirect
        if("@" in opCodeStr):
            #indicating src
            if(srcDest == 0):
                addressField[2] = "0"
            #indicating dest
            else:
                addressField[0] = "0"
        else:
            #indicating src
            if(srcDest == 0):
                addressField[2] = "1"
            #indicating dest
            else:
                addressField[0] = "1"
    #str is related to variable
    else:
        #R7
        addressField[3:] = "111"
        #check the immediate mode
        if("#" in opCodeStr):
            #indicate src
            if(srcDest == 0):
                addressField[0:3] = "011"
            #indicate dest
            else:
                addressField[0:3] = "101"
           
        #indicating absolute mode
        else:
            #indicate src
            if(srcDest == 0):
                addressField[0:3] = "010"
            #indicate dest
            else:
                addressField[0:3] = "001"
        varNum = re.findall('\-*[0-9]+',opCodeStr)
        varNum = "".join(varNum)
    return addressField,int(numIndex),int(varNum)


inputFile = open("instructions.txt", "r")
outputFile = open("twoOperands.mem", "w")
outputFile.write('// memory data file (do not edit the following line - required for mem load use)\n')
outputFile.write('// instance=/ram/ram\n')
outputFile.write('// format=mti addressradix=h dataradix=s version=1.0 wordsperline=4\n')
machineInstructions = []
for instruction in inputFile:
    #determine if the instruction is one or two operand
    
    if(len(instruction) != 1):
        if(instruction[0:2] != "//"):
            oneTwoOp = instruction.find(',')
            #indicates variables
            if(instruction[0] == "#"):
                varNum = re.findall('\-*[0-9]+',instruction)
                varNum = "".join(varNum)
                varNum = int(varNum)
                signBit = '0'
                if(varNum < 0):
                        varNum = 32768 + int(varNum)
                        signBit = '1'
                else:
                    varNum = int(varNum)
                machineInstructions.append(signBit+f'{int(varNum):015b}')
                    
            #if two operand
            elif(oneTwoOp != -1):
                operationCode = list("0000")
                #determine the type of the operation
                if("mov" in instruction.lower()):
                    operationCode = "0110"
                elif("and" in instruction.lower()):
                    operationCode = "0010"
                elif("xnor" in instruction.lower()):
                    operationCode = "1010"
                elif("or" in instruction.lower()):
                    operationCode = "0011"
                elif("cmp" in instruction.lower()):
                    operationCode = "1011"
                elif("add" in instruction.lower()):
                    operationCode = "0100"
                elif("adc" in instruction.lower()):
                    operationCode = "0101"
                elif("sub" in instruction.lower()):
                    operationCode = "1100"
                elif("sbc" in instruction.lower()):
                    operationCode = "1101"

                #is OR
                if(operationCode == "0011"):
                    srcAddressField,srcIndex,srcVar = calReg(instruction[3:oneTwoOp],0)
                else:
                    srcAddressField,srcIndex,srcVar = calReg(instruction[4:oneTwoOp],0)
                destAddressField,destIndex,destVar = calReg(instruction[oneTwoOp+1:],1)
                srcAddressField = "".join(srcAddressField)
                destAddressField = "".join(destAddressField)
                machineInstructions.append(operationCode+srcAddressField+destAddressField)
                signBit = '0'
                if(srcIndex != -1369789):
                    machineInstructions.append(f'{int(srcIndex):016b}')
                if(srcVar != -1369789):
                    if(srcVar < 0):
                        srcVar = 32768 + int(srcVar)
                        signBit = '1'
                    else:
                        srcVar = int(srcVar)
                    machineInstructions.append(signBit+f'{int(srcVar):015b}')
                
                if(destIndex != -1369789):
                    machineInstructions.append(f'{int(destIndex):016b}')
                if(destVar != -1369789):
                    if(destVar < 0):
                        destVar = 32768 + int(destVar)
                        signBit = '1'
                    else:
                        destVar = int(destVar)
                    machineInstructions.append(signBit+f'{int(destVar):015b}')
            #if the instruction is one operand
            else: 
                isALU = False
                operationCode = list("0000000000")
                #determine the type of the operation
                if("inc" in instruction.lower()):
                    operationCode = "0000000001"
                    isALU = True
                elif("dec" in instruction.lower()):
                    operationCode = "0000000010"
                    isALU = True
                elif("clr" in instruction.lower()):
                    operationCode = "0000000011"
                    isALU = True
                elif("inv" in instruction.lower()):
                    operationCode = "0000000100"
                    isALU = True
                elif("lsr" in instruction.lower()):
                    operationCode = "0000000101"
                    isALU = True
                elif("ror" in instruction.lower()):
                    operationCode = "0000000110"
                    isALU = True
                elif("rrc" in instruction.lower()):
                    operationCode = "0000000111"
                    isALU = True
                elif("asr" in instruction.lower()):
                    operationCode = "0000001000"
                    isALU = True
                elif("lsl" in instruction.lower()):
                    operationCode = "0000001001"
                    isALU = True
                elif("rol" in instruction.lower()):
                    operationCode = "0000001010"
                    isALU = True
                elif("rlc" in instruction.lower()):
                    operationCode = "0000001011"
                    isALU = True
                
                if(isALU):
                    destAddressField,destIndex,destVar = calReg(instruction[4:],1)
                    destAddressField = "".join(destAddressField)
                    machineInstructions.append(operationCode+destAddressField)
                    if(destIndex != -1369789):
                        machineInstructions.append(f'{int(destIndex):016b}')
                    signBit = '0'
                    if(destVar != -1369789):
                        if(destVar < 0):
                            destVar = 32768 + int(destVar)
                            signBit = '1'
                        else:
                            destVar = int(destVar)
                        machineInstructions.append(signBit+f'{int(destVar):015b}')

                    
                #in case of branching , NOP , HLT instuctions
                else:
                    operationCode = list("0000000000000000")
                    if("nop" in instruction.lower()):
                        operationCode = "1110000000000000"
                    elif("hlt" in instruction.lower()):
                        operationCode = "1110000000000001"
                    elif("br" in instruction.lower()):
                        operationCode[0:8] = "11111000"
                    elif("beq" in instruction.lower()):
                        operationCode[0:8] = "11111001"
                    elif("bne" in instruction.lower()):
                        operationCode[0:8] = "11111010"
                    elif("blo" in instruction.lower()):
                        operationCode[0:8] = "11111011"
                    elif("bls" in instruction.lower()):
                        operationCode[0:8] = "11111100"
                    elif("bhi" in instruction.lower()):
                        operationCode[0:8] = "11111101"
                    elif("bhs" in instruction.lower()):
                        operationCode[0:8] = "11111110"
                    
                    operationCodeStr = "".join(operationCode)
                    if(operationCodeStr[0:5] == "11100"):
                        machineInstructions.append(operationCodeStr)
                    else:
                        offset = re.findall("[\+\-0-9]+", instruction)
                        signBit = '0'
                        #in case of -ve numbers do 2's complement
                        if(offset[0][0] == '-'):
                            offset = 128 - int(offset[0][1:])
                            signBit = '1'
                        else:
                            offset = int(offset[0])
                        machineInstructions.append(operationCodeStr[0:8]+signBit+str(f'{int(offset):07b}'))


for i in range(0,4000):
    if(i % 4 == 0):
        outputFile.write(hex(i)[2:]+': ')    
    if(i < len(machineInstructions)):
        outputFile.write(machineInstructions[i]+' ')
    else:
        outputFile.write("0000000000000000"+' ')
    if((i+1) % 4 == 0):
        outputFile.write('\n')    
