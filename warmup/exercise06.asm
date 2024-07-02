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

; Excercise 06
; This exercise covers the increment and decrement instructions of the 6502.
RESET:
    cld    ; I forgot to add this, as a matter of good practice...

    ; Load the A register with the decimal value 1
    lda #1
    ; Load the X register with the decimal value 2
    ldx #2
    ; Load the Y register with the decimal value 3
    ldy #3
    ; Increment X
    inx
    ; Increment Y
    iny
    ; Increment A
    clc
    adc #1
    ; Decrement X
    dex
    ; Decrement Y
    dey
    ; Decrement A
    sec
    sbc #1

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
