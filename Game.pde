class Game{
  PFont font;
  SoundFile music;
  PImage[] screens;
  Image titleAnimaton;
  
  int currScreen;
  
  GamePlay gamePlay;
  
  // cp5 , buttons , and sliders
  ControlP5 cp5; 
  Button startButton, settingsButton, quitButton, escapeButton, yesButton, noButton, normalButton, hardButton;
  Slider musicVolSlider, effectsVolSlider;
  
  int musicVol = 100;
  int effectsVol = 100;
  
  Game(String[] names, ControlP5 cp5, SoundFile music){
    // load images for screens
    screens = new PImage[names.length];
    for (int i = 0; i < names.length; i++){
      screens[i] = loadImage(names[i]);
    }
    this.cp5 = cp5;
    this.music = music;
    
    font = createFont("AGENCYB.TTF", 64);
    initButtons();
    music.loop();
    
    
  }
  
    
  void display(){
    pushMatrix();
    imageMode(CORNER);
    
    if (currScreen >= 0){
      // draw current screen art
      image(screens[currScreen], 0, 0);
    }

    // draw the correct buttons / sliders needed for current screen
    switch (currScreen){ //<>// //<>//
      case -1: // playing game
        gamePlay.updateDraw();
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
    }
    
    popMatrix();
  }
  
  
  void setCurrScreen(int currScreen){
    this.currScreen = currScreen;
  }
  
  
  
  void startGame(int difficulty){
    currScreen = -1;
    drawGamePlay(); // toggles off all buttons
    gamePlay = new GamePlay(difficulty);
  }
  
  
  // what to do when ESC button (or key) is pressed. logic depends on what screen you are on
  void handleESC(){
    switch (currScreen){
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
    }
  }
  
  void keyPressed(char key){
    if (currScreen == -1){
      gamePlay.keyPressed(key);
    }
  }

  void keyReleased(char key){
    if (currScreen == -1){
      gamePlay.keyReleased(key);
    }
  }
    
  void mousePressed(){
    if (currScreen == -1){
      gamePlay.mousePressed();
    }
  }
  

  
  
  // ########################## DRAW BUTTONS / SLIDERS FOR CURR SCREEN ########################## //
  
  void drawMenu(){
    cp5.show();
    
    toggleStartMenuButtons(true);
    toggleSettingButtons(false);
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
  }
  
  
  void drawSettings(){
    cp5.show();
    
    toggleStartMenuButtons(false);
    toggleSettingButtons(true);
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
    
    // sets music volume and effects volume based on the sliders
    musicVol = int(musicVolSlider.getValue());
    effectsVol = int(effectsVolSlider.getValue());
    
    music.amp(musicVol / 100.0);
  }
  
   void drawQuitSettings(){
    cp5.show();
    
    toggleStartMenuButtons(false);
    toggleSettingButtons(false);
    toggleQuitMenuButtons(true);
    toggleDifficultyButtons(false);
  }
  
  
  void drawDifficulty(){
    cp5.show();
    
    toggleStartMenuButtons(false);
    
    // can't use toggleSettingsButtons() because we want to show ESC button .. so manually hide the sliders like this
    musicVolSlider.hide();
    effectsVolSlider.hide();
    
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(true);
    
    escapeButton.show(); 
  }
  
  void drawGamePlay(){
    cp5.hide();
    
    toggleStartMenuButtons(false);
    toggleSettingButtons(false);
    toggleQuitMenuButtons(false);
    toggleDifficultyButtons(false);
    
  }
  
  // ########################## SHOW/HIDE FUNCTIONS FOR BUTTONS / SLIDERS ########################## //
  
  // grouped buttons/sliders by which screen they appear on, then show / hide depending on boolean passed
  
  void toggleStartMenuButtons(boolean toggle){
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

  
  void toggleSettingButtons(boolean toggle){
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
  
  void toggleQuitMenuButtons(boolean toggle){
    if (toggle){
      yesButton.show();
      noButton.show();
    } else { 
      yesButton.hide();
      noButton.hide();
    }
  }
  
  void toggleDifficultyButtons(boolean toggle){
    if (toggle){
      normalButton.show();
      hardButton.show();
    } else { 
      normalButton.hide();
      hardButton.hide();
    }
  }
  
  
  
  
  // ########################## INITIALIZE BUTTONS ########################## //
  
  
  void initButtons(){
    ControlFont cfont = new ControlFont(font);
    
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
    
    
    musicVolSlider = cp5.addSlider("music volume")
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
   
    
  effectsVolSlider = cp5.addSlider("effects volume")
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
    
    
    cp5.hide();
  }
  
  
  // used for debugging
  
  void drawGrid(){
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
    
    
    //popMatrix();
  }

 
  
}
