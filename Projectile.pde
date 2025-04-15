// Projectile class . holds a projeciles, stats like location, speed, damage, etc
class Projectile extends PVector {
  private PVector loc = new PVector();
  private PVector speed = new PVector();
  private int lifeSpan = 300;
  private float damage = 1;
  private float radius = 5;
  
  Projectile(PVector loc, PVector speed, float radius){
    this.loc = loc.copy();
    this.speed = speed.copy();
    this.radius = radius;
  }
  
  public void update(){
    loc.add(speed);
    lifeSpan -= 1;
  }
  
  // display a green circle as projectile
  public void display(){
    fill(0, 255, 0);
    noStroke();
    ellipse(loc.x, loc.y, radius, radius);
  }
  
  // ##########################  GETTERS , SETTERS , Basic functions ########################## //
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
  
  
  // check projectile collisions with passed in arg entity
  public boolean checkCollision(AbstractEntity entity){
    float distance = dist(loc, entity.getLoc());
    return distance < (radius + (entity.hitBoxWidth));
  }
  
  
  
}
