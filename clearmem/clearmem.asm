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

.segment "CODE"
