class Game{
  PFont font;
  PImage[] screens;
  int currScreen;
  ControlP5 cp5;
  
  Button escapeButton;
  Textlabel musicVolLabel, effectsVolLabel;
  Slider musicVolSlider, effectsVolSlider;
  
  
  int musicVol = 100;
  int effectsVol = 100;
  
  Game(String[] names, ControlP5 cp5){
    screens = new PImage[names.length];
    for (int i = 0; i < names.length; i++){
      screens[i] = loadImage(names[i]);
    }
    this.cp5 = cp5;
    font = createFont("AGENCYB.TTF", 64);

    initButtons();
  }
  
  
  void display(){
    pushMatrix();
    imageMode(CORNER);
    if (currScreen == 1){
      background(59, 33, 28);
      drawSettings();
    } else {
      image(screens[currScreen], 0, 0);
    }
    popMatrix();
  }
  
  
  
  void drawSettings(){
    cp5.show();
    musicVolLabel.draw();
    effectsVolLabel.draw();
    
    musicVol = int(musicVolSlider.getValue());
    effectsVol = int(effectsVolSlider.getValue());
    
  }
  
  void drawGrid(){
    pushMatrix();
    stroke(255, 0, 0);
    line(width/2, 0, width/2, height);
    line(0, height/2, width, height/2);
    
    
    //// play
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
    
    popMatrix();
  
  }
  
  
  void setCurrScreen(int currScreen){
    this.currScreen = currScreen;
  }
  
  
  void handleESC(){
    switch (currScreen){
      case 1:
        cp5.hide();
        currScreen = 0;
        break;
    }
  }
  
  
  void handleClick(){
    if (mouseX > (width/2) - 128){
      if (mouseX < (width/2) + 138 && mouseY > 47 && mouseY < 221 ){
        
        println("START");
      } else if (mouseX < (width/2) + 400 && mouseY > 220 && mouseY < (height/2) - 101){
        currScreen = 1;
        println("SETTINGS");
        
      } else if (mouseX < (width/2) + 120  && mouseY > (height/2) - 100 && mouseY < (height/2) + 65){
        println("QUIT");
        
      }
    }

  }
  
  
  void initButtons(){
    ControlFont cfont = new ControlFont(font);

    int sliderHeight = 75;
    int sliderWidth = 600;
    
    int xPos = (width/2) - (sliderWidth/2);
    int yPos = (height/2);
    
    
    escapeButton = cp5.addButton("escapeButton")
    .setLabel("ESC")
    .setPosition(50, 50)
    .setSize(100, 70)
    .setFont(cfont)
    
    .setColorBackground(color(59, 33, 28))
    .setColorForeground(color(53, 140, 36))
    .setColorLabel(color(255))
    .setColorActive(color(53, 177, 36));
    
    escapeButton.getCaptionLabel().setSize(escapeButton.getHeight()/2);
    
    
    musicVolLabel = cp5.addTextlabel("Music Volume")
    .setValue("Music Volume")
    .setFont(cfont)
    .setPosition(xPos, yPos-200);
    
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
    
   effectsVolLabel = cp5.addTextlabel("Effects Volume")
    .setValue("Effects Volume")
    .setFont(cfont)
    .setPosition(xPos, yPos + 60);
    
  effectsVolSlider = cp5.addSlider("effects volume")
    .setCaptionLabel("")
    .setPosition(xPos, effectsVolLabel.getPosition()[1] + 65)
    .setRange(0, 100)
    .setValue(effectsVol)
    .setNumberOfTickMarks(101)
    .showTickMarks(false)
    .setDecimalPrecision(0)
    .setFont(cfont)
    .setSize(sliderWidth, sliderHeight)
    .setColorForeground(color(53, 140, 36))
    .setColorActive(color(53, 177, 36))
    ;
    
    
    cp5.hide();
  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
