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
    ; Initialize the Y register with the decimal value 10
    ldy #10
    iny ; I have added this line and rearranged the list, below, to make sure that we
        ; still set $00 into $80 before breaking the loop
Loop:
    ; Decrement Y
    dey
    ; Transfer Y to A
    tya
    ; Store the value in A inside memory position $80+Y
    sta $80,y
    ; Branch back to "Loop" until we are done
    bne Loop

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
