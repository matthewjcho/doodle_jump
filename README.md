# Doodle Jump (1984)
**Matthew Cho, Michael Pearson, Tuan Duc Chu**

Special thanks to Dr. Yett for the continued guidance throughout the semester.


## Project Overview






## Usage Instructions
1. Open Vivado and create a new RTL project from the Vivado Quick Start menu.
2. Download all .vhd source files from the GitHub repository and add them during the Add Sources step.
3. Download the doodle_jump.xdc constraints file from GitHub and add it during the Add Constraints step.
4. Connect the monitor to the Nexys board by plugging the monitor’s HDMI cable into an HDMI-to-VGA adapter. Then connect the VGA side of the adapter to the VGA port on the Nexys board.
5. Ensure the Nexys board is powered on and connected to the computer through its USB programming cable.
6. Run Synthesis.
7. Run Implementation.
8. Generate the Bitstream.
9. Open Hardware Manager, select Auto Connect, and program the Nexys board with the generated bistream.
10. Once programming is complete, Doodle Jump (1984) should appear on the connected monitor.

## Module Hierarchy


## Inputs and Outputs
### `fsm.vhd`
The `fsm` module serves as the top-level game controller. It receives the board clock and push-button inputs, determines the current game state, and enables the corresponding game behavior. The FSM controls whether the game is idle, running, paused, won, lost, or reset. Additionally, it passes movement commands to the main game logic and routes the final visual outputs to the VGA display and seven-segment display.

**Inputs**
- `clk_in` - serves as the primary clock signal, configured at 25 MHz to provide the timing reference for state transitions, button detection, gameplay updates, VGA timing, and display refresh behavior
- `BTNL` - moves doodler to the left; input is only passed to game logic when the FSM is in the running state
- `BTNR` - moves doodler right; input is only passed to game logic when the FSM is in the running state
- `BTN0` - starts the game from idle state; a rising-edge pulse is generated from this button so that a single press initiates gameplay without requiring the button to be held
- `BTNU` - toggles pause state; pressing once pauses gameplay, and pressing it again resumes
- `BTND` - resets the game; when asserted, the FSM returns to the idle state and the game logic resets the doodler position, score, platforms, and related gameplay signals

**Outputs**
- `VGA_red` - 4-bit red color output
- `VGA_green` - 4-bit green color output
- `VGA_blue` - 4-bit blue color output
- `VGA_hsync` - horizontal synchronization signal to coordinate pixel scanning across each row of the display
- `VGA_vsync` - vertical synchronization signal to coordinate frame refresh and movement from one frame to the next
- `SEG7_anode` - selects which digit of the multiplexed seven-segment display is currently active; enables displayable scoreboard across multiple digits
- `SEG7_seg` - determines which LED segments are illuminated; with `SE7_anode`, the output displays the player’s current score


## Modifications


## Conclusion

### Responsibilities

### Project Timeline

### Difficulties






