class Projectile extends PVector {
  
  // viewingDir is just a bit broken atm
  
  // coming from 0, 0 right now
  // need to persist a bit since the player could move and see them again.
  // if doing light thing, maybe could add a "visible" bool and updates all but only prints one that are visible
  
  // also assign who the bullet belongs to . flag - enemy vs character bullets. OR 2 different arrays

  private PVector loc = new PVector();
  private PVector vel = new PVector();
  
  Projectile(PVector loc, PVector vel){
    this.loc = loc;
    this.vel = vel;
  }
  
  public void update(){
    add(vel);
  }
  
  
  public void display(){
    fill(0, 0, 255);
    ellipse(x, y, 20, 20);
  }
  
}
