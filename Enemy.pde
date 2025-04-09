class Enemy extends AbstractEntity {
  Enemy(Image[] img, float x, float y, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach){
    super(img, x, y, speed, health, attackCooldown, 1, hitBoxAdj, attackReach);
  }
  
  Enemy(Image[] img, float x, float y, String bulletFile, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach){
    super(img, x, y, bulletFile, speed, health, attackCooldown, 1, hitBoxAdj, attackReach);
  }
  
  float radiusDist = 30;
  float xDir, yDir, lastDir;
  boolean withinRadius = false;
  

  //boolean tracking = true;
  //boolean lockDir = false;
  
  
  void update(float x, float y){
    
    // this is for tracking within a radius and then outside radius, continue in a direction until within radius again.
    // changing to always tracking 
    
    // boolean inRadius = (distance < radiusDist) ? true : false;
    // float distance = dist(loc.x, loc.y, x, y);
    //if (tracking){
    //  xDir = (loc.x < x) ? 1 : -1;
    //  yDir = (loc.y < y) ? 1 : -1;
      
    //  if (distance < radiusDist){
    //    withinRadius = true; 
    //  }
      
    //  if (withinRadius && !inRadius){
    //    tracking = false;
    //  }
    //} else if (withinRadius && inRadius){
    //  tracking = true;
    //}
    

    // if enemy location x/y is less than x/y , we should go in the Positive x/y direction
    // if enemy location x/y is greater than x/y , we should go in the Negative x/y direction
    xDir = (loc.x < x) ? 1 : -1; 
    yDir = (loc.y < y) ? 1 : -1;

    // set a primary direction based on distance to x, y (player)
    float xDistance = Math.abs(loc.x - x);
    float yDistance = Math.abs(loc.y - y);

    // if x distance is greater, use horizontal positioning
    if (xDistance > yDistance){
      if (xDir == 1){
        currImg = 5;
      } else {
        currImg = 7;
      }
    } else { // if x distance less than y distance, use vertical positioning
      if (yDir == 1){
        currImg = 6;
      } else {
        currImg = 4;
      }
    }

      
    loc.x += xDir * speed;
    loc.y += yDir * speed;
    
    
    look.x = xDir;
    look.y = yDir;
    
    if (isAttacking && millis() - lastAttackTime > 30){
      isAttacking = false;
      hasHit = false;
      img[currImg].resetFrame();

    }
    
    if (canAttack()){
      isAttacking = true;
      lastAttackTime = millis();
      
      currImg = currImg % 4;
    } 

    
    /* --------------------DEBUG TEXT-------------------- */
    fill(255);
    //text("player to enemy1 dist: " + distance, 400, 400);
    //text("withinRadius: " + withinRadius, 400, 420);
    //text("tracking: " + tracking, 400, 440);
    text("x to x: " + abs(loc.x - x) , 400, 460);
    text("y to y: " + abs(loc.y - y) , 400, 480);
    /* --------------------DEBUG TEXT-------------------- */

  }
}
