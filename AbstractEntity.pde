abstract class AbstractEntity {
  Image[] img;
  int currImg;
  PImage bullet;
  PVector loc = new PVector();
  PVector look = new PVector();
  float speed;
  boolean isAttacking = false;
  boolean up, down, left, right;
  float attackCooldown;
  int lastAttackTime = 0;
  float attackDamage;
  
  
  float health;
  
  AbstractEntity(Image[] img, float speed, float health, float attackCooldown, float attackDamage){
    this.img = img;
    loc.x = width/2;
    loc.y = height/2;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
  }
  
  AbstractEntity(Image[] img, String bulletFile, float speed, float health, float attackCooldown, float attackDamage){
    this.img = img;
    bullet = loadImage(bulletFile);
    loc.x = width/2;
    loc.y = height/2;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
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
  
  boolean canAttack(){
    return millis() - lastAttackTime >= attackCooldown;
  }
  
  void takeDamage(float dmg){
    health -= dmg;
  }
  
  //void updateMeleeHitBox(){
  // meleeHitBox.setLocation(loc.x + width/2, loc.y);
  // meleeHitBox.setSize(20, 20);
    
  //}
  
  
}
