import java.util.*;
PImage grass;
int tileSize = 100;
int p1health = 1000;
int p2health = 1000;
int x = (displayWidth-10*tileSize)/2;
int y = 100+tileSize;
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

void setup() {
  fullScreen();
  println(displayWidth);
  background(255);
  grass = loadImage("grass.png");
  out1[0] = new card("goblin", 65);
  out1[1] = new card("knight", 65);
  out1[2] = new card("valkyrie", 65);
  out1[3] = new card("barbarian", 65);
  deck1.add(new card("wizard", 65));
  deck1.add(new card("cannon", 65));
  deck1.add(new card("arrows", 65));
  deck1.add(new card("fireball", 65));
  out1[0].selected = true;
  out2[0] = new card("goblin", displayWidth-165);
  out2[1] = new card("knight", displayWidth-165);
  out2[2] = new card("valkyrie", displayWidth-165);
  out2[3] = new card("barbarian", displayWidth-165);
  deck2.add(new card("wizard", displayWidth-165));
  deck2.add(new card("cannon", displayWidth-165));
  deck2.add(new card("arrows", displayWidth-165));
  deck2.add(new card("fireball", displayWidth-165));
  out2[0].selected = true;
}
void draw() {
  size(displayWidth, displayHeight);
  strokeWeight(5);
  for (int y = 0; y < 5; y++) {
    for (int x = 0; x < 10; x++) {
      image(grass, (displayWidth-10*tileSize)/2+tileSize*x, 100+tileSize*y, tileSize, tileSize);
      noFill();
      stroke(0, 125, 0);
      rect((displayWidth-10*tileSize)/2+tileSize*x, 100+tileSize*y, tileSize, tileSize);
    }
  }

  for (int i = 0; i < 4; i++) {
    out1[i].show(i);
    out2[i].show(i);
  }
  //scrolling up and down for either side
  if (!keyPressed) {
    downReleased = true;
    upReleased = true;
    wReleased = true;
    sReleased = true;
    dReleased = true;
    leftReleased = true;
  }
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
  //for using the cards
  if (key == CODED) {
    if (keyCode == LEFT && leftReleased) {
      if (keyPressed) {
        leftReleased = false;
        for (int i = 0; i < 4; i++) {
          if (out2[i].selected == true) {
            out2[i].used(); // make this place the card down
            println(out2[i].type); //delete this if u want
            deck2.add(out2[i]);
            out2[i] = deck2.remove();
            out2[i].selected = true;
          }
        }
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
        }
      }
    }
  }
}
