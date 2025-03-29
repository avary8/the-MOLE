import controlP5.*;
ControlP5 cp5;


String[] names = { 
  "title.png", 
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



void escapeButton(){
  game.handleESC();
}


void keyPressed(){
  println("key pressed");
  if (key == ESC){
    key = 0; // so as not to exit processing
    game.handleESC();    
  }
}

void mousePressed(){
  if (game.currScreen == 0){
    game.handleClick();
  }
  
  
  
  
  
}
