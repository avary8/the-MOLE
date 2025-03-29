abstract class AbstractEntity {
  PImage img;
  PImage bullet;
  PVector loc = new PVector();
  float lookX, lookY, speed;
  boolean up, down, left, right;
  
  AbstractEntity(String entityFile, float x, float y, float speed){
    img = loadImage(entityFile);
    loc.x = x;
    loc.y = y;
    this.speed = speed;
  }
  
  AbstractEntity(String entityFile, String bulletFile, float x, float y, float speed){
    img = loadImage(entityFile);
    bullet = loadImage(bulletFile);
    loc.x = x;
    loc.y = y;
    this.speed = speed;
  }
  
  void display(){
    image(img, loc.x, loc.y, 20, 20);
    line (loc.x, loc.y, lookX, lookY);
  }
  
  
}
