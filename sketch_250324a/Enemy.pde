class Enemy extends AbstractEntity {
  Enemy(String entityFile, float x, float y, float speed){
    super(entityFile, x, y, speed);
  }
  
  Enemy(String entityFile, String bulletFile, float x, float y, float speed){
    super(entityFile, bulletFile, x, y, speed);
  }
  
  float radiusDist = 30;
  float xDir, yDir;
  boolean withinRadius = false;
  boolean tracking = true;
  boolean lockDir = false;
  
  
  void setViewingDir(float x, float y){
    lookX = x;
    lookY = y;
  }
  
  
  void update(float x, float y){
    float distance = dist(loc.x, loc.y, x, y);
    boolean inRadius = (distance < radiusDist) ? true : false;
    
    if (tracking){
      xDir = (loc.x < x) ? 1 : -1;
      yDir = (loc.y < y) ? 1 : -1;
      
      if (distance < radiusDist){
        withinRadius = true; 
      }
      
      if (withinRadius && !inRadius){
        tracking = false;
      }
    } else if (withinRadius && inRadius){
      tracking = true;
    }

    loc.x += xDir * speed;
    loc.y += yDir * speed;
    
    /* --------------------DEBUG TEXT-------------------- */
    fill(255);
    text("player to enemy1 dist: " + distance, 400, 400);
    text("withinRadius: " + withinRadius, 400, 420);
    text("tracking: " + tracking, 400, 440);
    text("x to x: " + abs(loc.x - x) , 400, 460);
    text("y to y: " + abs(loc.y - y) , 400, 480);
    /* --------------------DEBUG TEXT-------------------- */

  }
  
}
