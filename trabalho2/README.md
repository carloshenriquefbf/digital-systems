# Hangman
This is a simple implementation of the game Hangman in FPGA/VHDL. The game is played on a 7-segment display and uses a keyboard for input. The game logic is implemented in VHDL, and the keyboard input is processed to update the game state.


## How it works

The hangman game logic is implemented in the `hangman_game.vhd` file. The game state is updated based on the keyboard input, and the current state of the game is displayed on the 7-segment display.

The `main.vhd` file is the top-level entity that instantiates the `hangman_game` and connects it to the LCD display and the PS/2 keyboard.

## More info

The code for the LCD display and the PS/2 keyboard was taken from the course's [website](https://www.gta.ufrj.br/ensino/EEL480/index.html).

Keyboard:
- `ps2_rx.vhd`, `kb_lcode.vhd`, `fifo.vhd`

LCD:
- `original_lcd.vhd`, `lcd.ucf`

In our implementation, we modified the `original_lcd.vhd` to accept external commands. The final version is called `modified_lcd.vhd`.