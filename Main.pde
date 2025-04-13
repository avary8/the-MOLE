// Ava McCormack



/* V3 Progress
    [x] upgrades functionality
      [x] implement and write out upgrades

    [] boss

WEIRD BUGS
   [RESOLVED] sfx volume does not change. not sure why not. ive tried everything
         wasnt sure if i'd ever figure it out. put .amp() inside the for loop and then .stop .play right after each other

   [RESOLVED] modifying speed like (speed * change) makes everything go in slo-mo
         speed doesn't like to be decimal... so just going to increase by whole number
*/


/* ---------------------------------------- NOTES V3----------------------------------------



projectile class is made but not completely working and I may not end up using it anyways
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
  //if (isOpening){
  //  titleScreen.display(0, 0);
  //  if (titleScreen.isFinished()){
  //    isOpening = false;
  //  }
  //} else {
  //  game.display();
  //  game.drawGrid();
  //}
  
  isOpening = true;
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
    game.keyPressed(Character.toLowerCase(key)); // if caps lock is on, conver to lower case
  }
}

void keyReleased(){
  game.keyReleased(Character.toLowerCase(key));
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
  gamePlay.hideUpgradeScreen();
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
  if (gamePlay.getSelected() != -1){
    gamePlay.setUpgradeScreenOff();
  }
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
