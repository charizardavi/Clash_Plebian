import java.util.*;
import processing.sound.*;

SoundFile track;

PImage grass;

Grid mainGrid;
Minion[] minionArray = new Minion[6];

int tileSize = 100;

int p1health = 1000;
int p2health = 1000;

int x = (displayWidth-10*tileSize)/2;
int y = 100+tileSize;

boolean done = false;

Queue<card> deck1 = new LinkedList<card>();
card[] out1 = new card[4];

Queue<card> deck2 = new LinkedList<card>();
card[] out2 = new card[4];

boolean downReleased = true;
boolean upReleased = true;
boolean wReleased = true;
boolean sReleased = true;
boolean dReleased = true;

boolean leftReleased = true;
int rectX, rectY;
int rectColor = color(0);
int rectHighlight = color(51);

boolean firstFrames = true;
boolean currentB = false;
boolean bIsReleased = true;
ElixirBar elixirBar; 
ElixirBar elixirBar1;
int last = millis(); 

int rheight = 0;
int lheight = 0;

boolean lgridSelect = false;
boolean rgridSelect = false;
boolean lcardSelect = true;
boolean rcardSelect = true;

boolean currentEnter = false;
boolean currentShift = false;
boolean enterIsReleased = true;
boolean shiftIsReleased = true;


void setup() {
  track = new SoundFile(this, "track.mp3");
  track.play();
  mainGrid = new Grid();
  minionArray[0] = new Minion("knight", 1);
  minionArray[1] = new Minion("goblin", 2);
  minionArray[0].xPos=2;
  minionArray[0].yPos=2;
  minionArray[1].xPos = 5;
  minionArray[1].yPos = 2;

  fullScreen();
  println(displayWidth);
  background(255);

  for (int i = 0; i<minionArray.length; i++) {
    if (minionArray[i] != null && i == 0){
      mainGrid.gridArray[minionArray[i].xPos][minionArray[i].yPos] = new Block(mainGrid.knightImage, 1, "knight");
    }
    else if (minionArray[i] != null && i > 0){
      mainGrid.gridArray[minionArray[i].xPos][minionArray[i].yPos] = new Block(loadImage("goblin_combined.png"), 2, "goblin");
    }
  }

  grass = loadImage("grass.png");

  out1[0] = new card("goblin", 65);
  out1[1] = new card("knight", 65);
  out1[2] = new card("hog", 65);
  out1[3] = new card("valkyrie", 65);
  
  deck1.add(new card("wizard", 65));
  deck1.add(new card("fighter", 65));
  deck1.add(new card("robot", 65));
  deck1.add(new card("barbarian", 65));

  out1[0].selected = true;

  out2[0] = new card("goblin", displayWidth-165);
  out2[1] = new card("knight", displayWidth-165);
  out2[2] = new card("hog", displayWidth-165);
  out2[3] = new card("valkyrie", displayWidth-165);

  deck2.add(new card("wizard", displayWidth-165));
  deck2.add(new card("fighter", displayWidth-165));
  deck2.add(new card("robot", displayWidth-165));
  deck2.add(new card("barbarian", displayWidth-165));

  out2[0].selected = true;
}

void keyPressed() {
  if (key == 'b') {
    currentB = true;
  }
  
  print(keyCode); //enter: 10, shift: 16
}


