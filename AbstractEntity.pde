abstract class AbstractEntity {
  protected Image[] img;
  protected int currImg;
  protected PImage bullet;
  protected PVector loc = new PVector();
  protected PVector look = new PVector();
  
  protected boolean isAttacking = false;
  protected boolean hasHit = false;
  protected boolean up, down, left, right;
  protected int lastAttackTime = 0;
  
  protected float speed, attackCooldown, attackDamage, hitBoxWidth, hitBoxHeight;
  protected float hitBoxAdj = 1;
  protected float attackReach = 5;
  
  protected float health;
  
  // Enemy constructor without Image[] 
  // originally was init img array with enemy however, with many many enemies, it is a waste of memory. also i can't declare a static array so modified to just save the array in GamePlay class
  AbstractEntity(float x, float y, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach, float imgWidth, float imgHeight){
    loc.x = x;
    loc.y = y;
    this.speed = speed;
    this.health = health;
    this.attackCooldown = attackCooldown;
    this.attackDamage = attackDamage;
    this.hitBoxAdj = hitBoxAdj;
    this.attackReach = attackReach;
    hitBoxWidth = imgWidth * hitBoxAdj;
    hitBoxHeight = imgHeight * hitBoxAdj;
  }
  
  
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
  
  
  public void display(){
    pushMatrix();
    stroke(255, 255, 0);
    img[currImg].display(loc.x, loc.y);
    
    
    popMatrix();
    
    drawGuides();
  }
  
  
  public boolean getIsAttacking(){
    return isAttacking;
  }
  
  public PVector getLoc(){
    return loc;
  }
  
  public Image[] getImg(){
    return img;
  }
  
  public float getMeleeRange(){
    return hitBoxWidth + (2 * attackReach);
  }
  
  protected boolean canAttack(){
    return millis() - lastAttackTime >= attackCooldown;
  }
  
  public void takeDamage(float dmg){
    println("DMG: " + dmg);
    health -= dmg;
  }
  
  
  public boolean attackIntersects(AbstractEntity entity){
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
  protected void drawGuides(){
    
    // projectile viewing line (aka player to where the mouse is pointing)
    PVector end = PVector.add(loc, look);
    line (loc.x, loc.y, end.x, end.y);
    
    pushMatrix();
    
// RED
    
    stroke(255, 0, 0);

    // melee reach -- when entity attacks "something", it the attack is inside the "something's" hitbox, "something" takes damage
    line(loc.x - (hitBoxWidth/2) - attackReach, loc.y, loc.x + (hitBoxWidth/2) + attackReach, loc.y);
    
    fill(0, 0, 0, 0);
    
    //// just a guideline circle . pixel art is 64x64 exported to 500%
    //ellipse(loc.x, loc.y, img[0].getWidth(), img[0].getHeight());

// GREEN 
    stroke(0, 255, 0);
    fill(0, 0, 0, 0);
    
    // hitbox -- if entity gets attacked , and the attack is within this ellipse, they take damage
    ellipse(loc.x, loc.y, hitBoxWidth, hitBoxHeight);
    line(loc.x - hitBoxWidth/2 , loc.y, loc.x + hitBoxWidth/2 , loc.y);

    // just a diagonal guideline
    line(loc.x - (hitBoxWidth/2)  - attackReach , loc.y - (hitBoxHeight/2) - attackReach, loc.x + (hitBoxWidth/2) + attackReach, loc.y + (hitBoxHeight/2) + attackReach);
    
    
// BLUE
    stroke(0, 0, 255);
    
    // melee reach -- when entity attacks "something", it the attack is inside the "something's" hitbox, "something" takes damage
    line(loc.x, loc.y - (hitBoxHeight/2) - attackReach, loc.x, loc.y + (hitBoxHeight/2) + attackReach);
    
  
// YELLOW
    stroke(255, 255, 0);
    
    // circle of melee reach
    ellipse(loc.x, loc.y, hitBoxWidth + ( 2 * attackReach), hitBoxHeight + ( 2 * attackReach));
    
    popMatrix();
  }
  
  
  
}
