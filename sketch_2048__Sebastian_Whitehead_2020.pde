Player user;           //Declares new objekt of class player

void setup() {
  size(850, 1000);
  user = new Player();
}



// ------------------------------------------------------------------------------------------------------------------ //
void draw() {
  background(250, 248, 239);   // Background colour
  fill(187, 174, 162);       
  rect(0, 0, 850, 850);        // Background of grid
  
  // For loops used for drawing in the blank spaces in the grid.
  fill(205, 193, 180);
  for (int i = 0; i <= 3; i++) { 
    for (int j = 0; j <= 3; j++) {
      rect(10 + (10*i) + (200*i), 10 + (10*j) + (j*200), 200, 200);
    }
  }
  
  //Reset button prompt
  textSize(20);  
  textAlign(LEFT);
  text("' R ' > Reset.", 20, 980);
  
  user.show();                        // Calls the show function in the player class.
}



// ------------------------------------------------------------------------------------------------------------------ //
// User Input 
void keyPressed() {
  switch(key) {
  case CODED:
    switch(keyCode) {
    case UP:
      user.moveVector = new PVector(0, -1); // Sets move direction vector depending on the given input.
      user.move();                             // Commit the move in the given direction.
      //println("up");                      // Console print out for test purposes.
      break;
    case DOWN:
      user.moveVector = new PVector(0, 1);
      user.move();
      //println("down");
      break;
    case RIGHT:
      user.moveVector = new PVector(1, 0);
      user.move();
      //println("right");
      break;
    case LEFT:
      user.moveVector = new PVector(-1, 0);
      user.move();
      //println("left");
      break;
    }
  }
  
  if (key == 'r') {      // Reset button.
    user.resetGame();    // Calls game reset funktion in player class.
   /* println("reset");  // Test!
    println(); */
  }
}