void draw() {
  if (done == true){
    background(255);
    textSize(128);
    text("player 1 wins", 40, 120); 
    fill(0, 408, 612);
  }
  else if (done == false){
    background(255);
  }

  if ((millis() - last) > 5000) {
    elixirBar.increase(); 
    elixirBar1.increase(); 
    last = millis(); 
  }
  
  elixirBar.draw();
  elixirBar1.draw();

  if (currentB == false) {
    bIsReleased = true;
  }

  if (currentB && bIsReleased) {
    bIsReleased = false;
    for (int i = 0; i < minionArray.length; i++){
      if (minionArray[i] != null && minionArray[i].xPos >= 0 && minionArray[i].xPos <= 9){
         print("pos:");
         print(minionArray[i].xPos);
         print(minionArray[i].type);
         print("posed");
        if (minionArray[i].xPos == 8 && minionArray[i].type == "knight"){
          done = true;
          
        }
        print("id: ");
        print(minionArray[i].id);
        print(minionArray[i].type);
        print("end");
        if (minionArray[i].type == "knight"){
          minionArray[i].xPos = minionArray[i].xPos + 1;
          mainGrid.gridArray[minionArray[i].xPos-1][minionArray[i].yPos] = new Block(mainGrid.grassImage, 1, "grass");
          mainGrid.gridArray[minionArray[i].xPos][minionArray[i].yPos] = new Block(minionArray[i].minionImage, minionArray[i].id, minionArray[i].type);
        }
        else if ( minionArray[i].type == "goblin"){
          minionArray[i].xPos = minionArray[i].xPos - 1;
          mainGrid.gridArray[minionArray[i].xPos+1][minionArray[i].yPos] = new Block(mainGrid.grassImage, 2, "grass");
          mainGrid.gridArray[minionArray[i].xPos][minionArray[i].yPos] = new Block(minionArray[i].minionImage, minionArray[i].id, minionArray[i].type);
        }
      }
    }
    
  
  }

  size(displayWidth, displayHeight);
  strokeWeight(5);

  for (int y = 0; y < 5; y++) {
    for (int x = 0; x < 10; x++) {
      drawImage(mainGrid.gridArray[x][y].image, x, y);

      if (y == 2) {
        if (x > 0 && x < 9) {
          
          if (mainGrid.gridArray[x][y].minion != null && mainGrid.gridArray[x+1][y].minion != null) {
            println("1");
            println(mainGrid.gridArray[x][y].minion.health);
            println(mainGrid.gridArray[x+1][y].minion.health);
            while (mainGrid.gridArray[x][y].minion.health <= 0 || mainGrid.gridArray[x+1][y].minion.health <= 0) {
              print("fighting");
              mainGrid.gridArray[x+1][y].minion.health = mainGrid.gridArray[x+1][y].minion.health - mainGrid.gridArray[x][y].minion.attack;
              mainGrid.gridArray[x][y].minion.health = mainGrid.gridArray[x][y].minion.health - mainGrid.gridArray[x+1][y].minion.attack;
            }
            if (mainGrid.gridArray[x+1][y].minion.health > mainGrid.gridArray[x][y].minion.health) {
              mainGrid.gridArray[x][y] = new Block(mainGrid.grassImage, 0, "grass");
              for (int i = 0; i < minionArray.length; i++){
                if (minionArray[i] != null){
                  if (minionArray[i].xPos == x){
                    minionArray[i] = null;
                  }
                }
              }
            } else if (mainGrid.gridArray[x+1][y].minion.health == mainGrid.gridArray[x][y].minion.health) {
              mainGrid.gridArray[x][y] = new Block(mainGrid.grassImage, 0, "grass");
              mainGrid.gridArray[x+1][y] = new Block(mainGrid.grassImage, 0, "grass");
            } else {
              mainGrid.gridArray[x+1][y] = new Block(mainGrid.grassImage, 0, "grass");
              for (int i = 0; i < minionArray.length; i++){
                if (minionArray[i] != null){
                  if (minionArray[i].xPos == x+1){
                    minionArray[i] = null;
                  }
                }
              }
            }
          } 
          else if (mainGrid.gridArray[x][y].minion != null && mainGrid.gridArray[x-1][y].minion != null) {
            
            print("-1");
            if (mainGrid.gridArray[x][y].minion != null && mainGrid.gridArray[x-1][y].minion != null) {
              while (mainGrid.gridArray[x][y].minion.health <= 0 || mainGrid.gridArray[x-1][y].minion.health <= 0) {
                mainGrid.gridArray[x-1][y].minion.health = mainGrid.gridArray[x-1][y].minion.health - mainGrid.gridArray[x][y].minion.attack;
                mainGrid.gridArray[x][y].minion.health = mainGrid.gridArray[x][y].minion.health - mainGrid.gridArray[x-1][y].minion.attack;
              }
              if (mainGrid.gridArray[x-1][y].minion.health > mainGrid.gridArray[x][y].minion.health) {
                mainGrid.gridArray[x][y] = new Block(mainGrid.grassImage, 0, "grass");
                for (int i = 0; i < minionArray.length; i++){
                if (minionArray[i] != null){
                  if (minionArray[i].xPos == x){
                    minionArray[i] = null;
                  }
                }
              }
              } else if (mainGrid.gridArray[x-1][y].minion.health == mainGrid.gridArray[x][y].minion.health) {
                mainGrid.gridArray[x][y] = new Block(mainGrid.grassImage, 0, "grass");
                mainGrid.gridArray[x-1][y] = new Block(mainGrid.grassImage, 0, "grass");
              } else {
                mainGrid.gridArray[x-1][y] = new Block(mainGrid.grassImage, 0, "grass");
                for (int i = 0; i < minionArray.length; i++){
                if (minionArray[i] != null){
                  if (minionArray[i].xPos == x-1){
                    minionArray[i] = null;
                  }
                }
              }
              }
            }
          }
        }
      }
    }
    //out1[0].show(0);
    for (int i = 0; i < 4; i++) {
      out1[i].show(i);
      out2[i].show(i);
    }
    cardSelect();
    // selectBlockLeft();
    // selectBlockRight();
  }
  }
}
//scrolling up and down for either side
void cardSelect() {
  if (!keyPressed) {
    currentB = false;
    downReleased = true;
    upReleased = true;
    wReleased = true;
    sReleased = true;
    dReleased = true;
    leftReleased = true;
  }
  if (lcardSelect) {
    if (key == 's' && sReleased) {
      if (keyPressed) {
        sReleased = false;
        boolean nextSelect = false;
        int order = 0;
        for (int i = 0; i < 3; i++) {
          if (out1[i].selected == true) {
            nextSelect = true;
            order = i;
          }
        }
        if (nextSelect == true) {
          out1[order+1].selected = true;
          out1[order].selected = false;
          nextSelect = false;
        }
      }
    }
    if (key == 'w' && wReleased) {
      if (keyPressed) {
        wReleased = false;
        boolean prevSelect = false;
        int order = 0;
        for (int i = 1; i < 4; i++) {
          if (out1[i].selected == true) {
            prevSelect = true;
            order = i;
          }
        }
        if (prevSelect == true) {
          out1[order-1].selected = true;
          out1[order].selected = false;
          prevSelect = false;
        }
      }
    }
    if (key == 'd' && dReleased) {
      if (keyPressed) {
        dReleased = false;
        for (int i = 0; i < 4; i++) {
          if (out1[i].selected == true) {
            out1[i].used(); // make this place the card down
            println(out1[i].type); //delete this if u want
            deck1.add(out1[i]);
            out1[i] = deck1.remove();
            out1[i].selected = true;
            lcardSelect = true;
            mainGrid.gridArray[0][2] = new Block(grass, 2, "knight");
            int k = 0;
            while (minionArray[k] != null){
              k = k+1;
            }
            minionArray[k] = mainGrid.gridArray[0][2].minion;
            minionArray[k].xPos = 0;
            minionArray[k].yPos = 2;
          }
        }
      }
    }
  }
  if (rcardSelect) {
    if (key == CODED) {
      if (keyCode == DOWN && downReleased) {
        if (keyPressed) {
          downReleased = false;
          boolean nextSelect = false;
          int order = 0;
          for (int i = 0; i < 3; i++) {
            if (out2[i].selected == true) {
              nextSelect = true;
              order = i;
            }
          }
          if (nextSelect == true) {
            out2[order+1].selected = true;
            out2[order].selected = false;
            nextSelect = false;
          }
        }
      }
      if (keyCode == UP && upReleased) {
        if (keyPressed) {
          upReleased = false;
          boolean prevSelect = false;
          int order = 0;
          for (int i = 1; i < 4; i++) {
            if (out2[i].selected == true) {
              prevSelect = true;
              order = i;
            }
          }
          if (prevSelect == true) {
            out2[order-1].selected = true;
            out2[order].selected = false;
            prevSelect = false;
          }
        }
      }
    }
    if (key == CODED) {
      if (keyCode == LEFT && leftReleased && mainGrid.gridArray[9][2].minion == null) {
        if (keyPressed) {
          leftReleased = false;
          for (int i = 0; i < 4; i++) {
            if (out2[i].selected == true) {
              out2[i].used(); // make this place the card down
              println(out2[i].type); //delete this if u want
              deck2.add(out2[i]);
              out2[i] = deck2.remove();
              out2[i].selected = true;
              rcardSelect = true;
              mainGrid.gridArray[9][2] = new Block(grass, 1, "goblin");
              int k = 0;
              while (minionArray[k] != null){
                k = k+1;
              }
              minionArray[k] = mainGrid.gridArray[9][2].minion;
              minionArray[k].xPos = 9;
              minionArray[k].yPos = 2;
            }
          }
        }
      }
    }

  }
}

