class character {
  String type;
  int health;
  int xpos;
  int ypos;
  boolean fighting;
character(String s, int x, int y) {
  xpos = x;
  ypos = y;
  if (s.equals("goblin")) {
    health = 200;
  }
}
}
