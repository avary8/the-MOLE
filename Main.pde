
// Ava McCormack





/* ---------------------------------------- NOTE ----------------------------------------
  i implemented a lot of code as you can see, but I was testing it in a different folder to just figure out movement, clicking, loading images, etc. (i've never really made a game besides minesweeper in prog 2) 
    so it is not integrated with this Main yet . since this folder was originally just testing out the Menu selection stuff
    also i havent commented most of it yet since i was just testing stuff, but figured i'd include it in the submission
    
 this Main will just have Menu selection stuff working.
   click through the Menu buttons, see all the pages so far, hear the game music , adjust music volume .
   
   check out the art assets i drew in data folder 
   
   
   
- all art assets + background -- I created in Aseprite
- Game Music -- I created in garageband
- Sound Effects -- Downloaded from freesound.org 
-------------------------------------------------------------------------------------------------------------------------------------------- */






import controlP5.*; // import ControlP5 library
import processing.sound.*; // import Sound library

// using Control P5 for buttons + sliders to keep menu input simpler 
  // mostly used for drawing transparent boxes with on-hover effects. also simplifies button clicking
ControlP5 cp5;

SoundFile music;


// Screen art to load
String[] names = { 
  "menu.png",
  "settings.png",
  "quit.png",
  "difficulty.png",
};

Game game; // Game Class
boolean isOpening;
Image titleScreen;

void setup(){
 size(1920, 1080); // defined screen size
 frameRate(60); 
 initialize();
}

void draw(){
  // commented to skip intro animation for development purposes
  
  //if (isOpening){
  //  titleScreen.display(0, 0);
  //  if (titleScreen.isFinished()){
  //    isOpening = false;
  //  }
  //} else {
  //  game.display();
  //  game.drawGrid();
  //}
  
  
  isOpening = false;
  game.display();
  game.drawGrid();
}


// as well as clicking the ESC on screen, you may hit the ESC button keyboard as well to go back.
void keyPressed(){
  println("key pressed");
  if (key == ESC){
    key = 0; // so as not to exit processing
    game.handleESC();
  } else {
    game.keyPressed(key);
  }
}

void keyReleased(){
  game.keyReleased(key);
}

void mousePressed(){
  game.mousePressed();
}


// ########################## CP5 Controllers ########################## //

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
  game.startGame(0);
}

void hardButton(){
  println("hard BUTTON CLICKED");
  game.startGame(1); 
}


// ########################## INITIALIZATIONS ########################## //


void initialize(){
  isOpening = true;
  titleScreen = new Image("title-anim-", 8, 50);
  
  music = new SoundFile(this, "music.wav");
  cp5 = new ControlP5(this); 
  game = new Game(names, cp5, music);
  game.setCurrScreen(0);
}
