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
  
  float hitBoxAdj = 1;
  
  float health;
  
  AbstractEntity(Image[] img, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj){
    this.img = img;
    loc.x = width/2;
    loc.y = height/2;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
    this.hitBoxAdj = hitBoxAdj;
  }
  
  AbstractEntity(Image[] img, String bulletFile, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj){
    this.img = img;
    bullet = loadImage(bulletFile);
    loc.x = width/2;
    loc.y = height/2;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
    this.hitBoxAdj = hitBoxAdj;
  }
  
  
  void display(){
    pushMatrix();
    stroke(255, 255, 0);
    img[currImg].display(loc.x, loc.y);
    
    
    popMatrix();
    
    drawGuides();
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
  
  void attackIntersects(AbstractEntity entity){
    float attackReach = (img[0].getWidth() * hitBoxAdj)/2; // technically, if up or down, use .getHeight(), but images are square so no need to differentiate
    
    
    
    
  
  
  
  }
    
    
  
  // used for debugging
  void drawGuides(){
    
    // projectile viewing line (aka player to where the mouse is pointing)
    PVector end = PVector.add(loc, look);
    line (loc.x, loc.y, end.x, end.y);
    
    pushMatrix();
    
// RED
    
    stroke(255, 0, 0);
    float entityWidth = img[0].getWidth() * hitBoxAdj;
    float entityHeight = img[0].getHeight() * hitBoxAdj;
    
    // melee reach -- when entity attacks "something", it the attack is inside the "something's" hitbox, "something" takes damage
    line(loc.x - (entityWidth/2), loc.y, loc.x + (entityWidth/2), loc.y);
    
    fill(0, 0, 0, 0);
    
    // just a guideline circle . pixel art is 64x64 exported to 500%
    ellipse(loc.x, loc.y, 64*5, 64*5);
    
// GREEN 
    stroke(0, 255, 0);
    fill(0, 0, 0, 0);
    
    // hitbox -- if entity gets attacked , and the attack is within this ellipse, they take damage
    ellipse(loc.x, loc.y, 32*6 * hitBoxAdj, 32*6 * hitBoxAdj);
    
    // just a guideline
    line(loc.x - (entityWidth/2), loc.y - (entityHeight/2), loc.x + (entityWidth/2), loc.y + (entityHeight/2));
    
    
// BLUE
    stroke(0, 0, 255);
    
    // just a guideline
    line(loc.x, loc.y - (entityHeight/2), loc.x, loc.y + (entityHeight/2));
    
    
    popMatrix();
  }
  
  
  
}
