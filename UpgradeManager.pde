// class to handle the Upgrade screen

class UpgradeManager {
  // StringList so values can be removable
  StringList upgradeStrings = new StringList (new String[]{
    "increase speed by 50% of base speed",
    "decrease attack cooldown by 5%",
    "increase attack range by 5%",
    "increase dmg by 10%",
    "gain 1 shield (life) after 100 kills (once)",
  });
  
  Integer[] currSelection;
  private Player player;
  
  private Button box0, box1, box2, upgradeButton;
  private int selectedUpgrade = -1;
  
  boolean randomize = true;
  
  
  UpgradeManager(Player player){
    initButtons();
    currSelection = new Integer[3];
    this.player = player;
  }
  
  // display the upgrade screen
  public void display(){
    if (randomize){ // if we have not already, we must select 3 random upgrades from array to display to screen
      randomizeUpgradeSelection();
      setLabels();
    }
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
  
  // ##########################  GETTERS , SETTERS , Basic functions ########################## //
  public void setSelected(int selected){
    this.selectedUpgrade = selected;
  }
  
  public int getSelected(){
    return selectedUpgrade;
  }
  
  // draw the buttons to screen
  private void drawUpgrades(){
    upgradeCp5.show();
    toggleButtons(true);
  }
  
  // hide buttons from screen
  public void hideUpgrades(){
    upgradeCp5.hide();
    toggleButtons(false);

    // revert button colors and curr selection
    // ^ once clicked, an upgrade box will highlight, so reset that
    selectedUpgrade = -1;
    randomize = true;
    
    upgradeCp5.getController("box0Button")
      .setColorBackground(color(0, 0, 0, 1));
    
    upgradeCp5.getController("box1Button")
    .setColorBackground(color(0, 0, 0, 1));
    
    upgradeCp5.getController("box2Button")
      .setColorBackground(color(0, 0, 0, 1));
  
  }
  
  // upgrade logic switch
  // once the player clicks an upgrade, the selectedUpgrade var is set, then once player clicks confirm, we use that variable to know which upgrade they want
  // currSelection is the array of 3 upgrades that were randomly picked
  public void upgrade(){
    switch(currSelection[selectedUpgrade]){
      case 0: 
        if (player.modSpeed() == 10){ // cap speed to 10
          upgradeStrings.remove(0);
        }
        break;
      case 1: 
        player.modAtkCooldown(1.05);
        break;
      case 2:
        player.modAtkReach(1.05);
        break;
      case 3:
        player.modDmg(1.10);
        break;
      case 4:
        player.setCheckShield();
        upgradeStrings.remove(4);
        break;
    }
    hideUpgrades();
  }
  
  
  // picks 3 random upgrades to display
  private void randomizeUpgradeSelection(){
    currSelection[0] = (int) random(0, upgradeStrings.size());
    currSelection[1] = (int) random(0, upgradeStrings.size());
    currSelection[2] = (int) random(0, upgradeStrings.size());
    
    while(currSelection[0] == currSelection[1] || currSelection[0] == currSelection[2] || currSelection[1] == currSelection[2]){
      if (currSelection[0] == currSelection[1] || currSelection[0] == currSelection[2]){
       currSelection[0] = (int) random(0, upgradeStrings.size());
      } else {
        currSelection[1] = (int) random(0, upgradeStrings.size());
      }
    }
    randomize = false;
  }
  
  // set the box labels to randomly picked upgrade descriptions
  private void setLabels(){
    box0.setLabel(upgradeStrings.get(currSelection[0]));
    box1.setLabel(upgradeStrings.get(currSelection[1]));
    box2.setLabel(upgradeStrings.get(currSelection[2]));
  }
  
  // show/hide cp5 buttons based on bool
  private void toggleButtons(boolean toggle){
    if (toggle){
      box0.show();
      box1.show();
      box2.show();
      upgradeButton.show();
    } else {
      box0.hide();
      box1.hide();
      box2.hide();
      upgradeButton.hide();
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
