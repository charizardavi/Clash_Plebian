import java.util.*;

Grid mainGrid;
Minion[] minionArray = new Minion[1];

int tileSize = 100;
int rectX, rectY;
int rectColor = color(0);
int rectHighlight = color(51);
boolean firstFrames = true;
boolean currentB = false;
boolean bIsReleased = true;

void setup() {
  mainGrid = new Grid();
  minionArray[0] = new Minion("goblin", 0);
  minionArray[0].xPos=2;
  minionArray[0].yPos=2;
  fullScreen();
  println(displayWidth);
  background(255);
  for (int i = 0; i<minionArray.length; i++) {

    mainGrid.gridArray[minionArray[i].xPos][minionArray[i].yPos] = new Block(mainGrid.knightImage, 3, "knight");
  }
}
void keyPressed(){
  if(key == 'b'){
    currentB = true;
  }
  else{
    currentB = false;
  }
}
void draw() {

  if (key != 'b'){
    currentB = false;
  }
  print(currentB);
  if (currentB == false) {
    bIsReleased = true;
  }
  if (currentB && bIsReleased && minionArray[0].xPos < 9) {
    bIsReleased = false;
    minionArray[0].xPos = minionArray[0].xPos + 1;
    mainGrid.gridArray[minionArray[0].xPos][minionArray[0].yPos] = new Block(mainGrid.knightImage, 3, "knight");
    print("hi");
  }



  size(displayWidth, displayHeight);
  strokeWeight(5);




  for (int y = 0; y < 5; y++) {
    for (int x = 0; x < 10; x++) {
      drawImage(mainGrid.gridArray[x][y].image, x, y);
    }
  }
}


void drawImage(PImage inputImage, int x, int y) {
  image(inputImage, (displayWidth-10*tileSize)/2+tileSize*x, 100+tileSize*y, tileSize, tileSize);
  noFill();
  stroke(0, 125, 0);
  rect((displayWidth-10*tileSize)/2+tileSize*x, 100+tileSize*y, tileSize, tileSize);
}
