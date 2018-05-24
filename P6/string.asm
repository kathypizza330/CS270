; Begin reserved section: do not change ANYTHING in reserved section!
;------------------------------------------------------------------------------
; Author: Fritz Sieker
;
; Description: Tests the implementation of a simple string library and I/O
;
; The ONLY exception to this is that you MAY change the .FILL values for
; Option, Value1 and Value2. this makes it easy to initialze the values in the
; program, so that you do not need to continually re-enter them. This
; makes debugging easier as you need only change your code and re-assemble.
; Your test value(s) will already be set.

            .ORIG x3000
            BR Main
Functions
            .FILL Test_pack         ; (option 0)
            .FILL Test_unpack       ; (option 1)
            .FILL Test_printCC      ; (option 2)
            .FILL Test_strlen       ; (option 3)
            .FILL Test_strcpy       ; (option 4)
            .FILL Test_strcat       ; (option 5)
            .FILL Test_strcmp       ; (option 6)

; Parameters and return values for all functions
Option      .FILL 6                 ; which function to call
String1     .FILL x4000             ; default location of 1st string
String2     .FILL x4100             ; default location of 2nd string
Result      .BLKW 1                 ; space to store result
Value1      .FILL 0x0000                 ; used for testing pack/unpack
Value2      .FILL 0x0000                 ; used for testing pack/unpack
lowerMask   .FILL 0x00FF            ; mask for lower 8 bits
upperMask   .FILL 0xFF00            ; mask for upper 8 bits

Main        LEA R0,Functions        ; get base of jump table
            LD  R1,Option           ; get option to use, no error checking
            ADD R0,R0,R1            ; add index of array
            LDR R0,R0,#0            ; get address to test
            JMP R0                  ; execute test

Test_pack   
            LD R0,Value1            ; load first character
            LD R1,Value2            ; load second character
            JSR pack                ; pack characters
            ST R0,Result            ; save packed result
            HALT                    ; done - examine Result

Test_unpack 
            LD R0,Value1            ; value to unpack
            JSR unpack              ; test unpack
            ST R0,Value1            ; save upper 8 bits
            ST R1,Value2            ; save lower 8 bits
            HALT                    ; done - examine Value1 and Value2

Test_printCC    
            LD R0,Value1            ; get the test value
            .ZERO R1                ; reset condition codes
            JSR printCC             ; print condition code
            HALT                    ; done - examine output

Test_strlen 
            LD R0,String1           ; load string pointer
            GETS                    ; get string
            LD R0,String1           ; load string pointer
            JSR strlen              ; calculate length
            ST R0,Result            ; save result
            HALT                    ; done - examine memory[Result]

Test_strcpy 
            LD R0,String1           ; load string pointer
            GETS                    ; get string
            LD R0,String2           ; R0 is dest
            LD R1,String1           ; R1 is src
            JSR strcpy              ; copy string
            PUTS                    ; print result of strcpy
            NEWLN                   ; add newline
            HALT                    ; done - examine output

Test_strcat 
            LD R0,String1           ; load first pointer
            GETS                    ; get first string
            LD R0,String2           ; load second pointer
            GETS                    ; get second string
            LD R0,String1           ; dest is first string
            LD R1,String2           ; src is second string
            JSR strcat              ; concatenate string
            PUTS                    ; print result of strcat
            NEWLN                   ; add newline
            HALT                    ; done - examine output

Test_strcmp 
            LD R0,String1           ; load first pointer
            GETS                    ; get first string
            LD R0,String2           ; load second pointer
            GETS                    ; get second string
            LD R0,String1           ; dest is first string
            LD R1,String2           ; src is second string
            JSR strcmp              ; compare strings
            JSR printCC             ; print result of strcmp
            HALT                    ; done - examine output

;------------------------------------------------------------------------------
; End of reserved section
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; on entry R0 contains first value, R1 contains second value
; on exit R0 = (R0 << 8) | (R1 & 0xFF)

pack        LD R3,lowerMask         ; R3 is the lowermask
            AND R4,R3,R0            ; R4 contains the lower 8 bits in R0
            AND R0,R3,R1            ; R0 contains the lower 8 bits in R1
            .ZERO R5
            ADD R5,R5,#8            ; Counter R5 = 8
Loop1       ADD R4,R4,R4            ; Left shift R4 8 times
            ADD R5,R5,#-1
            BRp Loop1
            ADD R0,R0,R4            ; R0 contains the result
            RET

;------------------------------------------------------------------------------
; on entry R0 contains a value
; on exit R0 contains upper 8 bits, R1 contains lower 8 bits (see instructions
; for more details)

