; Recitation 6
; Author: Lingyang Zhu
; Date:   Sep.28 2016
; Email:  lyzhu@rams.colostate.edu
; Class:  CS270
;
; Description: Implements integer (16-bit) addition and subtraction
;
;------------------------------------------------------------------------------
; Begin reserved section: do not change ANYTHING in reserved section!

                .ORIG x3000
                BR Main

; A jump table defined as an array of addresses
Functions       .FILL IntAdd         ; address of add routine      (option 0)
                .FILL IntSub         ; address of subtract routine (option 1)
                .FILL IntMul         ; address of multiply routine (option 2)

Main            LEA R0,Functions     ; get base of jump table
                LD  R1,Option        ; get option to use, no error checking
                ADD R0,R0,R1         ; add index of array
                LDR R0,R0,0          ; get address of function
                JSRR R0              ; call selected function
                HALT

; Parameters and return values for all functions
Option          .FILL #0              ; which function to call
Param1          .FILL 0x1234              ; space to specify first parameter
Param2          .FILL 0x3456              ; space to specify second parameter
Result          .BLKW 1              ; space to store result

; End reserved section: do not change ANYTHING in reserved section!
;------------------------------------------------------------------------------
IntAdd                               ; Your code goes here
                LD R5,Param1
                LD R6,Param2
                ADD R7,R5,R6
                ST R7,Result         ; Solution has ~4 instructions
                RET
;------------------------------------------------------------------------------
IntSub                               ; Your code goes here
                                     ; Solution has ~6 instructions
                RET

;------------------------------------------------------------------------------
IntMul                               ; Your code goes here
                ST #0,R0
                LD R1,Param1
                BRz ; Solution has ~9 instructions
                RET

;------------------------------------------------------------------------------
               .END

