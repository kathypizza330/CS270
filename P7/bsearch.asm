;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of reserved section - DO NOT CHANGE ANYTHING HERE!!!
; The only exception is that you can modify the .FILL value of Needle to make
; it easy to test.

                .ORIG x3000
                BR Main

; Stack base
Stack           .FILL x4000

; Parameter and result
Needle          .FILL #9
Result          .FILL xFFFF

; Entry point
Main            LD    R6, Stack           ; Stack initialization
                LD    R5, Stack           ;
                
                LD    R0, Count           ; Load the number of elements
                LEA   R1, Haystack        ; Load loAddress
                LD    R2, Needle          ; Load the element to search for
                
                AND   R3, R3, #0          ; Calculate hiAddress
                ADD   R3, R3, #-1         ;
                ADD   R3, R0, R3          ;
                ADD   R3, R1, R3          ;
                PUSH  R3                  ; Push parameters in reverse order
                PUSH  R1                  ;
                PUSH  R2                  ;
                JSR   BinarySearch        ; Call BinarySearch
                POP   R0                  ; Retrieve the return value
                ADD   R6, R6, #3          ; Clean up
                
                ST    R0, Result          ; Store the result in global variable
Finish          HALT
                
; End of reserved section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of the array definition - DO NOT CHANGE THE LABEL NAMES OR POSITIONS!!!
; In this section, you're only allowed to change the .FILL value for Count
; (number of elements in the array) and the .FILL values of the array but DO NOT
; delete or add any lines in this section (otherwise, you risk getting no
; credit). If you want fewer elements in the array, simply change Count. You
; won't have to deal with more than 20 elements in the array.

Count           .FILL #7

Haystack        .FILL #2
                .FILL #4
                .FILL #6
                .FILL #8
                .FILL #10
                .FILL #12
                .FILL #14
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0
                .FILL #0

; End of the array definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of the function definition
; This is where you will implement your BinarySearch function. DO NOT implement
; any other functions (not even helper functions).

; int *BinarySearch(int x, int *loAddress, int *hiAddress);
BinarySearch    ADD R6,R6,#-1       ; Step 3 Allocate space for return value
                PUSH R7             ; Step 4 Store return address
                PUSH R5             ; Step 5 Store previous frame pointer
                ADD R5,R6,#-1       ; Step 6 Set frame pointer
                .ZERO R0            ; Step 7 Push the local variables
                PUSH R0             ; R0 = midOffset
                .ZERO R1
                PUSH R1             ; R1 = midAddress
                LDR R2,R5,#6        ; R2 = hiAddress
                LDR R3,R5,#5        ; R3 = loAddress
                NOT R4,R2
                ADD R4,R4,#1        ; R4 = -hiAddress
                ADD R4,R3,R4        ; R4 = loAddress - hiAddress
                BRnz GOON           ; Base case
                .ZERO R4
                STR R4,R5,#3        ; return 0 when loAddress > hiAddress
                BR DONE
                
GOON            NOT R4,R4           ; Not the base case
                ADD R4,R4,#1        ; R4 = hiAddress - loAddress
                
                ; Goal: R3 = R4 / 2 ( leftshift once )
                .ZERO R0
                .ZERO R3
                ADD R0,R0,#1
                ADD R0,R0,R0
                .ZERO R1
                ADD R1,R1,#1
CheckleftShift  AND R2,R0,R4
                BRz NADD
                ADD R3,R3,R1
NADD            ADD R1,R1,R1
                ADD R0,R0,R0
                BRnp CheckleftShift
                ; Goal reached
                
                STR R3,R5,#0        ; R3 = midOffset = (hiAddress - loAddress)
                LDR R0,R5,#5        ; R0 = loAddress
                ADD R1,R0,R3        ; R1 = midAddress = loAddress + midOffset
                STR R1,R5,#-1       ; midAddress stored
                LDR R2,R5,#4        ; R2 = x
                LDR R3,R1,#0        ; R3 = *midAddress
                NOT R4,R3
                ADD R4,R4,#1        ; R4 = -*midAddress
                ADD R4,R4,R2
                BRz FOUND
                BRn GO2lower
                BRp GO2upper
FOUND           STR R1,R5,#3
                BR DONE
                
GO2lower        ADD R1,R1,#-1
                PUSH R1             ; push midAddress-1
                PUSH R0             ; push loAddress
                PUSH R2             ; push x
                JSR BinarySearch
                POP R4              ; R4 is the result
                STR R4,R5,#3
                ADD R6,R6,#3
                BR DONE
                
GO2upper        LDR R4,R5,#6        ; R4 = hiAddress
                PUSH R4             ; push hiAddress
                ADD R4,R1,#1        ; R4 = midAddress+1
                PUSH R4             ; push midAddress+1
                PUSH R2             ; push x
                JSR BinarySearch
                POP R4              ; R4 is the result
                STR R4,R5,#3
                ADD R6,R6,#3
                BR DONE
                
DONE            ADD R6,R6,#2
                POP R5
                POP R7
                ; My solution was 75 lines (including empty lines and comments)
                RET

; End of the function definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                .END
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
