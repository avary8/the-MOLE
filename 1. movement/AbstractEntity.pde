abstract class AbstractEntity {
  Image[] img;
  int currImg;
  PImage bullet;
  PVector loc = new PVector();
  float lookX, lookY, speed;
  boolean up, down, left, right;
  
  AbstractEntity(Image[] img, float x, float y, float speed){
    this.img = img;
    loc.x = x;
    loc.y = y;
    this.speed = speed;
  }
  
  AbstractEntity(Image[] img, String bulletFile, float x, float y, float speed){
    this.img = img;
    bullet = loadImage(bulletFile);
    loc.x = x;
    loc.y = y;
    this.speed = speed;
  }
  
  void display(){
    img[currImg].display(loc.x, loc.y);
    line (loc.x, loc.y, lookX, lookY);
    
    pushMatrix();
    stroke(255, 0, 0);
    
    float entityWidth = img[0].getWidth() * 0.8;
    
    line(loc.x, loc.y, loc.x + entityWidth, loc.y);
    
    stroke(0, 255, 0);
    fill(0, 0, 0, 0);
    
    ellipse(loc.x, loc.y, 32*6, 32*6);
    
    line(loc.x, loc.y, loc.x + entityWidth, loc.y + entityWidth);
    
    stroke(0, 0, 255);
    
    line(loc.x + entityWidth, loc.y, loc.x + entityWidth, loc.y + entityWidth);
    
    stroke(255, 255, 0);
    
    line(loc.x, loc.y + entityWidth, loc.x + entityWidth, loc.y + entityWidth);
    
    
    popMatrix();
    
  }
  
  
}
