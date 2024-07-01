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

; Exercise 05
; The ADC and SBC instructions can also be used with different addressing modes.
; The above exercise used ADC with immediate mode (adding a literal value directly
; into the accumulator), but we can also ask ADC to add a value from a (zero page)
; memory position into the accumulator.
RESET:
    ; Load the A register with the hexadecimal value $A
    lda #$0A
    ; Load the X register with the binary value %1010
    ldx #%00001010
    ; Store the value in the A register into (zero page) memory address $80
    sta $80
    ; Store the value in the X register into (zero page) memory address $81
    stx $81
    ; Load A with the decimal value 10
    lda #10
    ; Add to A the value inside RAM address $80
    clc
    adc $80
    ; Add to A the value inside RAM address $81
    clc
    adc $81
    ; A should contain (#10 + $A + %1010) = #30 (or $1E in hexadecimal)
    ; Store the value of A into RAM position $82
    sta $82


;;; End of program...
LoopForever:
    jmp LoopForever


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
