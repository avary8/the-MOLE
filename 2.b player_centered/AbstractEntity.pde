abstract class AbstractEntity {
  Image[] img;
  int currImg;
  PImage bullet;
  PVector loc = new PVector();
  PVector look = new PVector();
  float speed;
  boolean isAttacking = false;
  boolean up, down, left, right;
  float attackRate, attackCooldown;
  float attackFrame = 0;
  
  AbstractEntity(Image[] img, float speed, float attackRate){
    this.img = img;
    loc.x = width/2;
    loc.y = height/2;
    this.speed = speed;
    this.attackRate = attackRate;
    this.attackCooldown = 60 / attackRate;
  }
  
  AbstractEntity(Image[] img, String bulletFile, float speed, float attackRate){
    this.img = img;
    bullet = loadImage(bulletFile);
    loc.x = width/2;
    loc.y = height/2;
    this.speed = speed;
    this.attackRate = attackRate;
    this.attackCooldown = 60 / attackRate;
  }
  
  
  void display(){
    stroke(255, 255, 0);
    img[currImg].display(loc.x, loc.y);
    
    PVector end = PVector.add(loc, look);
     
    line (loc.x, loc.y, end.x, end.y);
    
    pushMatrix();
    stroke(255, 0, 0);
    
    float entityWidth = img[0].getWidth() * 0.8;
    float entityHeight = img[0].getHeight() * 0.8;
    
    line(loc.x - (entityWidth/2), loc.y, loc.x + (entityWidth/2), loc.y);
    
    stroke(0, 255, 0);
    fill(0, 0, 0, 0);
    
    ellipse(loc.x, loc.y, 32*6, 32*6);
    
    line(loc.x - (entityWidth/2), loc.y - (entityHeight/2), loc.x + (entityWidth/2), loc.y + (entityHeight/2));
    
    stroke(0, 0, 255);
    
    line(loc.x, loc.y - (entityHeight/2), loc.x, loc.y + (entityHeight/2));
    
    
    popMatrix();
    
  }
  
  
}
