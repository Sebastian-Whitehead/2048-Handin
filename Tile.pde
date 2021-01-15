class Tile {
  int value;             // Value of a given tile 
  PVector position;      // 4x4 grid coordinates --> (0,0) = top left
  PVector cornerPos;     // Coordinates for the top left corner of the created tile object
  color colour;
  color textColour;

  // ------------------------------------------------------------------------------------------------------------------ //
  // Create tile at given grid coordinates
  Tile(int x, int y) {     
    if (random(1) < 0.1) { // 10% chance of new tile to have value of 4
      value = 4;
    } else {
      value = 2;           // 90% chance of value to be 2
    }

    position = new PVector(x, y);
    cornerPos = new PVector(x*200 + (x+1)*10, y*200 + (y+1)*10);
  }


  // ------------------------------------------------------------------------------------------------------------------ //
  // function for displaying tiles and the tile value
  void displayTile() {
    noStroke();
    tileColour();
    fill(colour);
    rect(cornerPos.x, cornerPos.y, 200, 200);
    fill(textColour);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(value, cornerPos.x+100, cornerPos.y+100);
  }


  // ------------------------------------------------------------------------------------------------------------------ //
  // Function for moving tiles to a given target on the grid.
  void moveToTarget(PVector target) {
    position = new PVector(target.x, target.y);
    cornerPos = new PVector(target.x*200 + (target.x+1)*10, target.y*200 + (target.y+1)*10);
  }



  // ------------------------------------------------------------------------------------------------------------------ //
  // Function for changing the colour depeding on the value of a given tile
  void tileColour() {
    switch (value) {
    case 2:
      colour = color(237, 227, 215);
      textColour = color(0);
      break;
    case 4:
      colour = color(247, 228, 154);
      textColour = color(0);
      break;
    case 8:
      colour = color(254, 206, 121);
      textColour = color (255);
      break;
    case 16:
      colour = color(248, 166, 86);
      textColour = color (255);
      break;
    case 32:
      colour = color(244, 129, 112);
      textColour = color (255);
      break;
    case 64:
      colour = color(243, 129, 147);
      textColour = color (255);
      break;
    case 128:
      colour = color(243, 145, 188);
      textColour = color (255);
      break;
    case 256:
      colour = color(228, 183, 213);
      textColour = color (255);
      break;       
    case 512:
      colour = color(139, 139, 195);
      textColour = color (255);
      break;       
    case 1028:
      colour = color(148, 202, 227);
      textColour = color (255);
      break;
    case 2048:
      colour = color(160, 217, 217);
      textColour = color (255);
      break;
    case 4096:
      colour = color(151, 209, 169);
      textColour = color (255);
      break;
    case 8192:
      colour = color(202, 224, 137);
      textColour = color (255);
      break;
    default:
      colour = color(65, 65, 66);
      textColour = color (255);
      break;
    }
  }
}
