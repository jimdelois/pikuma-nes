;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; iNES Header - 16 bytes                                    ;;
;; - See https://www.nesdev.org/wiki/INES                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "HEADER"
.org $7FF0
; We condense this mostly "standard" header by "inlining" all of the 16 bytes
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRG-ROM Application Execution Code                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.org $8000

NMI:
    rti

RESET:
    sei
    cld
    ldx #$FF
    txs

    ;;; Now the meat of the program: Loop over all addresses $00 to $FF and clear them all out
    lda #$00                       ; Load the literal decimal value of 0 into A
    inx                           ; X now holds $00. This means the following iteration will first set this
                                  ; memory position of $00 to 0, then the "dex" argument, below, will then
                                  ; decrement it "around" the limit to $FF. Then the one-off bug of missing
                                  ; address $00 is thus solved.
MemLoop:
    sta $00,x
    dex
    bne MemLoop

    ;;; This is a better way to "end" a program like this, as opposed to running on to the "rti" line of IRQ, below.
LoopForever:
    jmp LoopForever

IRQ:
    rti                           ; Simply Return from Interrupt (rti)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "Vectors" to define Interrupts and Starts/Restarts        ;;
;;  - Must always be the very last bytes of the program      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "VECTORS"
.org $FFFA
.word NMI
.word RESET
.word IRQ
