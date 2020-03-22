final int RSN = 20;
String insertString = "010,001,111";
int cols;
int rows;
boolean[][] grid;
boolean[][] next;
int x, y;
boolean running;
boolean torusMode;
int fps;
boolean lowFrame;
boolean insertMode;

/* Generate a grid of random boolean values. */
boolean[][] randomGrid(boolean[][] grid) {    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            grid[i][j] = Math.random() < 0.5;
        }
    }
    return grid;
}

/* Empty the given grid (set all values to false). */
boolean[][] emptyGrid(boolean[][] grid) {
    for (int i = 0; i < grid.length; i++) {
        for (int j = 0; j < grid[0].length; j++) {
            grid[i][j] = false;
        }
    }
    return grid;
}

/* Count the number of alive neighbors surrounding (x,y). */
int countNeighbors(boolean[][] grid, int x, int y) {
    int sum = 0;
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            int col = (x + i + cols) % cols;
            int row = (y + j + rows) % rows;
            if (grid[col][row]) sum++;
        }
    }
    if (grid[x][y]) sum--;
    return sum;
}

/* Generate the next grid of life. */
boolean[][] nextGen(boolean[][] grid) {
    // TODO (possibly): re-use instead of creating a new array here
    boolean[][] nextTemp = new boolean[cols][rows];
    int iStart = 1;
    int iEnd = cols-1;
    int jStart = 1;
    int jEnd = rows-1;
    
    if (torusMode) {
        iStart = 0;
        iEnd = cols;
        jStart = 0;
        jEnd = rows;
    }
    
    for (int i = iStart; i < iEnd; i++) {
        for (int j = jStart; j < jEnd; j++) {
            int neighbors = countNeighbors(grid, i, j);
            boolean state = grid[i][j];
            
            if (!state && neighbors == 3) nextTemp[i][j] = true;
            else if (state && (neighbors < 2 || neighbors > 3)) nextTemp[i][j] = false;
            else nextTemp[i][j] = state;
        }
    }
    return nextTemp;
}

/* Decode a string of 0s and 1s (del by ,) into a shape to be added
 * to the specified x and y coordinates. Using main static grid. */
void addShapeToGrid(String shape, int x, int y) {
    String[] shapeRows = shape.split(",");

    /* Check if the shape is going to fit on the grid, else do not draw it. */
    if ((shapeRows[0].length()+x < cols) && (shapeRows.length+y < rows)) {
        for (int i = 0; i < shapeRows.length; i++) {
            for (int j = 0; j < shapeRows[0].length(); j++) {
                if (shapeRows[i].charAt(j) == '1') grid[j + x][i + y] = true;
                if (shapeRows[i].charAt(j) == '0') grid[j + x][i + y] = false;
            }
        }
    }
}

void setup() {
    size(1000, 600);
    fps = 24;
    frameRate(fps);
    cols = width / RSN;
    rows = height / RSN;
    grid = new boolean[cols][rows];
    next = new boolean[cols][rows];
    running = false;
    torusMode = false;
    insertMode = false;
    textSize(20);
}

void draw() {
    background(130);
    int iStart = 1;
    int iEnd = cols-1;
    int jStart = 1;
    int jEnd = rows-1;
    
    if (torusMode) {
        iStart = 0;
        iEnd = cols;
        jStart = 0;
        jEnd = rows;
    }
    
    if (lowFrame) fps = 4;
    else fps = 24;
    frameRate(fps);
    
    for (int i = iStart; i < iEnd; i++) {
        for (int j = jStart; j < jEnd; j++) {
            x = i * RSN;
            y = j * RSN;     
            if (grid[i][j]) {
                stroke(120);
                fill(20, 20, 50);
            } else {
                stroke(190);
                fill(255);
            } 
            rect(x, y, RSN, RSN);         
            //if ((mouseX > x && mouseX <= x+RSN) && (mouseY > y && mouseY <= y+RSN)) {
            //    push();
            //    stroke(190);
            //    fill(200);
            //    rect(x, y, RSN, RSN);
            //    pop();
            //}
               
        }
    }
    
    if (running) {
        /* Next generation */
        next = nextGen(grid);
        grid = next;
    } else {
        push();
        fill(20, 0, 255);
        text("Paused", 26, 42);
        pop();
    } 
    
    if (insertMode) {
        push();
        fill(190, 130, 25);
        text("Insert", 26, 65);
        pop();
    }
    
}

void keyPressed() {
    if (keyCode == ENTER || key == ' ' || key == 'p') {
        running = !running;
    }
    if (key == 'r') {
        grid = randomGrid(grid);
    }
    if (key == 'c') {
        grid = emptyGrid(grid);
    }
    if (key == 't') {
        torusMode = !torusMode;
    }
    if (key == 'f') {
        lowFrame = !lowFrame;
    }
    if (key == 'i') {
        insertMode = !insertMode;
    }
    if (key == 'n' && !running) {  
        noLoop();
        running = true;
        draw();
        running = false;
        loop();
    }
}

void mousePressed() {
    int mx = mouseX / RSN;
    int my = mouseY / RSN;
    if (mouseButton == LEFT) {
        if (insertMode) {
            addShapeToGrid(insertString, mx, my);
        } else {
            grid[mx][my] = true;
        }
    }
    else if (mouseButton == RIGHT) grid[mx][my] = false;
}

void mouseDragged() {
    int mx = mouseX / RSN;
    int my = mouseY / RSN;
    if (mouseButton == LEFT) grid[mx][my] = true;
    else if (mouseButton == RIGHT) grid[mx][my] = false;
}
