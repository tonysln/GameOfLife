final int RSN = 20;
int cols;
int rows;
boolean[][] grid;
int x, y;
boolean running;
boolean torusMode;
int fps;
boolean lowFrame;

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
    boolean[][] next = new boolean[cols][rows];
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
            
            if (!state && neighbors == 3) next[i][j] = true;
            else if (state && (neighbors < 2 || neighbors > 3)) next[i][j] = false;
            else next[i][j] = state;
        }
    }
    return next;
}

void setup() {
    size(1400, 900);
    fps = 24;
    frameRate(fps);
    cols = width / RSN;
    rows = height / RSN;
    grid = new boolean[cols][rows];
    running = false;
    torusMode = false;
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
        }
    }
    
    if (running) {
        /* Next generation */
        boolean[][] next = nextGen(grid);
        grid = next;
    } else {
        push();
        fill(20, 0, 255);
        text("Paused", 26, 42);
        pop();
    } 
}

void keyPressed() {
    if (keyCode == ENTER) {
        running = !running;
    }
    if (key == 'r' || key == 'R') {
        grid = randomGrid(grid);
    }
    if (key == 'c' || key == 'C') {
        grid = emptyGrid(grid);
    }
    if (key == 't' || key == 'T') {
        torusMode = !torusMode;
    }
    if (key == 'f' || key == 'F') {
        lowFrame = !lowFrame;
    }
}

void mousePressed() {
    int mx = mouseX / RSN;
    int my = mouseY / RSN;
    if (mouseButton == LEFT) grid[mx][my] = true;
    else if (mouseButton == RIGHT) grid[mx][my] = false;
}

void mouseDragged() {
    int mx = mouseX / RSN;
    int my = mouseY / RSN;
    if (mouseButton == LEFT) grid[mx][my] = true;
    else if (mouseButton == RIGHT) grid[mx][my] = false;
}
