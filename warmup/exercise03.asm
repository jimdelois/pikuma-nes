;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; iNES Header - 16 bytes                                    ;;
;; - See https://www.nesdev.org/wiki/INES                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRG-ROM Application Execution Code                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.org $8000

; Exercise 03
; This exercise is about transferring values from registers to other registers.
RESET:
    cld    ; I forgot to add this, as a matter of good practice...

    ; Load the A register with the literal decimal value 15
    lda #15
    ; Transfer the value from A to X
    tax
    ; Transfer the value from A to Y
    tay
    ; Transfer the value from X to A
    txa
    ; Transfer the value from Y to A
    tya
    ; Load X with the decimal value 6
    ldx #6
    ; Transfer the value from X to Y
;    stx $00
;    ldy $00
    ; Course instruction suggests using A instead of a memory slot as I had done, above...
    txa
    tay

    ; Creating this infinite loop makes it easier to debug multiple times in a row.
    jmp RESET


NMI:
    rti

IRQ:
    rti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "Vectors" to define Interrupts and Starts/Restarts        ;;
;;  - Must always be the very last bytes of the program      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "VECTORS"
.org $FFFA
.word NMI
.word RESET
.word IRQ
