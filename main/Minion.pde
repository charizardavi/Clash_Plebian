class Minion{
  public int health = 0;
  public int attack = 0;
  public String type = "";
  public int id = 0;
  public int elixerCost;
  public int xPos = 0;
  public int yPos = 0;
  public PImage minionImage = null;
  
  Minion(String inputType, int inputId){
    minionImage = loadImage(inputType+"_combined.png");
    id = inputId;
    type = inputType;

    if (type == "knight"){
      health = 7;
      attack = 3;
      elixerCost = 4;
    }

    else if (type == "valkyrie"){
      health = 9;
      attack = 3;
      elixerCost = 6;
    }

    else if (type == "wizard"){
      health = 4;
      attack = 4;
      elixerCost = 4;
    }
    
    else if (type == "hog"){
      health = 5;
      attack = 5;
      elixerCost = 5;
    }
    
    else if (type == "robot"){
      health = 10;
      attack = 4;
      elixerCost = 8;
    }

    else if (type == "fighter"){
      health = 5;
      attack = 6;
      elixerCost = 6;
    }

    else if (type == "barbarian"){
      health = 4;
      attack = 6;
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
