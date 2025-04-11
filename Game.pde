class Game{// commented to skip intro animation for development purposes
  // Screen art to load
  private String[] names = { 
    "menu.png",
    "settings.png",
    "quit.png",
    "difficulty.png",
    "settings-in-game.png",
    "game-lost.png",
    "game-won.png"
  };
  
  private PImage[] screens;

  private int currScreen;
  
  // cp5 buttons and sliders
  private Button startButton, settingsButton, quitButton, escapeButton, yesButton, noButton, normalButton, hardButton, backMenuButton, resumeButton;
  private Slider musicVolSlider, effectsVolSlider;
  
  private float musicVol = 100;
  private float effectsVol = 100;
  
  Game(){
    // load images for screens
    screens = new PImage[names.length];
    for (int i = 0; i < names.length; i++){
      screens[i] = loadImage(names[i]);
    }
    
    initButtons();
    music.loop();
  }
  
    
  public void display(){
    pushMatrix();
    imageMode(CORNER);
    
    if (currScreen >= 0){
      // draw current screen art
      image(screens[currScreen], 0, 0);
    }

    // draw the correct buttons / sliders needed for current screen
    switch (currScreen){ //<>// //<>//
      case -1: // playing game
        switch(gamePlay.getGameStatus()){
          case -1: // playing the game
            gamePlay.updateDraw();
            break;
          case 0: // game LOST
            currScreen = 5;
            break;
          case 1: // game WON
            currScreen = 6;
            break;
        }
        break;
      case 0: // menu
        drawMenu(); 
        break;
      case 1: // settings
        drawSettings();
        break;
      case 2: // quit menu
        drawQuitSettings();
        break;
      case 3: // difficulty menu
        drawDifficulty();
        break;
      case 4: // in-game settings
        drawInGameSettings();
        break;
      case 5: // game LOST 
      case 6: // game WON 
        drawEndGame();
        break;
    }
    
    popMatrix();
  }
  
  
  public void setCurrScreen(int currScreen){
    this.currScreen = currScreen;
  }
  
  public int getCurrScreen(){
    return currScreen;
  }
  
  
  
  public void startGame(int difficulty){
    currScreen = -1;
    drawGamePlay(); // toggles off all buttons
    gamePlay = new GamePlay(difficulty);
    gamePlay.setEffectsVol(effectsVol);
  }
  
  
  // what to do when ESC button (or key) is pressed. logic depends on what screen you are on
  public void handleESC(){
    switch (currScreen){
      case -1: // playing the game , to in-game settings
        cp5.hide();
        currScreen = 4;
        break;
      case 0: // menu screen , go to quit menu 
        cp5.hide(); 
        currScreen = 2;
        break;
      case 1: // settings (from menu) , go to menu screen
        cp5.hide();
        currScreen = 0;
        break;
      case 2: // quit menu , go to menu screen
        cp5.hide();
        currScreen = 0;
        break;
      case 3: // difficulty menu , go to menu screen
        cp5.hide();
        currScreen = 0;
        break;
      case 4: // in-game settings , go to game play
        cp5.hide();
        currScreen = -1;
        break;
    }
  }
  
  public void keyPressed(char key){
    if (currScreen == -1){
      gamePlay.keyPressed(key);
    }
  }

  public void keyReleased(char key){
    if (currScreen == -1){
      gamePlay.keyReleased(key);
    }
  }
    
  public void mousePressed(){
    if (currScreen == -1){
      gamePlay.mousePressed();
    }
  }
  

  
  
  // ########################## DRAW BUTTONS / SLIDERS FOR CURR SCREEN ########################## //
  
  private void drawMenu(){
    cp5.show();
    
    toggleStartMenuButtons(true);
    toggleSettingButtons(false);
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
    toggleInGameSettingButtons(false);
  }
  
  
  private void drawSettings(){
    cp5.show();
    
    toggleStartMenuButtons(false);
    toggleSettingButtons(true);
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
    
    // sets music volume and effects volume based on the sliders
    musicVol = musicVolSlider.getValue();
    effectsVol = effectsVolSlider.getValue();

    music.amp(musicVol / 100.0); // adding 0.5 multiplier will decrease volume even more (as in 100% will be even lower)... i guess it stacks with orgin .amp adjustment since it's looping
  }
  
   private void drawQuitSettings(){
    cp5.show();
    
    toggleStartMenuButtons(false);
    toggleSettingButtons(false);
    toggleQuitMenuButtons(true);
    toggleDifficultyButtons(false);
    toggleInGameSettingButtons(false);
  }
  
  
  private void drawDifficulty(){
    cp5.show();
    
    toggleStartMenuButtons(false);
    
    // can't use toggleSettingsButtons() because we want to show ESC button .. so manually hide the sliders like this
    musicVolSlider.hide();
    effectsVolSlider.hide();
    
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(true);
    toggleInGameSettingButtons(false);
    
    escapeButton.show(); 
  }
  
  public void drawGamePlay(){
    cp5.hide();
    
    toggleStartMenuButtons(false);
    toggleSettingButtons(false);
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
    toggleInGameSettingButtons(false);
  }
  
    private void drawInGameSettings(){
    cp5.show();
    
    toggleStartMenuButtons(false);
    escapeButton.hide();
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
    toggleInGameSettingButtons(true);
    
    // sets music volume and effects volume based on the sliders
    musicVol = musicVolSlider.getValue();
    effectsVol = effectsVolSlider.getValue();
    
    music.amp(musicVol / 100.0);
    gamePlay.setEffectsVol(effectsVol);
  }
  
  
  private void drawEndGame(){
    cp5.show();

    toggleStartMenuButtons(false);
    toggleSettingButtons(false);
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
    
    
    toggleInGameSettingButtons(true);
    
    musicVolSlider.hide();
    effectsVolSlider.hide();
    pushMatrix();
    textFont(font);
    textSize(64);
    text(gamePlay.getKills(), 1300, 517);
    text(gamePlay.getLevel(), 1300, 617);
    popMatrix();
  }
  
  // ########################## SHOW/HIDE FUNCTIONS FOR BUTTONS / SLIDERS ########################## //
  
  // grouped buttons/sliders by which screen they appear on, then show / hide depending on boolean passed
  
  private void toggleStartMenuButtons(boolean toggle){
    if (toggle){
      startButton.show();
      settingsButton.show();
      quitButton.show();
    } else { 
      startButton.hide();
      settingsButton.hide();
      quitButton.hide();
    }
  }

  
  private void toggleSettingButtons(boolean toggle){
    if (toggle){
      escapeButton.show();
      musicVolSlider.show();
      effectsVolSlider.show();
    } else { 
      escapeButton.hide();
      musicVolSlider.hide();
      effectsVolSlider.hide();
    }
  }
  
  private void toggleQuitMenuButtons(boolean toggle){
    if (toggle){
      yesButton.show();
      noButton.show();
    } else { 
      yesButton.hide();
      noButton.hide();
    }
  }
  
  private void toggleDifficultyButtons(boolean toggle){
    if (toggle){
      normalButton.show();
      hardButton.show();
    } else { 
      normalButton.hide();
      hardButton.hide();
    }
  }
  
  
  private void toggleInGameSettingButtons(boolean toggle){
   if (toggle){
     musicVolSlider.show();
     effectsVolSlider.show();
     backMenuButton.show();
     resumeButton.show();
   } else {
     musicVolSlider.hide();
     effectsVolSlider.hide();
     backMenuButton.hide();
     resumeButton.hide();
   }
    
  }
  
  
  
  
  // ########################## INITIALIZE BUTTONS ########################## //
  
  
  private void initButtons(){
    int sliderHeight = 75;
    int sliderWidth = 600;
    
    int xPos = (width/2) - (sliderWidth/2);
    int yPos = (height/2);
    
    
    // ----------------------- START MENU ---------------------
    
    startButton = cp5.addButton("startButton")
    .setLabel("")
    .setPosition(812, 27)
    .setSize(306, 194)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(0, 0, 0, 20)) 
    .setColorActive(color(0, 0, 0, 20)); 
    
    
    settingsButton = cp5.addButton("settingsButton")
    .setLabel("")
    .setPosition(812, 240)
    .setSize(568, 194)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(0, 0, 0, 20)) 
    .setColorActive(color(0, 0, 0, 20)); 
    
    
    
    quitButton = cp5.addButton("quitButton")
    .setLabel("")
    .setPosition(812, 430)
    .setSize(288, 194)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(0, 0, 0, 20)) 
    .setColorActive(color(0, 0, 0, 20)); 
    
    
   
    // ----------------------- Settings ---------------------
    
    
    
    escapeButton = cp5.addButton("escapeButton")
    .setLabel("")
    .setPosition(30, 17)
    .setSize(131, 85)

    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(0, 0, 0, 40)) 
    .setColorActive(color(0, 0, 0, 40)); 
    
    escapeButton.getCaptionLabel().setSize(escapeButton.getHeight()/2);
    
    
    musicVolSlider = cp5.addSlider("musicVol")
    .setCaptionLabel("")
    .setPosition(xPos, yPos - 135)
    .setRange(0, 100)
    .setValue(musicVol)
    .setNumberOfTickMarks(101)
    .showTickMarks(false)
    .setDecimalPrecision(0)
    .setSize(sliderWidth, sliderHeight)
    .setFont(cfont)
    .setColorForeground(color(53, 140, 36))
    .setColorActive(color(53, 177, 36))
    ;
   
    
  effectsVolSlider = cp5.addSlider("effectsVol")
    .setCaptionLabel("")
    .setPosition(xPos, 675)
    .setRange(0, 100)
    .setValue(effectsVol)
    .setNumberOfTickMarks(101)
    .showTickMarks(false)
    .setDecimalPrecision(0)
    .setSize(sliderWidth, sliderHeight)
    .setFont(cfont)
    .setColorForeground(color(53, 140, 36))
    .setColorActive(color(53, 177, 36))
    ;
    
    
    // ----------------------- Quit Settings ---------------------
    
    yesButton = cp5.addButton("yesButton")
    .setLabel("")
    .setPosition(680, 490)
    .setSize(145, 100)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(255, 255, 255, 20)) 
    .setColorActive(color(255, 255, 255, 20)); 
    
    
    
    noButton = cp5.addButton("noButton")
    .setLabel("")
    .setPosition(1130, 490)
    .setSize(100, 100)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(255, 255, 255, 20)) 
    .setColorActive(color(255, 255, 255, 20)); 

    
    // ----------------------- Difficulty Settings ---------------------
    
    normalButton = cp5.addButton("normalButton")
    .setLabel("")
    .setPosition(362, 284)
    .setSize(248, 102)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(255, 255, 255, 20)) 
    .setColorActive(color(255, 255, 255, 20)); 
    
    
    
    hardButton = cp5.addButton("hardButton")
    .setLabel("")
    .setPosition(1357, 284)
    .setSize(167, 102)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(255, 255, 255, 20)) 
    .setColorActive(color(255, 255, 255, 20)); 
    
    
        // ----------------------- In-Game Settings ---------------------
    
    backMenuButton = cp5.addButton("backToMenuButton")
    .setLabel("")
    .setPosition(353, 875)
    .setSize(237, 45)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(255, 255, 255, 20)) 
    .setColorActive(color(255, 255, 255, 20)); 
    
    
    
    resumeButton = cp5.addButton("resumeButton")
    .setLabel("")
    .setPosition(1375, 875)
    .setSize(185, 45)
    
    .setColorBackground(color(0, 0, 0, 1))  
    .setColorForeground(color(255, 255, 255, 20)) 
    .setColorActive(color(255, 255, 255, 20)); 
    
    
    cp5.hide();
  }
  
  
  // used for debugging
  
  private void drawGrid(){

    //pushMatrix();
    //stroke(255, 0, 0);
    //line(width/2, 0, width/2, height);
    //line(0, height/2, width, height/2);
    
    
    // play
    //stroke(0, 255, 0);
    //line(width/2 - 127, 0, width/2 - 127, height);
    //line(width/2 + 137, 0, width/2 + 137, height);

    //line(0, 48, width, 48);
    //line(0, 220, width, 220);
    
    //// settings 
    //stroke(0, 255, 0);
    //line(width/2 + 400, 0, width/2 + 400, height);

    //line(0, height/2 - 100 , width, height/2 - 100 );
    
    //// quit 
    //stroke(0, 0, 255);
    
    //line(width/2 + 120, 0, width/2 + 120, height);
    
    //line(0, height/2 + 65, width, height/2 + 65);
    
    
    //// esc button
    //stroke(255, 20, 147);
    //// top / bottom
    //line(0, 22 , width, 22);
    //line(0, 97, width, 97);
    //// left right
    //line(35, 0, 35, height);
    //line(156, 0, 156, height);

    
    //// quit -- buttons
    //stroke(255, 20, 147);
    //// top / bottom
    //line(0, 500 , width, 500);
    //line(0, 580, width, 580);
    //// yes
    //line(690, 0, 690, height);
    //line(815, 0, 815, height);
    //// no
    //line(1140, 0, 1140, height);
    //line(1220, 0, 1220, height);
    
    
    //// difficulty
    //stroke(255, 255, 0);
    //// top / bottom
    //line(0, 294 , width, 294);
    //line(0, 366, width, 366);
    //// normal
    //line(372, 0, 372, height);
    //line(600, 0, 600, height);
    //// hard
    //line(1367, 0, 1367, height);
    //line(1514, 0, 1514, height);
    
    //// in-game settings / game over 
    //stroke(255, 255, 0);
    //// top / bottom
    //line(0, 875 , width, 875);
    //line(0, 920, width, 920);
    //// back/quit to menu
    //line(353, 0, 353, height);
    //line(590, 0, 590, height);
    //// play again / resume
    //line(1375, 0, 1375, height);
    //line(1560, 0, 1560, height);
    
    
    
    //popMatrix();
  }

 
  
}
