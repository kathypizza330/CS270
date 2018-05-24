; Recitation 7
; Author: <name>
; Date:   <date>
; Email:  <email>
; Class:  CS270
; Description: Mirrors least significant byte to most significant
;--------------------------------------------------------------------------
; Begin reserved section: do not change ANYTHING in reserved section!

                .ORIG x3000

                JSR mirror           ; call function
                HALT

; Parameter and return value
Param           .FILL x1234          ; space to specify parameter
Result          .BLKW 1              ; space to store result

; Constants
One             .FILL #1             ; the number 1       
Eight           .FILL #8             ; the number 8
Mask            .FILL x00ff          ; mask top bits

; End reserved section: do not change ANYTHING in reserved section!
;--------------------------------------------------------------------------
mirror                               ; Mirrors bits 7:0 to 15:8
                                     ; ~20 lines of assembly code
 
                LD R0,Param          ; load pattern
                ADD R1,R0,#0         ; A copy of R0 which stores the result
                LD R2,Mask
                AND R1,R1,R2         ; Clear bits 15:8 in R1
                .ZERO R2
                ADD R2,R2,#1         ; Source mask R2
                .COPY R3,R2          ; Destination mask R3
                .ZERO R4
                ADD R4,R4,#8         ; Counter R4 = 8
LOOP1           ADD R3,R3,R3
                ADD R4,R4,#-1
                BRp LOOP1            ; Left shift R3 by 8 bits
                .ZERO R4
                ADD R4,R4,#8         ; Counter R4 = 8
LOOP2           AND R5,R2,R1
                BRz Lab1
                ADD R1,R3,R1
Lab1            ADD R2,R2,R2         ; Shift the source mask R2 left
                ADD R3,R3,R3         ; Shift the destination mask R3 left
                ADD R4,R4,#-1        ; Decrement the counter
                BRp LOOP2
                ST R1,Result         ; store result
                RET
;--------------------------------------------------------------------------
               .END

