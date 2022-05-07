int[][][] grid;
int	gridSize = 300;
int	resolution = 10;
int	numTiles = gridSize / resolution;

color aliveClr = color(66, 135, 245);
color deadClr = color(0);

public void	settings() {
  noSmooth();
  size(500, 500, P3D);
}

void setup() {
  grid = new int[numTiles][numTiles][numTiles];
  stroke(48);

  for (int i = 0; i < numTiles; i++) {
    for (int j = 0; j < numTiles; j++) {
      for (int k = 0; k < numTiles; k++) {
        grid[i][j][k] = floor(random(2));
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
        if (grid[i][j][k] == 1) {
          fill(aliveClr);
        }
	    else {
	      fill(deadClr);
	    }
		// rect(x, y, resolution - 1, resolution - 1);
		// this doesn't work!
		translate(x, y, -z);
		box(resolution - 1);
	  }
    }
  }

  int[][][] next = new int[numTiles][numTiles][numTiles];

  // Compute next based on grid
  for (int i = 0; i < numTiles; i++) {
    for (int j = 0; j < numTiles; j++) {
      for (int k = 0; k < numTiles; k++) {
        int state = grid[i][j][k];
        // Count live neighbors!
        int sum = 0;
        int neighbors = countNeighbors(grid, i, j, k);

        if (state == 0 && neighbors == 3) {
          next[i][j][k] = 1;
        } else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
          next[i][j][k] = 0;
        } else {
          next[i][j][k] = state;
        }
	  }
    }
  }
  grid = next;
  delay(500);
}

// implement moore/neumann 3d
int countNeighbors(int [][][]grid, int x, int y, int z) {
  int sum = 0;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      for (int k = -1; k < 2; k++) {
        int posX = (x + i + numTiles) % numTiles;
        int posY = (y + j + numTiles) % numTiles;
        int posZ = (z + k + numTiles) % numTiles;
        sum += grid[posX][posY][posZ];
	  }
    }
  }
  sum -= grid[x][y][z];
  return sum;
}
