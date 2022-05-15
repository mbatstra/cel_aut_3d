class Cell {
  boolean isAlive;
  int  timetoDie;
}

Cell[][][] grid;
int	gridSize = 300;
int	resolution = 10;
int	numTiles = gridSize / resolution;

color aliveClr = color(66, 135, 245);
color deadClr = color(0);

//rules
int  nSurvival = 4;
int  nBirth = 4;
int  nLife = 5;
char  mode = 'M';


public void	settings() {
  noSmooth();
  size(500, 500, P3D);
}

boolean randomBool() {
  int  coin = floor(random(2));
  if (coin == 1)
    return (true);
  return (false);
}

void setup() {
  grid = new Cell[numTiles][numTiles][numTiles];
  stroke(48);
  for (int i = 0; i < numTiles; i++) {
    for (int j = 0; j < numTiles; j++) {
      for (int k = 0; k < numTiles; k++) {
        Cell cell = new Cell();
        grid[i][j][k] = cell;
        grid[i][j][k].isAlive = randomBool();
	    }
    }
  }
}

void draw() {
  background(0);

  // draw cells
  for (int i = 0; i < numTiles; i++) {
    for (int j = 0; j < numTiles; j++) {
      for (int k = 0; k < numTiles; k++) {
        int x = i * resolution;
        int y = j * resolution;
        int z = k * resolution;
        if (grid[i][j][k].isAlive) {
          fill(aliveClr);
        }
	      else {
	        fill(deadClr);
	      }
        camera();
		    translate(x, y, -z);
	    	box(resolution - 1);
	    }
    }
  }

  Cell[][][] next = new Cell[numTiles][numTiles][numTiles];

  // Compute next based on grid
  for (int i = 0; i < numTiles; i++) {
    for (int j = 0; j < numTiles; j++) {
      for (int k = 0; k < numTiles; k++) {
        Cell cell = new Cell();
        next[i][j][k] = cell;
        int state = grid[i][j][k].timetoDie;
        // Count live neighbors!
        int sum = 0;
        int neighbors = countNeighbors(grid, i, j, k, mode);
        if (state == 0 && neighbors == 3) {
          next[i][j][k].timetoDie = 1;
          next[i][j][k].isAlive = true;
        } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
          next[i][j][k].timetoDie = 0;
          next[i][j][k].isAlive = false;
        } else {
          next[i][j][k].timetoDie = state;
        }
	    }
    }
  }
  grid = next;
  delay(500);
}

int countNeighbors(Cell [][][]grid, int x, int y, int z, char mode) {
  int sum = 0;
  Cell[] neighbors;
  
  if (mode == 'N') {
    neighbors = getNeumann(grid, x, y, z);
    for (int i = 0; i < 6; i++) {
      if (neighbors[i].isAlive)
        sum++;
    }
  }
  else if (mode == 'M') {
    neighbors = getMoore(grid, x, y, z);
    for (int i = 0; i < 26; i++) {
      if (neighbors[i].isAlive)
        sum++;
    }
  }
  return sum;
}
