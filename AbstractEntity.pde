abstract class AbstractEntity {
  Image[] img;
  int currImg;
  PImage bullet;
  PVector loc = new PVector();
  PVector look = new PVector();
  
  boolean isAttacking = false;
  boolean up, down, left, right;
  int lastAttackTime = 0;
  
  float speed, attackCooldown, attackDamage, hitBoxWidth, hitBoxHeight;
  float hitBoxAdj = 1;
  float attackReach = 5;
  
  float health;
  
  AbstractEntity(Image[] img, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach){
    this.img = img;
    loc.x = width/2;
    loc.y = height/2;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
    this.hitBoxAdj = hitBoxAdj;
    this.attackReach = attackReach;
    hitBoxWidth = img[0].getWidth() * hitBoxAdj;
    hitBoxHeight = img[0].getHeight() * hitBoxAdj;
  }
  
  AbstractEntity(Image[] img, String bulletFile, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach){
    this.img = img;
    bullet = loadImage(bulletFile);
    loc.x = width/2;
    loc.y = height/2;
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
    health -= dmg;
  }
  
  //void updateMeleeHitBox(){
  // meleeHitBox.setLocation(loc.x + width/2, loc.y);
  // meleeHitBox.setSize(20, 20);
    
  //}
  
  boolean attackIntersects(AbstractEntity entity){
    float endReach;
    float targetBoundaryX = 0;
    float targetBoundaryY = 0;

    /* 4 Directions (up, right, down, left). Picture index follows same order 
        so  images[0] ---> UP [ACTION 0] 
            images[1] ---> RIGHT [ACTION 0]  
            images[2] ---> DOWN [ACTION 0] 
            images[3] ---> LEFT [ACTION 0]
            
            images[4] ---> UP [ACTION 1] 
            images[5] ---> RIGHT [ACTION 1]  
            images[6] ---> DOWN [ACTION 1] 
            images[7] ---> LEFT [ACTION 1]  
            
        etc
    */
    switch (currImg % 4){
     case 0: // up
       endReach = loc.y + attackReach;
       targetBoundaryY = entity.loc.y - (hitBoxHeight/2);
       if (endReach < targetBoundaryY){
        return true; 
       }
       break;
     case 1: // right
       endReach = loc.x + attackReach;
       targetBoundaryX = entity.loc.x - (hitBoxWidth/2);
       if (endReach > targetBoundaryX){
        return true; 
       }
       break;
     case 2: // down
       endReach = loc.y - attackReach;
       targetBoundaryY = entity.loc.y - (hitBoxHeight/2);
       if (endReach > targetBoundaryY){
        return true; 
       }
       break;
     case 3: // left
       endReach = loc.x - attackReach;
       targetBoundaryX = entity.loc.x + (hitBoxWidth/2);
       if (endReach < targetBoundaryX){
        return true; 
       }
       break;
    }
    return false;
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
