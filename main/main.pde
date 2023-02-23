PImage grass;
int tileSize = 100;
void setup() {
  fullScreen();
  println(displayWidth);
  background(255)
  grass = loadImage("grass.png");
}
void draw() {
  size(displayWidth, displayHeight);
  strokeWeight(5);
  for (int y = 0; y <= 5; y++) {
    for (int x = 0; x < 10; x++) {
      fill(5, 255, 10);
      image(grass, (displayWidth-10*tileSize)/2+tileSize*x, 100+tileSize*y, tileSize, tileSize);
      
    }
  }
}
