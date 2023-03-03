class Minion{
  public int health = 0;
  public int attack = 0;
  public String type = "";
  public int id = 0;
  public int elixerCost;
  public int xPos = 0;
  public int yPos = 0;  
  
  Minion(String inputType, int inputId){
    if (inputType.equals("knight")){
      health = 10;
      attack = 3;
      type = "knight";
      elixerCost = 5;
    }
    else{
      health = 3;
      attack = 2;
      type = "goblin";
      elixerCost = 2;
    }
  }
}
