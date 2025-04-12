class Player extends AbstractEntity {
  Player(Image[] img, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach){
    super(img, width/2, height/2, speed, health, attackCooldown, attackDamage, hitBoxAdj, attackReach);
    currImg = 10;
  }
  
  Player(Image[] img,  String bulletFile, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach){
    super(img, width/2, height/2, bulletFile, speed, health, attackCooldown, attackDamage, hitBoxAdj, attackReach);
  }
  
  /*
      Variables Specific to Player class
  
  */
  private boolean isImmune = false;
  private float immuneStartTime = 0.0;
  private float immuneDuration = 500;


  // GETTERS , SETTERS, and other public functions
  public void setViewingDir(float x, float y){
    look.x = x;
    look.x = y;
  }
  
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
      loc.y +=speed;
    }
    if (left){
      loc.x -=speed;
    }
    if (right){
      loc.x += speed;
    }
    
    loc.x = constrain(loc.x, ((img[0].getWidth() * 0.8) / 2), 3*1920 - ((img[0].getWidth() * 0.8) / 2));
    loc.y = constrain(loc.y, ((img[0].getHeight() * 0.8) / 2), 3* 1080 - ((img[0].getHeight() * 0.8) / 2));
  }
  
  
  
  public void mouseMoved(float camX, float camY){
    //println("x : " +  mouseX + " y: "  + mouseY  + "loc.x: "  + loc.x + " loc.y: " + loc.y + mouseY + " camX : " + camX + " camY " + camY);
    
    PVector dir = new PVector(mouseX  - camX - loc.x, mouseY - camY - loc.y);
    if (dir.mag() > 0){
      dir.normalize();
    }
      
    dir.mult(5000);
    setViewingDir(dir.x, dir.y);
  }
  
  public void mousePressed(){
    if (!isAttacking && canAttack()){
      println("player can attack");
      
      isAttacking = true;
      lastAttackTime = millis();
      currImg = (currImg % 4) + 4;
    }
  }
  

  
  public void keyPressed(char key){
    print(key + " ");
    switch (key) {
     case 'w': 
       up = true;
       currImg = 0;
       println("up");
       break;
     case 'a': 
       left = true;
       currImg = 3;
       println("left");
       break;
     case 's': 
       down = true;
       currImg = 2;
       println("down");
       break;
     case 'd': 
       right = true;
       currImg = 1;
       println("right");
       break;
     default:
       currImg = 8;
     }
     
     if (isAttacking){
      currImg = (currImg % 4) + 4;
    }
  }
  
  public void keyReleased(char key){
    print("r "+ key + " ");
    switch (key) {
      case 'w':
        up = false;
        println("up");
        break;
      case 'a': 
       left = false;
       println("left");
       break;
     case 's': 
       down = false;
       println("down");
       break;
     case 'd': 
       right = false;
       println("right");
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
