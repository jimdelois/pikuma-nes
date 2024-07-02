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

; EXCERCISE 01
; Your goal here is to simply load the processor registers A, X, and Y with some values.
RESET:
    cld    ; I forgot to add this, as a matter of good practice...

    ; Load the A register with the literal hexadecimal value $82
    lda #$82
    ; Load the X register with the literal decimal value 82
    ldx #82
    ; Load the Y register with the value that is inside memory position $82
    ldy $82

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
