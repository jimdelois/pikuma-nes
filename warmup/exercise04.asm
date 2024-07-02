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

; Exercise 04
; This exercise is about adding and subtracting values. Adding and subtracting are math
; operations that are done by the processor ALU (arithmetic-logic-unit). Since the ALU can
; only manipulate values from the (A)ccumulator, all these additions and subtractions must
; be performed with the values in the A register.
RESET:
    cld    ; I forgot to add this, as a matter of good practice...

    ; Load the A register with the literal decimal value 100
    lda #100
    ; Add the decimal value 5 to the accumulator
    clc
    adc #5
    ; Subtract the decimal value 10 from the accumulator
    sec
    sbc #10
    ; Register A should now contain the decimal 95 (or $5F in hexadecimal)

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
