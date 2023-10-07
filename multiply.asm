; Multiplication on the 6502
; Jack Boucher 

                ; Number Variables
NUMA = $34 
NUMB = $08 

                ; Storage Variables
STOREA = $0100
STOREB = $0101
STOREV = $0102

                ; Initializing
START:
    JSR MULTIPLY
END:
    LDA STOREV
    BRK         ; Break at end

MULTIPLY:
                ; Load values
    LDA #NUMA
    STA STOREA
    LDA #NUMB
    STA STOREB
    JSR SMALLER
    CPX #0
    BEQ END
    JSR CYCLE
    JMP END

                ; start of shift addition
CYCLE:
    CLC 
                ; get last digit of x as carry
    PHA
    TXA
    ROR 
    TAX
    BCC ZERO    ; skip addition for this digit
     PLA
     PHA
     JMP NZERO
                ; Check if we're done multiplying
    ZERO: LDA #0
    NZERO: 
        CLC
        ADC STOREV
        STA STOREV
        CLC 
        CPX #0
        BEQ END
         CLC
         PLA
         ASL 
         JMP CYCLE
RTS
                ; Function to determine which is smaller
SMALLER:
    CMP STOREA
    BCC NOCARRY
    CLC
    LDX STOREA
RTS
NOCARRY:
    TAX
    LDA STOREA
RTS