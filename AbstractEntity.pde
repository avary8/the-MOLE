abstract class AbstractEntity {
  Image[] img;
  int currImg;
  PImage bullet;
  PVector loc = new PVector();
  PVector look = new PVector();
  
  boolean isAttacking = false;
  boolean hasHit = false;
  boolean up, down, left, right;
  int lastAttackTime = 0;
  
  float speed, attackCooldown, attackDamage, hitBoxWidth, hitBoxHeight;
  float hitBoxAdj = 1;
  float attackReach = 5;
  
  float health;
  
  AbstractEntity(Image[] img, float x, float y, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach){
    this.img = img;
    loc.x = x;
    loc.y = y;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
    this.hitBoxAdj = hitBoxAdj;
    this.attackReach = attackReach;
    hitBoxWidth = img[0].getWidth() * hitBoxAdj;
    hitBoxHeight = img[0].getHeight() * hitBoxAdj;
  }
  
  AbstractEntity(Image[] img, float x, float y,  String bulletFile, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach){
    this.img = img;
    bullet = loadImage(bulletFile);
    loc.x = x;
    loc.y = y;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
    this.hitBoxAdj = hitBoxAdj;
    this.attackReach = attackReach;
    hitBoxWidth = img[0].getWidth() * hitBoxAdj;
    hitBoxHeight = img[0].getHeight() * hitBoxAdj;
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
    println("DMG: " + dmg);
    health -= dmg;
  }
  
  
  boolean attackIntersects(AbstractEntity entity){
    float attackDirX = 0;
    float attackDirY = 0;
    
    switch (currImg % 4){
      case 0: // Up
        attackDirY = -1; break; 
      case 1: // Right
        attackDirX = 1; break;  
      case 2: // Down
        attackDirY = 1; break;  
      case 3: // Left
        attackDirX = -1; break; 
    }
    
    float entityToX = entity.loc.x - loc.x;
    float entityToY = entity.loc.y - loc.y;
    
    float direction = (attackDirX * entityToX) + (attackDirY * entityToY);

    
    return (direction > 0 && dist(loc.x, loc.y, entity.loc.x, entity.loc.y) < hitBoxWidth + attackReach );
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
    line(loc.x - (entityWidth/2) - attackReach, loc.y, loc.x + (entityWidth/2) + attackReach, loc.y);
    
    fill(0, 0, 0, 0);
    
    //// just a guideline circle . pixel art is 64x64 exported to 500%
    //ellipse(loc.x, loc.y, img[0].getWidth(), img[0].getHeight());

// GREEN 
    stroke(0, 255, 0);
    fill(0, 0, 0, 0);
    
    // hitbox -- if entity gets attacked , and the attack is within this ellipse, they take damage
    ellipse(loc.x, loc.y, entityWidth, entityHeight);
    line(loc.x - entityWidth/2 , loc.y, loc.x + entityWidth/2 , loc.y);

    // just a diagonal guideline
    line(loc.x - (entityWidth/2)  - attackReach , loc.y - (entityHeight/2) - attackReach, loc.x + (entityWidth/2) + attackReach, loc.y + (entityHeight/2) + attackReach);
    
    
// BLUE
    stroke(0, 0, 255);
    
    // melee reach -- when entity attacks "something", it the attack is inside the "something's" hitbox, "something" takes damage
    line(loc.x, loc.y - (entityHeight/2) - attackReach, loc.x, loc.y + (entityHeight/2) + attackReach);
    
  
// YELLOW
    stroke(255, 255, 0);
    
    // circle of melee reach
    ellipse(loc.x, loc.y, entityWidth + ( 2 * attackReach), entityHeight + ( 2 * attackReach));
    
    popMatrix();
  }
  
  
  
}