unpack      LD R3,lowerMask      ; R3 is the lowermask
            LD R4,upperMask      ; R4 is the uppermask
            AND R1,R3,R0         ; R1 contains the lower 8 bits in R0
            
            .ZERO R2
            ADD R3,R2,#8
            ADD R2,R2,#1
LeftShift   ADD R2,R2,R2
            ADD R3,R3,#-1
            BRp LeftShift        ; R2 is the mask

            .ZERO R5
            ADD R6,R5,#1
Check       AND R4,R2,R0
            BRz NADD
            ADD R5,R6,R5
NADD        ADD R6,R6,R6
            ADD R2,R2,R2
            BRnp Check
            ADD R0,R5,#0
            RET

;------------------------------------------------------------------------------
; on entry R0 contains value
; on exit "NEGATIVE/ZERO/POSITIVE" printed, followed by newline (see
; instructions for more details)

StringNEG   .STRINGZ "NEGATIVE\n"   ; output strings
StringZERO  .STRINGZ "ZERO\n"
StringPOS   .STRINGZ "POSITIVE\n"

printCC     ADD R1,R0,#0
            BRp printP
            BRz printZ
            BRn printN
printP      LEA R0,StringPOS
            BR finishP
printZ      LEA R0,StringZERO
            BR finishP
printN      LEA R0,StringNEG
            BR finishP
finishP     
            PUTS
            ADD R0,R1,#0
            RET

;------------------------------------------------------------------------------
; size_t strlen(char *s)
; on entry R0 contains pointer to string
; on exit R0 contains length of string (see instructions for more details)

strlen      ADD R1,R0,#0            ; now
            .ZERO R2                ; R2 is the counter
Checkend    LDR R3,R1,#0
            BRz donel
            ADD R1,R1,#1
            ADD R2,R2,#1
            BR Checkend
donel       ADD R0,R2,#0
            RET

;------------------------------------------------------------------------------
; char *strcpy(char *dest, char *src)
; on entry R0 contains dest, R1 contains src
; on exit  R0 contains dest (see instructions for more details)

strcpy      ADD R2,R0,#0            ; Pointer to dest
            ADD R3,R1,#0            ; Pointer to src
CopyC       LDR R4,R3,#0            ; Lode a character to R4
            BRz donec
            STR R4,R2,#0            ; Store it to dest
            ADD R2,R2,#1
            ADD R3,R3,#1
            BR CopyC
donec       RET

;------------------------------------------------------------------------------
; char *strcat(char *dest, char *src)
; on entry R0 contains dest, R1 contains src
; on exit R0 contains dest (see instructions for more details)

strcat_RA   .BLKW 1                 ; space for return address
strcat_dest .BLKW 1                 ; space for dest
strcat_src  .BLKW 1                 ; space for src

strcat      ST R7,strcat_RA         ; save return address
            ST R0,strcat_dest       ; save dest
            ST R1,strcat_src        ; save src
            
            ADD R2,R0,#0            ; Pointer to dest
            ADD R3,R1,#0            ; Pointer to src
Check000    LDR R4,R2,#0
            BRz Goon
            ADD R2,R2,#1
            BR Check000
Goon        LDR R4,R3,#0
            BRz donecat
            STR R4,R2,#0
            ADD R2,R2,#1
            ADD R3,R3,#1
            BR Goon
donecat
            LD R0,strcat_dest       ; restore dest
            LD R7,strcat_RA         ; restore return address
            RET

;------------------------------------------------------------------------------
; int strcmp(char *s1, char *s2)
; on entry R0 contains s1, R1 contains s2
; on exit R0 contains the result of the comparison (see instructions for more
; details)

strcmp      ADD R2,R0,#0            ; Pointer to dest
            ADD R3,R1,#0            ; Pointer to src
            .ZERO R0
Check001    LDR R4,R2,#0
            BRz s1end
Check002    LDR R5,R3,#0
            BRz s2end
            ADD R2,R2,#1
            ADD R3,R3,#1
            NOT R5,R5
            ADD R5,R5,#1
            ADD R5,R4,R5
            BRp s1small
            BRz Check001
            BRn s2small
s1small     ADD R0,R0,-1
            BR donecmp
s2small     ADD R0,R0,#1
            BR donecmp
s2end       ADD R5,R4,R5
            BRp s2small
            BRz donecmp
s1end       LDR R5,R3,#0
            ADD R5,R4,R5
            BRnp s1small
donecmp
            RET

;------------------------------------------------------------------------------
                .END

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
