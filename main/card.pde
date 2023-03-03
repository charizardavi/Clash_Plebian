PImage image;
class card {
  public String type;
  int order;
  int xpos;
  boolean selected;
  boolean used;
  card(String s, int x) {
    type = s;
    selected = false;
    xpos = x;
    if (s.equals("goblin")){
      image = loadImage("pixel_"+s+".png");
    } else
    if (s.equals("knight")){
      image = loadImage("pixel_"+s+".png");
    } else
    if (s.equals("hog")){
      image = loadImage("pixel_"+s+".png");
    } else
    if (s.equals("valkyrie")){
      image = loadImage("pixel_"+s+".png");
    }
  }
  void show(int i) {
    if (selected) {
      stroke(255, 255, 0);
    } else {
      stroke(0);
    }
    image(image, xpos, 100+175*i, 100, 150);
    rect(xpos, 100+175*i, 100, 150); //eventually replace this with images depending on the type
  }
  void used() {
    //make it placed on the board depending on the type
  }
}
