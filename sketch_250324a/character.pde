class Character extends AbstractEntity {
  Character(String entityFile, float speed){
    super(entityFile, width/2, height/2, speed);
  }
  
  Character(String entityFile, String bulletFile, float speed){
    super(entityFile, bulletFile, width/2, height/2, speed);
  }
  
  void setViewingDir(float x, float y){
    lookX = x;
    lookY = y;
  }
  
  void update(){
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
  }
  
  void mouseMoved(){
    setViewingDir(mouseX, mouseY);
  }
  
  void keyPressed(char key){
    
    print(key + " ");
      switch (key) {
       case 'w': 
         up = true;
         println("up");
         break;
       case 'a': 
         left = true;
         println("left");
         break;
       case 's': 
         down = true;
         println("down");
         break;
       case 'd': 
         right = true;
         println("right");
         break;
       }
  }
  
  void keyReleased(char key){
    
    print(key + " ");
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
  }
  
  
  
}
