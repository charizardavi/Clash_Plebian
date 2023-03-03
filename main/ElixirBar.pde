  class ElixirBar {
    int elixir = 10;
    int maxElixir = 10;
    int elixirWidth = 20;
    int elixirHeight = 60;
    int x;
    int y;
    //int flashDuration = 500;
    //int flashStartTime = 0;
    //boolean flashing = false;
    public ElixirBar(int x, int y) {
      this.x = x; 
      this.y = y; 
    }

  
  void increase() {
    if (elixir < maxElixir) {
      elixir++;
    }
  }

  void decrease(int value) {
    if (elixir > 0 && elixir - value >= 0) {
      elixir-=value;
      //flashing = true;
      //flashStartTime = millis();
    }
  }

  void draw() {
    fill(153, 50, 204); 
    for (int i = 0; i < maxElixir; i++) {
      if (i < elixir) {
        rect(x + i * elixirWidth, y, elixirWidth, elixirHeight);
      } else {
        fill(255, 255, 255);
        strokeWeight(2);
        stroke(255, 255, 255);
        rect(x + i * elixirWidth, y, elixirWidth, elixirHeight);
      }
    }
/*
    if (flashing) {
      if (millis() - flashStartTime < flashDuration) {
        fill(255, 255, 0); // yellow
        rect(x + (elixir - 1) * elixirWidth, y, elixirWidth, elixirHeight);
      } else {
        flashing = false;
      }
    }
    */
  }
}
