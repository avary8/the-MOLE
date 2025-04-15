// Enemy class 
class Enemy extends AbstractEntity {
  
  Enemy(float x, float y, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach, float imgWidth, float imgHeight){
    super(x, y, speed, health, attackCooldown, 1, hitBoxAdj, attackReach, imgWidth, imgHeight);
  }
  
  Enemy(Image[] img, float x, float y, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach){
    super(img, x, y, speed, health, attackCooldown, 1, hitBoxAdj, attackReach);
  }

  protected float radiusDist = 30;
  private float xDir, yDir;

  // display current image using passed in Image[]
  public void display(Image[] img){
    pushMatrix();
    stroke(255, 255, 0);
    img[currImg].display(loc.x, loc.y);
    
    popMatrix();
    drawGuides(); // used in development. nice guidelines to see boundaries
  }
  
  // update enemy with player's location x, y
  public void update(float x, float y, Image[] img){
    // if enemy location x/y is less than x/y , we should go in the Positive x/y direction
    // if enemy location x/y is greater than x/y , we should go in the Negative x/y direction
    xDir = (loc.x < x) ? 1 : -1; 
    yDir = (loc.y < y) ? 1 : -1;

    // set a primary direction based on distance to x, y (player)
    float xDistance = Math.abs(loc.x - x);
    float yDistance = Math.abs(loc.y - y);

    // if x distance is greater, use horizontal positioning (as in the images where sprite faces left or right)
    if (xDistance > yDistance){
      if (xDir == 1){
        currImg = 5;
      } else {
        currImg = 7;
      }
    } else { // if x distance less than y distance, use vertical positioning (images where sprite faces up or down)
      if (yDir == 1){
        currImg = 6;
      } else {
        currImg = 4;
      }
    }

    loc.x += xDir * speed;
    loc.y += yDir * speed;
    
    // reset bools
    if (isAttacking && millis() - lastAttackTime > 30){
      isAttacking = false;
      hasHit = false;
      img[currImg].resetFrame();

    }
    
    // can attack, so attack
    if (canAttack()){
      isAttacking = true;
      lastAttackTime = millis();
      
      currImg = currImg % 4;
    } 
    
    // only draw if within visible screen 
    if (isWithinRange(x, y, 1600)){
      display(img); 
    }
  }
  
  // used to see if within range of a radius with center at x, y
  public boolean isWithinRange(float x, float y, float radius) {
    float distToPlayer = dist(loc.x, loc.y, x, y);
    return distToPlayer <= radius;
  }
}
