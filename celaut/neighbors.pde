Cell[]  getMoore(Cell [][][]grid, int x, int y, int z) {
  Cell[] neighbors = new Cell[6];
  Cell dead = new Cell();
  
  dead.isAlive = false;
  dead.timetoDie = 0;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      for (int k = -1; k < 2; k++); {
        
      } 
    }
  }
  return (neighbors);
}

Cell[]  getNeumann(Cell [][][]grid, int x, int y, int z) {
  Cell[] neighbors = new Cell[6];
  Cell dead = new Cell();
  
  dead.isAlive = false;
  dead.timetoDie = 0;
  if (x > 0)
    neighbors[0] = grid[x - 1][y][z];
  else
    neighbors[0] = dead;
  if (x > 0)
    neighbors[0] = grid[x + 1][y][z];
  else
    neighbors[0] = dead;
  if (y > 0)
    neighbors[0] = grid[x][y - 1][z];
  else
    neighbors[0] = dead;
  if (y > 0)
    neighbors[0] = grid[x][y + 1][z];
  else
    neighbors[0] = dead;
  if (z > 0)
    neighbors[0] = grid[x][y][z - 1];
  else
    neighbors[0] = dead;
  if (z > 0)
    neighbors[0] = grid[x][y][z + 1];
  else
    neighbors[0] = dead;
  return (neighbors);
}
