class Grid{
  public PImage grassImage = loadImage("grass.png");
  public Block[][] gridArray = new Block[10][5];
  public PImage knightImage = loadImage("combined.png");
  
  Grid(){
    for (int i=0; i < 10; i++){
      for (int j = 0; j < 5; j++){
        gridArray[i][j] = new Block(grassImage, 0, "grass");
      }      
    }
  }
}
