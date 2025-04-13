class Boss extends Enemy {
  Boss(Image[] img, float x, float y, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach){
    super(img, x, y, speed, health, attackCooldown, hitBoxAdj, attackReach);
    projectiles = new ArrayList<Projectile> ();
  }
  
  protected float radiusDist = 30;
  private float xDir, yDir;
  
  private ArrayList<Projectile> projectiles;
  private int lastProjectileTime = 0;
   
   
  public ArrayList<Projectile> getProjectiles (){
    return projectiles;
  }
  
  public void display(){
    pushMatrix();
    stroke(255, 255, 0);
    img[currImg].display(loc.x, loc.y);
    
    
    popMatrix();
    drawGuides();
  }

  
    public void update(float x, float y){
    // if enemy location x/y is less than x/y , we should go in the Positive x/y direction
    // if enemy location x/y is greater than x/y , we should go in the Negative x/y direction
    
    xDir = (loc.x < x) ? 1 : -1; 
    yDir = (loc.y < y) ? 1 : -1;
    
    loc.x += xDir * speed;
    loc.y += yDir * speed;
    
    if (isAttacking && millis() - lastAttackTime > 30){
      isAttacking = false;
      hasHit = false;
    }
    
    if (canAttack()){
      isAttacking = true;
      lastAttackTime = millis();
    } 
    
    if (canShoot()){
      lastProjectileTime = millis();
      
      PVector direction = PVector.sub(new PVector(x, y), loc).normalize();
      projectiles.add(new Projectile(loc, direction.mult(5), 20));
    }
    
    
    for (int i = 0; i < projectiles.size(); i++){
      Projectile p = projectiles.get(i);
      p.update();
      if (!p.isExpired()){
        p.display();
      } else {
       projectiles.remove(i); 
      }
    }
    
        
    // only draw enemies within visible screen 
    if (isWithinRange(x, y, 1600)){
      display(); 
    }
    
    /* --------------------DEBUG TEXT-------------------- */
    //fill(255);
    //text("player to enemy1 dist: " + distance, 400, 400);
    //text("withinRadius: " + withinRadius, 400, 420);
    //text("tracking: " + tracking, 400, 440);
    //text("x to x: " + abs(loc.x - x) , 400, 460);
    //text("y to y: " + abs(loc.y - y) , 400, 480);
    /* --------------------DEBUG TEXT-------------------- */
  
  }
 
  

  public boolean isWithinRange(float x, float y, float radius) {
    float distToPlayer = dist(loc.x, loc.y, x, y);
    return distToPlayer <= radius;
  }
  
  public boolean isWithinRange(float srcX, float srcY, float x, float y, float radius) {
    float distToPlayer = dist(srcX, srcY, x, y);
    return distToPlayer <= radius;
  }
  
  
  // can Boss shoot projectile
  private boolean canShoot(){
    return millis() - lastProjectileTime >= attackCooldown * 10;
  }
  
}
