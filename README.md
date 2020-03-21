# GameOfLife

Initially based on [Coding Challenge #85: The Game of Life](https://www.youtube.com/watch?v=FWSR_7kZuYg)

Ported to Processing (Java). Uses arrays of booleans for less memory usage.

New controls:

- **ENTER** (or **SPACE** or **P**) to pause/unpause life
- **LMB** for drawing cells
- **RMB** for deleting cells
- **T** to toggle torus mode (in default mode cells are 'boxed in')
- **R** to randomly fill up the grid
- **C** to clear the grid
- **F** to toggle low-fps mode (24 fps vs 4 fps)
- **I** to toggle 'insert' mode

Insert mode - add a predefined shape onto the grid **at the current mouse location**. The shape is defined as a string in the form of 0s and 1s delimited by a comma (all rows must be of equal length). The default shape ```010,001,111``` is representing the classic glider, for example. Currently, there is no way to input the shape other than to modify ```insertString``` on line 2.

Drawing can also be done by pressing and dragging the mouse, but abusing this can easily crash the applet.

Sometimes all keyboard input is ignored right after launching the applet, which can be fixed by clicking anywhere in the window.

To-do:

- Input grid resolution and size (currently can be manually adjusted on line 1 and in ```setup()```.
- Input shape for insert mode.