// Player class 
class Player extends AbstractEntity {
  Player(Image[] img, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach){
    super(img, width/2, height/2, speed, health, attackCooldown, attackDamage, hitBoxAdj, attackReach);
    currImg = 10;
  }

  private boolean isImmune = false;
  private float immuneStartTime = 0.0;
  private float immuneDuration = 500;
  
  private boolean checkShield = false;
  private int shieldKillStart = 0;


  // ##########################  GETTERS , SETTERS , Basic functions ########################## //
  
  public void startImmunity(){
    isImmune = true;
    immuneStartTime = millis();
  }
  
  public boolean isImmune(){
   if (isImmune && millis() - immuneStartTime >= immuneDuration){ 
     isImmune = false;
   }
   return isImmune;
  }
  
  // ###### Functions for Upgrades ###### //
  public float modSpeed(){
    speed += 1;
    return speed;
  }
  
  public void modAtkCooldown(float change){
    attackCooldown = attackCooldown * change;
  }
  
  public void modAtkReach (float change){
    attackReach = attackReach * change;
  }
  
  public void modDmg (float change){
    attackDamage = attackDamage * change;
  }
  
  public boolean isCheckingShields(){
    return checkShield; 
  }
  
  public void setCheckShield(){
    checkShield = true;
  }
  
  public void checkShield(int kills){
    if (shieldKillStart == -1){
      shieldKillStart = kills;
    }
    if (kills - shieldKillStart == 100){
      health += 1;
      checkShield = true;
      shieldKillStart = -1;
    }
  }
  
  
  
  // update logic
  public void update(){
    // ensures attack stops when supposed to 
    if (isAttacking && millis () - lastAttackTime > 100){
      isAttacking = false;
      hasHit = false;
      img[currImg].resetFrame();
      currImg = (currImg % 4);
      if (!up && !down && !right && !left){
        currImg += 8;
      }
    }
    
    // allows attacks to automatically succeed each other without having to click (press and release)
    if (mousePressed){ 
      mousePressed();
    }
    
    // adjust location based on key inputs
    if (up) {
      loc.y -= speed;
    }
    if (down){
      loc.y += speed;
    }
    if (left){
      loc.x -= speed;
    }
    if (right){
      loc.x += speed;
    }
    
    loc.x = constrain(loc.x, ((img[0].getWidth() * 0.8) / 2), 3*1920 - ((img[0].getWidth() * 0.8) / 2));
    loc.y = constrain(loc.y, ((img[0].getHeight() * 0.8) / 2), 3* 1080 - ((img[0].getHeight() * 0.8) / 2));
  }
  
  // ##########################  Input Logic ########################## //
  
  // if mouse pressed and we're allowed to attack, attack
  public void mousePressed(){
    if (!isAttacking && canAttack()){
      println("player can attack");
      
      isAttacking = true;
      lastAttackTime = millis();
      currImg = (currImg % 4) + 4;
    }
  }
  
  // if key pressed, set direction and currImg (which is the current animation to show) 
  public void keyPressed(char key){
    switch (key) {
     case 'w': 
       up = true;
       currImg = 0;
       break;
     case 'a': 
       left = true;
       currImg = 3;
       break;
     case 's': 
       down = true;
       currImg = 2;
       break;
     case 'd': 
       right = true;
       currImg = 1;
       break;
     default:
       currImg = 8; // still 
     }
     
     if (isAttacking){ // if we are attacking, use the attack animation for the specified direction which was set during the switch
      currImg = (currImg % 4) + 4;
    }
  }
  
  // if key released, set directional bool false
  public void keyReleased(char key){
    switch (key) {
      case 'w':
        up = false;
        break;
      case 'a': 
       left = false;
       break;
     case 's': 
       down = false;
       break;
     case 'd': 
       right = false;
       break;
     }  
     int prevImg = currImg;
     if (up){
       currImg = 0;
     } else if (down){
       currImg = 2;
     } else if (right){
       currImg = 1;
     } else if (left){
       currImg = 3;
     } else {
       currImg = (prevImg % 4) + 8;
     }
  }
  
  
  
}
