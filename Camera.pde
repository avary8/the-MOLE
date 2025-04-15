// since game features a scrolling map (3x3 grid of images), this will keep track of coordinates wrt to the entire map
class Camera {
  private PVector loc;
  
  Camera(float x, float y){
    loc = new PVector(x, y);
  }
  
  // update location based on the player's location
  // center camera at player (player is kept at center of screen during gameplay except when by edges)
  public void update(float x, float y){
    loc.set(x - width / 2, y - height / 2);
  }
  
  // applies translation but does not allow camera to go out of game bounds (like if player goes to a corner. the camera will not keep player centered in this case)
  public void applyTransform() {
    float cameraX = constrain(loc.x, 0, 3 * width - width);
    float cameraY = constrain(loc.y, 0, 3 * height - height);
    translate(-cameraX, -cameraY);
  }
  
  // getters
  public float getX(){
    return loc.x;
  }
  
  public float getY(){
    return loc.y;
  }
  
}
