PImage image;
class card {
  String type;
  int order;
  int xpos;
  boolean selected;
  boolean used;
  card(String s, int x) {
    type = s;
    selected = false;
    xpos = x;
    if (s == "goblin"){
      image = loadImage("pixel_"+s+".png");
    }
    if (s == "knight"){
      image = loadImage("pixel_"+s+".png");
    }
    if (s == "hog"){
      image = loadImage("pixel_"+s+".png");
    }
  }
  void show(int i) {
    if (selected) {
      stroke(255, 255, 0);
    } else {
      stroke(0);
    }
    if (type.equals("goblin")) {
      image(image, xpos, 100+175*i, 100, 150);
    }
    rect(xpos, 100+175*i, 100, 150); //eventually replace this with images depending on the type
  }
  void used() {
    //make it placed on the board depending on the type
  }
}
