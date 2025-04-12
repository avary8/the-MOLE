class UpgradeManager {
  private Button box0, box1, box2, upgradeButton;
  private int selectedUpgrade = -1;
  
  UpgradeManager(){
    initButtons();
  }
  
  // will need to PAUSE GamePlay and then display the UPGRADE SCREEN
  
  // will prob just print the text to screen to save time of making assets
  
  // array to pick random 3, and assign them to the PICK SCREEN 
  
  public void display(){
   pushMatrix();
   resetMatrix();
   strokeWeight(0);
   fill(0, 0, 0, 100);
   rectMode(CENTER);
   rect(width/2, height/2, width - 200, height - 150);
   
   drawUpgrades();

   stroke(255);
   strokeWeight(1);
   line(150, 307.5, 1770, 307.5);
   line(150, 515, 1770, 515);

   line(150, 722.5, 1770, 722.5);
   
   popMatrix();
    
  }
  
  
  public void setSelected(int selected){
    this.selectedUpgrade = selected;
  }
  
  private void drawUpgrades(){
    upgradeCp5.show();
    toggleButtons(true);
  }
  
  public void hideUpgrades(){
    upgradeCp5.hide();
    toggleButtons(false);
    
    
    // revert button colors and curr selection
    
    selectedUpgrade = -1;
    
    upgradeCp5.getController("box0Button")
      .setColorBackground(color(0, 0, 0, 1));
    
    upgradeCp5.getController("box1Button")
    .setColorBackground(color(0, 0, 0, 1));
    
    upgradeCp5.getController("box2Button")
      .setColorBackground(color(0, 0, 0, 1));
  
  }
  
 
  /* something like this im thinkin
    void upgrade(Entity entity, SOME_INDICATION_OF_UPGRADE (maybe enum ? or just array)){
     // maybe also have an array of upgrade numbers or not idk
      
      switch(upgrade){
        case 0:
          entity.modifySpeed( float );
          break;
        case 1:
          entity.modifyAttackCoolDown( float );
          break;
        case 2:
          entity.modifyAttackDamage( float );
          break;
        case 3:
          entity.modifyAttackReach( float );
          break;
        
        etc
        
      }
      
    }
  
  
  */
  
  public void upgrade(){
    hideUpgrades();
    
    // use selectedUpgrade to determine which of the 3... will prob need an array of current 3 unless Button has value i can set 
    
    
    
  }
  
  
  private void toggleButtons(boolean toggle){
    if (toggle){
      box0.show();
      //box1.show();
      //box2.show();
      //upgradeButton.show();
    } else {
      box0.hide();
      //box1.hide();
      //box2.hide();
      //upgradeButton.hide();
    }
  }
  
  
    // ########################## INITIALIZE BUTTONS ########################## //
  
  
  private void initButtons(){

    
    box0 = upgradeCp5.addButton("box0Button")
      .setLabel("placeholder for upgrade 0")
      .setFont(cfont)
      .setPosition(150, 100)
      .setSize(1620, 208)

      .setColorBackground(color(0, 0, 0, 1))  
      .setColorForeground(color(255, 255, 255, 20)) 
      .setColorActive(color(255, 255, 255, 20));  
      
        
    box1 = upgradeCp5.addButton("box1Button")
      .setLabel("placeholder for upgrade 1")
      .setFont(cfont)
      .setPosition(150, 307.5)
      .setSize(1620, 208)
      
      .setColorBackground(color(0, 0, 0, 1))  
      .setColorForeground(color(255, 255, 255, 20)) 
      .setColorActive(color(255, 255, 255, 20));  
      
        
    box2 = upgradeCp5.addButton("box2Button")
      .setLabel("placeholder for upgrade 2")
      .setFont(cfont)
      .setPosition(150, 515)
      .setSize(1620, 208)
      
      .setColorBackground(color(0, 0, 0, 1))  
      .setColorForeground(color(255, 255, 255, 20)) 
      .setColorActive(color(255, 255, 255, 20));  
    

    upgradeButton = upgradeCp5.addButton("upgradeButton")
       .setLabel("confirm")
       .setFont(font)
       .setPosition(560, 722.5)
       .setSize(800, 208)
       
       .setColorBackground(color(0, 0, 0, 1))  
       .setColorForeground(color(255, 255, 255, 20)) 
       .setColorActive(color(255, 255, 255, 20));
       
       
    
    box0.getCaptionLabel().setSize(64);
    box1.getCaptionLabel().setSize(64);
    box2.getCaptionLabel().setSize(64);
    
    upgradeButton.getCaptionLabel().setSize(64);
    
    upgradeCp5.hide();
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
