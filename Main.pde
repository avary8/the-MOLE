import controlP5.*;
ControlP5 cp5;


String[] names = { 
  "title-6.png",
  "settings.png",
  "quit.png",
  "difficulty.png",
};


Game game;


void setup(){
 size(1920, 1080);
 cp5 = new ControlP5(this);

 game = new Game(names, cp5);
 
 game.setCurrScreen(0);
}


void draw(){
  game.display();
  game.drawGrid();
}


void startButton(){
  println("START BUTTON CLICKED");
  game.setCurrScreen(3);
}

void settingsButton(){
  println("SETTINGS BUTTON CLICKED");
  game.setCurrScreen(1);
}

void quitButton(){
  println("QUIT BUTTON CLICKED");
  game.setCurrScreen(2);
}

void escapeButton(){
  println("ESC BUTTON CLICKED");
  game.handleESC();
}

void yesButton(){
  println("YES BUTTON CLICKED");
  exit();
}

void noButton(){
  println("No BUTTON CLICKED");
  game.setCurrScreen(0); 
}


void normalButton(){
  println("normal BUTTON CLICKED");
  game.setDifficulty(0);
  game.startGame();
}

void hardButton(){
  println("hard BUTTON CLICKED");
  game.setDifficulty(1);
  game.startGame();
  
}


void keyPressed(){
  println("key pressed");
  if (key == ESC){
    key = 0; // so as not to exit processing
    game.handleESC();    
  } 
}
