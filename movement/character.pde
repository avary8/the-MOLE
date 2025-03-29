class Character extends AbstractEntity {
  Character(Image[] img, float speed){
    super(img, width/2, height/2, speed);
  }
  
  Character(Image[] img,  String bulletFile, float speed){
    super(img, bulletFile, width/2, height/2, speed);
  }
  
  boolean attacking = false;


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
  
  void mousePressed(){
    currImg = (currImg % 4) + 4;
    attacking = true;
  }
  
  void mouseReleased(){
    currImg = (currImg % 4);
    attacking = false;
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
       if (attacking){
         currImg = (currImg % 4) + 4;
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
