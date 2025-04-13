class Projectile extends PVector {
  private PVector loc = new PVector();
  private PVector vel = new PVector();
  private int lifeSpan = 300;
  private float damage = 1;
  private float radius = 5;
  
  Projectile(PVector loc, PVector vel, float radius){
    this.loc = loc.copy();
    this.vel = vel.copy();
    this.radius = radius;
  }
  
  public void update(){
    loc.add(vel);
    lifeSpan -= 1;
  }
  
  
  public void display(){
    fill(0, 255, 0);
    noStroke();
    ellipse(loc.x, loc.y, radius, radius);
  }
  
  
  public boolean isExpired(){
    return lifeSpan <= 0;
  }
  
  public float getX(){
    return loc.x;
  }
  
  public float getY(){
    return loc.y;
  }
  
  public float getRadius(){
    return radius;
  }
  
  public float getDamage(){
    return damage;
  }
  
  
  // check projectile collisions
  public boolean checkCollision(AbstractEntity entity){
    float distance = dist(loc, entity.getLoc());
    return distance < (radius + (entity.hitBoxWidth));
  }
  
  
  
}
