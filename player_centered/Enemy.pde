class Enemy extends AbstractEntity {
  Enemy(Image[] img, float x, float y, float speed){
    super(img, speed);
  }
  
  Enemy(Image[] img, String bulletFile, float speed){
    super(img, bulletFile, speed);
  }
  
  float radiusDist = 30;
  float xDir, yDir;
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
    

    xDir = (loc.x < x) ? 1 : -1;
    yDir = (loc.y < y) ? 1 : -1;

    loc.x += xDir * speed;
    loc.y += yDir * speed;
    
    
    look.x = xDir;
    look.y = yDir;
    
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
