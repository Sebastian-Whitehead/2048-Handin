class Player {
  int score = 0;
  ArrayList<Tile> tilesList = new ArrayList <Tile>();         // Dynamic list of all active tiles on the board
  ArrayList<PVector> emptyPos = new ArrayList<PVector>(); // List of all empty positions on the board 
  PVector moveVector = new PVector();                     // Vector pointing the intended move direction.

  Player() {
    fillEmptyPos(); // populates list of empty board tiles.

    //Generate two random tiles at the start of the game.
    generateTile();
    generateTile();
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  // Fills list of all unpopulated spaces on the board. (used on game start)
  void fillEmptyPos() { 
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        emptyPos.add(new PVector(i, j));
      }
    }
  }


  // **************************************************** //
  // Refreshes Empty positions array. (checks tile value = 0 before adding it to the empty list)
  void populateEmptyPos() { 
    emptyPos.clear();
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (getTileValue(i, j) == 0 ) {
          emptyPos.add(new PVector(i, j));
        }
      }
    }
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  // Remove a random position from empty list and fill it with new tile of random value.
  void generateTile() {
    if (emptyPos.size() != 0) {
      PVector gap = emptyPos.remove(floor(random(emptyPos.size())));
      tilesList.add(new Tile(floor(gap.x), floor(gap.y)));
    }
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  //Displays all tiles currently on the board. Done by looping through all tiles listed.
  void show() {
    for (int i = 0; i <tilesList.size(); i++) {
      tilesList.get(i).displayTile();
    }
    textSize(35);
    textAlign(LEFT);
    text("Score: " + str(score), 20, 950);
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  // Function checks weather or not there is a tile in a given space.
  Tile getTile(int x, int y) {
    for (int i = 0; i < tilesList.size(); i++) {
      if (tilesList.get(i).position.x == x && tilesList.get(i).position.y == y) {
        return tilesList.get(i);
      }
    }
    return null;
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  //function to retrieve the value of a given space. If the space is empty the function will return 0.
  int getTileValue(int x, int y) {
    for (int i = 0; i < tilesList.size(); i++) {
      if (tilesList.get(i).position.x == x && tilesList.get(i).position.y == y) {
        return tilesList.get(i).value;
      }
    }
    if (x > 3 || y > 3 || x < 0 || y < 0) {   // Ensures the target spaces are within the bounds of the 4x4 grid.
      return -1;
    }
    return 0;   //Empty space
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  // Function to reset game board.
  void resetGame() {
    emptyPos.clear();
    tilesList.clear();
    fillEmptyPos();
    generateTile();
    generateTile();
    score = 0;
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  /* depending on the move direction make a pass across the board moving from the pressed direction and in the oposite direction. 
   The tiles encountered first move first. Ensures all tiles move in the correct order */
  void move() { 
    ArrayList<PVector> sortedOrder = new ArrayList<PVector>();  // Ordered list of all moves to be made
    PVector sortingVector = new PVector(); // Vector used in producing the final sortingOrder array.
    boolean verticalMove = false;          // Is the intended move on the y axis

    if (moveVector.x ==1) {            // Right
      sortingVector= new PVector(3, 0);   // Sets the first space that needs to be checked in order to move.
      verticalMove = false;
      //print("right");
    } else if (moveVector.x == -1) {   // Left
      sortingVector= new PVector(0, 0);
      verticalMove = false;
      //print("left");
    } else if (moveVector.y == 1) {    // Down
      sortingVector= new PVector(0, 3);
      verticalMove = true;
      //print("down");
    } else if (moveVector.y == -1) {   // Up
      sortingVector= new PVector(0, 0);
      verticalMove = true;
      //print("up");
    }

    // Produces the order in which the tiles move by subtracting move direction from the previous position to move.
    for (int i = 0; i <4; i++) {
      for (int j = 0; j<4; j++) {
        PVector temp = new PVector(sortingVector.x, sortingVector.y);
        if (verticalMove) {
          temp.x += j;
        } else {
          temp.y += j;
        }
        sortedOrder.add(temp);
      }
      sortingVector.sub(moveVector);
    }
    
    // Moves each tile space by space in the given direction. Each time checking that the target space has a tile value of 0 ie. it is an empty space.
    for (int j = 0; j < sortedOrder.size(); j++) {
      for (int i = 0; i < tilesList.size(); i++) {
        if (tilesList.get(i).position.x == sortedOrder.get(j).x && tilesList.get(i).position.y == sortedOrder.get(j).y) {                  // Is there a tile in the space that is next to move. If so move it.
          PVector moveToTarget = new PVector(tilesList.get(i).position.x + moveVector.x, tilesList.get(i).position.y + moveVector.y);  // Shifts the target to the next space in the direction of movement.
          int valueOfMoveToTarget = getTileValue(floor(moveToTarget.x), floor(moveToTarget.y));                                          // Retrieve the value of the next position in the movement direction.
          while (valueOfMoveToTarget == 0) {                                                                   // While next space returns a value of 0 move the tile once in the intended move direction.
            tilesList.get(i).position = new PVector(moveToTarget.x, moveToTarget.y);                               
            tilesList.get(i).moveToTarget(moveToTarget);
            moveToTarget = new PVector(moveVector.x + tilesList.get(i).position.x, moveVector.y + tilesList.get(i).position.y);  // Update move target to the next position in that direction. 
            valueOfMoveToTarget = getTileValue(floor(moveToTarget.x), floor(moveToTarget.y));  // [floor: round down to the next whole value]
          }

          // If value of the move target and the current tile are the same value, sum their values, update score and remove the current tile from the field.
          if (valueOfMoveToTarget == tilesList.get(i).value) { 
            getTile(floor(moveToTarget.x), floor(moveToTarget.y)).value*=2;
            score += getTile(floor(moveToTarget.x), floor(moveToTarget.y)).value*2;
            println(score);
            tilesList.remove(i);
          }
        }
      }
    }

    // Spawn a new tile in an empty space after all tiles have been moved.
    populateEmptyPos();
    generateTile();
  }
}
