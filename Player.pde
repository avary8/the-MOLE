class Character extends AbstractEntity {
  Character(Image[] img, float speed, float attackRate){
    super(img, speed, attackRate);
  }
  
  Character(Image[] img,  String bulletFile, float speed, float attackRate){
    super(img, bulletFile, speed, attackRate);
  }

  void setViewingDir(float x, float y){
    look.x = x;
    look.x = y;
  }
  
  void update(){
    if (isAttacking){
      attackCooldown--;
      if (attackCooldown <= 0) {
        if (attackFrame > 6){
          isAttacking = false;
          attackCooldown = 60 / attackRate; 
        } else {
          if (attackFrame == 0){
            currImg = (currImg % 4) + 4;
          }
          attackFrame += 1;
        }
        println("attackCooldown : " + attackCooldown + "attack Frame : " + attackFrame);
      }
    }
    
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
  
  void mouseMoved(float camX, float camY){
    //println("x : " +  mouseX + " y: "  + mouseY  + "loc.x: "  + loc.x + " loc.y: " + loc.y + mouseY + " camX : " + camX + " camY " + camY);
    
    PVector dir = new PVector(mouseX  - camX - loc.x, mouseY - camY - loc.y);
    if (dir.mag() > 0){
      dir.normalize();
    }
      
    dir.mult(5000);
    setViewingDir(dir.x, dir.y);
  }
  
  void mousePressed(){
    isAttacking = true;
    attackCooldown--;
    if (attackCooldown <= 0) {
      currImg = (currImg % 4) + 4;
      attackCooldown = 60 / attackRate; 
      isAttacking = false;
    }
  }
  
  void mouseReleased(){
    currImg = (currImg % 4);
    isAttacking = false;
  }
  
  void keyPressed(char key){
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
  }
  
  void keyReleased(char key){
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
