class Block{
  public Minion minion = null;
  public PImage image;
  Block(PImage inputImage, int inputId, String inputType){  
    image = inputImage;
    if (!inputType.equals("grass")){
      minion = new Minion(inputType, inputId);
      image = minion.minionImage;
    }
  }
}
