// Ava McCormack


import controlP5.*; // import ControlP5 library
import processing.sound.*; // import Sound library

// using Control P5 for buttons + sliders to keep menu input simpler 
  // mostly used for drawing transparent boxes with on-hover effects. also simplifies button clicking
ControlP5 cp5;
ControlP5 upgradeCp5;
ControlFont cfont;

PFont font;

SoundFile music, mainMusic, bossMusic;
SoundFile[] gameSounds;
float musicVol = 100;
float effectsVol = 100;
  

Game game; // Game Class
GamePlay gamePlay; // GamePlay class
boolean isOpening; // play intro on start
Image titleScreen; // the intro // note Image is a custom class not the PImage class

// set screen size, framerate, and initialize stuff
void setup(){
 size(1920, 1080); // defined screen size
 frameRate(60); 
 initialize();
}

// game class will handle stuff using display
void draw(){
  if (isOpening){
    titleScreen.display(0, 0);
    if (titleScreen.isFinished()){
      isOpening = false;
    }
  } else {
    game.display();
    // game.drawGrid(); // was used for development
  }
}

// ########################## Input Logic Forwards to Game class ########################## //

// as well as clicking the ESC on screen, you may hit the ESC button keyboard as well to go back.
void keyPressed(){
  println("key pressed");
  if (key == ESC){
    key = 0; // so as not to exit processing
    game.handleESC();
  } else {
    game.keyPressed(Character.toLowerCase(key)); // if caps lock is on, convert to lower case
  }
}

void keyReleased(){
  game.keyReleased(Character.toLowerCase(key));
}

void mousePressed(){
  game.mousePressed();
}


// ########################## CP5 Controllers ########################## //

// cp5 button and slider has functions that are called automatically similar to processing key pressed, etc. 
// forward logic to Game and GamePlay classes


// <screen> - <name button>

// menu - start button
void startButton(){
  println("START BUTTON CLICKED");
  game.setCurrScreen(3);
}

// menu - settings button
void settingsButton(){
  println("SETTINGS BUTTON CLICKED");
  game.setCurrScreen(1);
}

// menu - quit button
void quitButton(){
  println("QUIT BUTTON CLICKED");
  game.setCurrScreen(2);
}

// settings and difficulty screen - esc button
void escapeButton(){
  println("ESC BUTTON CLICKED");
  game.handleESC();
}

// quit screen - yes button
void yesButton(){
  println("YES BUTTON CLICKED");
  exit();
}

// quit screen - no button
void noButton(){
  println("No BUTTON CLICKED");
  game.setCurrScreen(0); 
}

// difficulty screen - normal button
void normalButton(){
  println("normal BUTTON CLICKED");
  game.startGame(0);
}

// difficulty screen - hard button
void hardButton(){
  println("hard BUTTON CLICKED");
  game.startGame(1); 
}

// in-game settings - back to menu button
void backToMenuButton(){
  println("backToMenu BUTTON CLICKED");
  gamePlay.hideUpgradeScreen();
  game.setCurrScreen(0);
}

// in-game settings - resume game button
void resumeButton(){
  println("resume BUTTON CLICKED");
  if (game.getCurrScreen() == 4){
    game.drawGamePlay();
  } else {
    game.startGame(gamePlay.getDifficulty());
  }
  game.setCurrScreen(-1);
}

// upgrade screen - first upgrade box 
void box0Button(){
  println("box 0 BUTTON CLICKED");
  gamePlay.setSelected(0);
  upgradeCp5.getController("box0Button")
    .setColorBackground(color(255, 255, 255, 20));
    
  upgradeCp5.getController("box1Button")
    .setColorBackground(color(0, 0, 0, 1));
  
  upgradeCp5.getController("box2Button")
    .setColorBackground(color(0, 0, 0, 1));
}

// upgrade screen - second upgrade box 
void box1Button(){
  println("box 1 BUTTON CLICKED");
  gamePlay.setSelected(1);
  upgradeCp5.getController("box0Button")
    .setColorBackground(color(0, 0, 0, 1));
  
  upgradeCp5.getController("box1Button")
    .setColorBackground(color(255, 255, 255, 20));
    
  upgradeCp5.getController("box2Button")
    .setColorBackground(color(0, 0, 0, 1));
  
}

// upgrade screen - third upgrade box 
void box2Button(){
  println("box 2 BUTTON CLICKED");
  gamePlay.setSelected(2);
  upgradeCp5.getController("box0Button")
    .setColorBackground(color(0, 0, 0, 1));

  upgradeCp5.getController("box1Button")
    .setColorBackground(color(0, 0, 0, 1));
  
  upgradeCp5.getController("box2Button")
    .setColorBackground(color(255, 255, 255, 20));
  
}

// upgrade screen - confirm upgrade button
void upgradeButton(){
  println("upgrade BUTTON CLICKED");
  if (gamePlay.getSelected() != -1){
    gamePlay.setUpgradeScreenOff();
  }
}




// ########################## INITIALIZATIONS ########################## //
// initialize sounds, Game class 
private void initialize(){
  isOpening = true;
  titleScreen = new Image("title-anim-", 8, 50);
  
  font = createFont("AGENCYB.TTF", 64);
  cfont = new ControlFont(font);
  
  mainMusic = new SoundFile(this, "music.wav");
  bossMusic = new SoundFile(this, "boss-music.wav");
  bossMusic.amp(0.5);
  mainMusic.amp(0.5);
  music = mainMusic;

  
  gameSounds = new SoundFile[4];
  gameSounds[0] = new SoundFile(this, "hurt.wav");
  gameSounds[1] = new SoundFile(this, "slash_hit.wav");
  gameSounds[2] = new SoundFile(this, "slash_miss.wav");
  gameSounds[3] = new SoundFile(this, "boss-proj-hit.wav");
 
  
  cp5 = new ControlP5(this); 
  upgradeCp5 = new ControlP5(this);
  game = new Game();
  game.setCurrScreen(0);
}
