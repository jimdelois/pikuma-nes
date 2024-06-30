;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; iNES Header - 16 bytes                                    ;;
;; - See https://www.nesdev.org/wiki/INES                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "HEADER"
.org $7FF0                        ; This can be any address BEFORE $8000
                                  ; - We chose $7FF0 because we know the header is precisely 16 bytes anyway.

.byte $4E,$45,$53,$1A             ; 4-bytes that spell "NES\n" - required Header start
.byte $02                         ; How many x16KB of PRG-ROM (Program ROM) to use (2x16=32KB here)
.byte $01                         ; How many x8KB of CHR-ROM (Character ROM) to user (1x8=8KB here)
.byte %00000000                   ; Flags 6: Horiz mirroring, no battery, no mapper (0), etc. - https://www.nesdev.org/wiki/INES#Flags_6
.byte %00000000                   ; Flags 7: Mapper, VS/Playchoice, NES 2.0, etc - https://www.nesdev.org/wiki/INES#Flags_7
.byte $00                         ; Flags 8: PRG-RAM size (rarely used) - No PRG-RAM here - https://www.nesdev.org/wiki/INES#Flags_8
.byte $00                         ; Flags 9: TV System (rarely used) - 0 = NTSC - https://www.nesdev.org/wiki/INES#Flags_9
.byte $00                         ; Flags 10: TV System, PRG-RAM Presence (rarely used) - https://www.nesdev.org/wiki/INES#Flags_10
.byte $00,$00,$00,$00,$00         ; Unused padding to complete the full 16 byte iNES header

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRG-ROM Application Execution Code (always at $8000)      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.org $8000

NMI:
    rti                           ; Simply Return from Interrupt (rti)

RESET:
    sei                           ; Disable all IRQ interrupts
    cld                           ; Clear Decimal Mode (not supported by NES, but done as a matter of practice)

    ;;; This is another set of common instructions done as a matter of good practice
    ldx #$FF                      ; Store the literal hexidecimal of "$FF" into X
    txs                           ; Transfer X to Stack Pointer register, this is the lowest possible place for the
                                  ; stack, $01FF. In initializing the pointer to that address, we effectively clear the stack

    ;;; Now the meat of the program: Loop over all addresses $00 to $FF and clear them all out

    lda #0                        ; Load the literal decimal value of 0 into A
    ldx #$FF                      ; Load this highest value of the possible memory positions into X
MemLoop:
    sta $00,x                     ; "sta {addr}" stores the value of A into a given address
                                  ; By specifying $00,x, we are telling it to use the value stored in X and add $00 to it
                                  ; Since nothing has modified the value of $0 stored in A, the value of $0 is thus stored
                                  ; into the memory address specified in X, and the value at that address becomes "zeroed out"
    dex                           ; Decrement the value of X by one
    bne MemLoop                   ; If the Zero flag was not set by the previous decrement, go back to MemLoop

IRQ:
    rti                           ; Simply Return from Interrupt (rti)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "Vectors" to define Interrupts and Starts/Restarts        ;;
;;  - Must always be the very last bytes of the program      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "VECTORS"
.org $FFFA
.word NMI                         ; Non-maskable interrupt instruction (points to NMI label, above)
.word RESET                       ; Reset request instruction; Also called when the game is started (points to RESET label, above)
.word IRQ                         ; Interrupt request instruction (points to IRQ label, above)
