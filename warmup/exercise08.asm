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

; Exercise 08
; Your goal here is to create a loop that counts down from 10 to 0.
; You should also fill the memory addresses from $80 to $8A with values from 0 to A.

; E.g:
;       ___________________________________________________________________
; Addr: | $80 | $81 | $82 | $83 | $84 | $85 | $86 | $87 | $88 | $89 | $8A |
;       -------------------------------------------------------------------
;  Val: |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  A  |
;       -------------------------------------------------------------------
RESET:
    cld    ; I forgot to add this, as a matter of good practice...

    ; Initialize the Y register with the decimal value 10
    ldy #10
Loop:
    ; Transfer Y to A
    tya
    ; Store the value in A inside memory position $80+Y
    sta $80,y
    ; Decrement Y
    dey
    ; Branch back to "Loop" until we are done
    bpl Loop ; Instead of testing against ZERO, we test against NEGATIVE, which ensures we fill the last position of $80.

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
