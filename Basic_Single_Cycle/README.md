# Mips single cycle processor

very basic draw of schemas is located in /Schematka

The cpu implements following instructoins:

## ADD - oppcode = **000000**, funct = **100000**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Adds two registers and stores the result in a register | 
| Operation: | $d = $s + $t; |
| Syntax: | add $d, $s, $t | 
| Encoding: | 0000 00ss ssst tttt dddd d000 0010 0000 |

```
RegWrite = 1'b 	1;
RegDest = 1'b   1;
ALUSrc = 1'b    0;
ALUOp = 2'b		10;
Branch_eq = 1'b 0;
Branch_ne = 1'b 0;
MemWrite = 1'b  0;
MemToReg = 1'b  0;
JAL = 1'b       0;
ALUControl = 3'b010;
```

## AND - oppcode = **000000**, funct = **100100** 

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Bitwise ands two registers and stores the result in a register |
| Operation: | $d = $s & $t; |
| Syntax: | and $d, $s, $t |
| Encoding: | 0000 00ss ssst tttt dddd d000 0010 0100 |


## OR - oppcode = **000000**, funct = **100101**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Bitwise logical ors two registers and stores the result in a register |
| Operation: | $d = $s \| $t; | 
| Syntax:- | or $d, $s, $t |
| Encoding: | 0000 00ss ssst tttt dddd d000 0010 0101 |


## SLT - oppcode = **000000**, funct = **101010**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | If $s is less than $t, $d is set to one. It gets zero otherwise. |
| Operation: | if $s < $t $d = 1; else $d = 0; |
| Syntax: | slt $d, $s, $t |
| Encoding: | 0000 00ss ssst tttt dddd d000 0010 1010 |


## SLL - oppcode = **000000**, funct = **000000**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | shifts shamt number of bits to the left | 
| Operation: | $d = $t << shamt; | 
| Syntax: | sll $d, $t, shamt |
| Encoding: | 0000 00-- ---t tttt dddd dhhh hh00 0000 |


## SRL - oppcode = 000000, funct = 000010

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | shifts shamt number of bits to the right |
| Operation: | $d = $t >> shamt; | 
| Syntax: | srl $d, $t, shamt |
| Encoding: | 0000 00-- ---t tttt dddd dhhh hh00 0010 |


## SUB - oppcode = **000000**, funct = **100010**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Subtracts two registers and stores the result in a register |
| Operation: | $d = $s - $t; |
| Syntax: | sub $d, $s, $t |
| Encoding: | 0000 00ss ssst tttt dddd d000 0010 0010 |

## JR - oppcode = **000000**, funct = **001000**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Jumps to the address contained in the specified register |
| Operation: | goto address $s |
| Syntax: | jr $s |
| Encoding: | 0000 00ss sss0 0000 0000 0000 0000 1000 |


## ADDI - oppcode = **001000** 

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Adds a register and a sign-extended immediate value and stores the result in a register |
| Operation: | $t = $s + imm; |
| Syntax: | addi $t, $s, imm |
| Encoding: | 0010 00ss ssst tttt iiii iiii iiii iiii |
```
RegWrite = 1'b1;
RegDest = 1'b0;
ALUSrc = 1'b1;
ALUOp = 2'b00;
Branch_eq = 1'b0;
Branch_ne = 1'b0;
MemWrite = 1'b0;
MemToReg = 1'b0;
JAL = 1'b0;
ALUControl = 3'b010;
```


## BEQ - oppcode = **000100**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Branches if the two registers are equal | 
| Operation: | if $s == $t go to PC+4+4\*offset; else go to PC+4 | 
| Syntax: | beq $s, $t, offset |
| Encoding: | 0001 00ss ssst tttt iiii iiii iiii iiii |
```
RegWrite = 1'b0;
RegDest = 1'b0;
ALUSrc = 1'b0;
ALUOp = 2'b01;
Branch_eq = 1'b1;
Branch_ne = 1'b0;
MemWrite = 1'b0;
MemToReg = 1'b0; 
JAL = 1'b0;
ALuControl = 3'b110;
```
## BNE - oppcode = **000101**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | Branches if the two registers are not equal |
| Operation: | if $s != $t go to PC+4+4\*offset; else go to PC+4 |
| Syntax: | bne $s, $t, offset |
| Encoding: | 0001 01ss ssst tttt iiii iiii iiii iiii |
```
RegWrite = 1'b0;
RegDest = 1'b0;
ALUSrc = 1'b0;
ALUOp = 2'b01;
Branch_eq = 1'b0;
Branch_ne = 1'b1;
MemWrite = 1'b0;
MemToReg = 1'b0; 
JAL = 1'b0;
ALUControl = 3'b110;
```

## LW - oppcode = **100011**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | A word is loaded into a register from the specified address. |
| Operation: | $t = MEM\[$s + offset\]; |
| Syntax: | lw $t, offset($s) |
| Encoding: | 1000 11ss ssst tttt iiii iiii iiii iiii | 
```
RegWrite = 1'b1;
RegDest = 1'b0;
ALUSrc = 1'b1;
ALUOp = 2'b00;
Branch_eq = 1'b0;
Branch_ne = 1'b0;
MemWrite = 1'b0;
MemToReg = 1'b1;
JAL = 1'b0;
ALUControl = 3'b010;
```

## SW - oppcode = **101011**

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | The contents of $t is stored at the specified address. |
| Operation: | MEM\[$s + offset\] = $t; |
| Syntax: | sw $t, offset($s) |
| Encoding: | 1010 11ss ssst tttt iiii iiii iiii iiii |
```
RegWrite = 1'b0;
RegDest = 1'b0;
ALUSrc = 1'b1;
ALUOp = 2'b00;
Branch_eq = 1'b0;
Branch_ne = 1'b0;
MemWrite = 1'b1;
MemToReg = 1'b0;
JAL = 1'b0;
ALUControl = 3'b010; 
```

## JAL - oppcode = 000011

- [x] implemented
- [x] tested

|    |                        |
| -- | ---------------------- |
| Description: | For procedure call. | 
| Operation: | $31 = PC + 8; PC = (PC & 0xf0000000) \| (target << 2) |
| Syntax: | jal target |
| Encoding: | 0000 11ii iiii iiii iiii iiii iiii iiii |
```
RegWrite = 1'b1;
RegDest = 1'b0;
ALUSrc = 1'b0;
ALUOp = 2'b00;
Branch_eq = 1'b0;
Branch_ne = 1'b0;
MemWrite = 1'b0;
MemToReg = 1'b0;
JAL = 1'b1;
ALUControl = 3'b010; // xxx
```
