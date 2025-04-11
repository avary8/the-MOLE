// Ava McCormack



/* TODO V2
    [x] implemented good scoping
    
    [x] added GamePlayer class to handle variables when playing the game
    [x] connect current gameplay with menu screens
    [x] complete collision check with hitboxes
    [x] add sfx 
    [x] add overlay on GamePlay
    [x] add death / win screen 
    [x] in game pause (settings)
    
    
    [x] upgrades functionality
      [] implement and write out upgrades
    
    [x] implement levels
      [] adjust number of enemies based on level
    
    
    -- boss

WEIRD BUGS
   [RESOLVED] sfx volume does not change. not sure why not. ive tried everything
         wasnt sure if i'd ever figure it out. put .amp() inside the for loop and then .stop .play right after each other


*/


/* ---------------------------------------- NOTES V2----------------------------------------

- most things implemented. still need to implement: upgrades, levels, bosses

- still need to write most comments too... that's more of a polishing thing I do at the end since things may change

projectile class is made but not completely working and I may not end up using it anyways

- all art assets + background -- I created in Aseprite
- Game Music -- I created in garageband
- Sound Effects -- Downloaded from freesound.org 
-------------------------------------------------------------------------------------------------------------------------------------------- */






import controlP5.*; // import ControlP5 library
import processing.sound.*; // import Sound library

// using Control P5 for buttons + sliders to keep menu input simpler 
  // mostly used for drawing transparent boxes with on-hover effects. also simplifies button clicking
ControlP5 cp5;
ControlP5 upgradeCp5;
ControlFont cfont;

PFont font;

SoundFile music;
SoundFile[] gameSounds;

Game game; // Game Class
GamePlay gamePlay; // GamePlay class
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

void backToMenuButton(){
  println("backToMenu BUTTON CLICKED");
  game.setCurrScreen(0);
}

void resumeButton(){
  println("resume BUTTON CLICKED");
  if (game.getCurrScreen() == 4){
    game.drawGamePlay();
  } else {
    game.startGame(0);
  }
  game.setCurrScreen(-1);
}


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

void upgradeButton(){
  println("upgrade BUTTON CLICKED");
  
  gamePlay.setUpgradeScreenOff();
}




// ########################## INITIALIZATIONS ########################## //

private void initialize(){
  isOpening = true;
  titleScreen = new Image("title-anim-", 8, 50);
  
  font = createFont("AGENCYB.TTF", 64);
  cfont = new ControlFont(font);
  
    
  
  music = new SoundFile(this, "music.wav");
  music.amp(0.5);
  
  gameSounds = new SoundFile[3];
  gameSounds[0] = new SoundFile(this, "hurt.wav");
  gameSounds[1] = new SoundFile(this, "slash_hit.wav");
  gameSounds[2] = new SoundFile(this, "slash_miss.wav");
 
  
  cp5 = new ControlP5(this); 
  upgradeCp5 = new ControlP5(this);
  game = new Game();
  game.setCurrScreen(0);
}
