; P5 Assignment
; Author: <name>
; Date:   <date>
; Email:  <email>
; Class:  CS270
;
; Description: Implements the arithmetic, bitwise, and shift operations

;------------------------------------------------------------------------------
; Begin reserved section: do not change ANYTHING in reserved section!

                .ORIG x3000
                BR Main

; A jump table defined as an array of addresses
Functions       .FILL intAdd         ; (option 0)
                .FILL intSub         ; (option 1)
                .FILL intMul         ; (option 2)
                .FILL binaryOr       ; (option 3)
                .FILL leftShift      ; (option 4)
                .FILL rightShift     ; (option 5)

Main            LEA R0,Functions     ; get base of jump table
                LD  R1,Option        ; get option to use, no error checking
                ADD R0,R0,R1         ; add index of array
                LDR R0,R0,#0         ; get address of function
                JSRR R0              ; call selected function
                HALT

; Parameters and return values for all functions
Option          .FILL #0              ; which function to call
Param1          .FILL #5              ; space to specify first parameter
Param2          .FILL #2              ; space to specify second parameter
Result          .BLKW 1              ; space to store result

; End reserved section: do not change ANYTHING in reserved section!
;------------------------------------------------------------------------------

; You may add variables and functions after here as you see fit.

;------------------------------------------------------------------------------
intAdd                               ; Result is Param1 + Param2
                LD R1,Param1         ; Load Param1 to R1
                LD R2,Param2         ; Load Param2 to R2
                ADD R0,R1,R2         ; Add R1 and R2 and store to R0
                ST R0,Result         ; Store the result to result
                RET                     
;------------------------------------------------------------------------------
intSub                               ; Result is Param1 - Param2
                LD R1,Param1
                LD R2,Param2
                NOT R2,R2
                ADD R2,R2,#1
                ADD R0,R1,R2
                ST R0,Result         ; your code goes here (~6 lines)
                RET
;------------------------------------------------------------------------------
intMul                               ; Result is Param1 * Param2
                LD R1,Param1         ; Load the parameters
                LD R2,Param2         
                AND R0,R0,#0         ; Set R0 and R3 to 0 
                ADD R3,R0,#0         
Loop0           ADD R0,R0,R3         ; Start loop:R0 = R0 + R3
                ADD R3,R1,#0         ; R3 = R1
                ADD R2,R2,#-1        ; R2 = R2-1
                BRzp Loop0           ; Loop condition: R2 >= 0 
                ST R0,Result         ; Store the result
                RET
;------------------------------------------------------------------------------
binaryOr                             ; Result is Param1 | Param2
                LD R1,Param1
                LD R2,Param2
                NOT R1,R1
                NOT R2,R2
                AND R0,R1,R2
                NOT R0,R0
                ST R0,Result         ; your code goes here (~7 lines)
                RET
;------------------------------------------------------------------------------
leftShift                            ; Result is Param1 << Param2
                LD R1,Param1         ; Load the parameters
                LD R2,Param2
                AND R0,R0,#0         ; R0 = 0
                ADD R0,R0,R1
Loop1           ADD R0,R0,R0
                ADD R2,R2,#-1
                BRp Loop1
                ST R0,Result
                RET
;------------------------------------------------------------------------------
rightShift                           ; Result is Param1 >> Param2
                LD R1,Param1
                LD R2,Param2
                AND R0,R0,#0
                ADD R0,R0,#1
LoopM           ADD R0,R0,R0
                ADD R2,R2,#-1
                BRp LoopM
                AND R7,R7,#0
                ADD R6,R6,#1
Check           AND R5,R1,R0
                BRz NADD
                ADD R7,R7,R6
NADD            ADD R6,R6,R6
                ADD R0,R0,R0
                BRnp Check
                ST R7,Result; your code goes here (~16 lines)
                RET
;------------------------------------------------------------------------------
                .END


