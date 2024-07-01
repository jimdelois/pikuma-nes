# Make sure to `export NAME=NAME_OF_MODULE` before running this script.
CFG=../linker-configs/nes.cfg

# Compile and link all the files
build:
	ca65 $(NAME).asm -o $(NAME).o
	ld65 -C $(CFG) $(NAME).o -o $(NAME).nes

clean:
	rm -f $(NAME).o $(NAME).nes

clean-all:
	rm -f *.o *.nes

clean-all-all:
	rm -f *.fdb *.o *.nes

run:
	fceux $(NAME).nes

