; Problem 1 (Counting up to 9 in the top left corner)

lda #$31
LOOP:
sta $0400
inca
cmpa #$39
ble LOOP
rts



; fibonacci sequence const screen=$400

screen EQU $0400

lda #$30
ldx #$31
ldy #screen
bra print

fibonacci:
tfr a, b
abx
tfr x, a
suba #$30
cmpa #$38
beq done
tfr b, x
bra print

print:
sta ,y+

bra fibonacci

done:
sta ,y+
rts



; problem 3 part a

screen EQU $0400

START:
 ldy #screen
 jsr main
 rts

main:
 ldd #$FDCB
 pshu d, a
 jsr convert
 tfr b,a 
 jsr convert
 lda #$20
 sta ,y+
 ldd #$1234
 pshu d, a
 jsr convert
 tfr b,a
 jsr convert
 rts

convert:
 lsra
 lsra
 lsra
 lsra
 jsr Check
 pulu a
 anda #$f
 jsr Check
 rts

Check: 
cmpa #$0A
bge PrintLetter
ble PrintNumber

PrintLetter:
 suba #$09
 sta ,y+
 rts

PrintNumber:
 adda #$30
 sta ,y+
 rts



 ;Problem 3 part 2 (fibonacci hexadecimal)

screen EQU $0400

START:
 ldy #screen
 ldd #$0000
 ldx #$0001
 jsr MAIN
 rts

MAIN:
 pshu d
 pshu a
 jsr CONVERT
 tfr b,a
 pshu b 
 jsr CONVERT
 pulu a
 bra FIB

DONE:
 rts

FIB:
 pshu d
 pshu x
 addd ,U
 pulu x
 pulu x
 cmpd #$2511
 beq DONE
 pshu a
 lda #$2C
 sta ,y+
pulu a
 bra MAIN

CONVERT:
 lsra
 lsra
 lsra
 lsra
 jsr CHECK
 pulu a
 anda #$f
 jsr CHECK
 rts

CHECK: 
 cmpa #$0A
 bge PRINTLETTER
 ble PRINTNUMBER

PRINTLETTER:
 suba #$09
 sta ,y+
 rts

PRINTNUMBER:
 adda #$30
 sta ,y+
 rts
