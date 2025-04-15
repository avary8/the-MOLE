// Special class for Boss, since it can shoot projectiles
class Boss extends Enemy {
  Boss(Image[] img, float x, float y, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach){
    super(img, x, y, speed, health, attackCooldown, hitBoxAdj, attackReach);
    projectiles = new ArrayList<Projectile> ();
  }
  
  
  protected float radiusDist = 30;
  private float xDir, yDir;
  
  private ArrayList<Projectile> projectiles;
  private int lastProjectileTime = 0;
  
  
  // update logic for Boss
  public void update(float x, float y){
    // if enemy location x/y is less than x/y , we should go in the Positive x/y direction
    // if enemy location x/y is greater than x/y , we should go in the Negative x/y direction
    xDir = (loc.x < x) ? 1 : -1; 
    yDir = (loc.y < y) ? 1 : -1;
    
    loc.x += xDir * speed;
    loc.y += yDir * speed;
    
    // reset bools
    if (isAttacking && millis() - lastAttackTime > 30){
      isAttacking = false;
      hasHit = false;
    }
    
    // can attack, so attack
    if (canAttack()){
      isAttacking = true;
      lastAttackTime = millis();
    } 
    
    // can shoot, so add new projectile to list
    if (canShoot()){
      lastProjectileTime = millis();
      
      PVector direction = PVector.sub(new PVector(x, y), loc).normalize();
      projectiles.add(new Projectile(loc, direction.mult(5), 20));
    }
    
    // update and display projectiles. 
    for (int i = 0; i < projectiles.size(); i++){
      Projectile p = projectiles.get(i);
      p.update();
      if (!p.isExpired()){
        p.display();
      } else {
       projectiles.remove(i); 
      }
    }
    
    
    // only draw Boss if within visible screen 
    if (isWithinRange(x, y, 1600)){
      display(); 
    }
  }
 
    
  public ArrayList<Projectile> getProjectiles (){
    return projectiles;
  }
  
  // slightly modified (see Enemy isWithinRange()) this one is used for projectiles. pass in location of projectile
  public boolean isWithinRange(float srcX, float srcY, float x, float y, float radius) {
    float distToPlayer = dist(srcX, srcY, x, y);
    return distToPlayer <= radius;
  }
  
  
  // can Boss shoot projectile -- is cooldown over 
  private boolean canShoot(){
    return millis() - lastProjectileTime >= attackCooldown * 10;
  }
  
}