void drawImage(PImage inputImage, int x, int y) {
  image(inputImage, (displayWidth-10*tileSize)/2+tileSize*x, 100+tileSize*y, tileSize, tileSize);
  noFill();
  stroke(0, 125, 0);
  rect((displayWidth-10*tileSize)/2+tileSize*x, 100+tileSize*y, tileSize, tileSize);
}

void selectBlockLeft() {
  if (lgridSelect) {
    if (!keyPressed) {
      wReleased = true;
      sReleased = true;
      dReleased = true;
    }
    if (key == 's' && sReleased) {
      if (keyPressed) {
        sReleased = false;
        if (lheight < 4 && lheight >= 0) {
          lheight++;
        }
      }
    }
    if (key == 'w' && wReleased) {
      if (keyPressed) {
        wReleased = false;
        if (lheight <= 4 && lheight > 0) {
          lheight--;
        }
      }
    }
    if (key == 'd' && dReleased) {
      if (keyPressed) {
        dReleased = false;
        //add spawn here!!!!!
        lgridSelect = false;
        lcardSelect = true;
      }
    }
    stroke(255, 255, 0);
    rect((displayWidth-10*tileSize)/2, 100+tileSize*lheight, tileSize, tileSize);
  }
}

void selectBlockRight() {
  if (rgridSelect) {
    if (!keyPressed) {
      upReleased = true;
      downReleased = true;
      leftReleased = true;
    }
    if (key == CODED) {
      if (keyCode == DOWN && downReleased) {
        if (keyPressed) {
          downReleased = false;
          if (rheight < 4 && rheight >= 0) {
            rheight++;
          }
          println("hello");
        }
      }
      if (keyCode == UP && upReleased) {
        if (keyPressed) {
          upReleased = false;
          if (rheight <= 4 && rheight > 0) {
            rheight--;
          }
        }
      }
      if (keyCode == LEFT && leftReleased) {
        if (keyPressed) {
          leftReleased = false;
          //add spawn here!!!!
          rgridSelect = false;
          rcardSelect = true;
        }
      }
    }
    stroke(255, 255, 0);
    rect((displayWidth-10*tileSize)/2+tileSize*9, 100+tileSize*rheight, tileSize, tileSize);
  }
}
