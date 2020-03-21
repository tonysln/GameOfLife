# GameOfLife

Initially based on [Coding Challenge #85: The Game of Life](https://www.youtube.com/watch?v=FWSR_7kZuYg)

Ported to Processing (Java). Uses arrays of booleans for less memory usage.

New controls:

- **ENTER** to pause/unpause life
- **LMB** for drawing cells
- **RMB** for deleting cells
- **T** to toggle torus mode on or off (in default mode cells are 'boxed in')
- **R** to randomly fill up the grid
- **C** to clear the grid
- **F** to toggle low-fps mode on or off (24 fps vs 4 fps)

Drawing can also be done by pressing and dragging the mouse, but abusing this can easily crash the applet.

To-do:

- Input grid resolution and size (currently can be manually adjusted on line 1 and in ```setup()```.
- Input shapes onto grid from file or string.