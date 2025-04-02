class Camera {
  PVector loc;
  
  Camera(float x, float y){
    loc = new PVector(x, y);
  }
  
  void update(float x, float y){
    loc.set(x - width / 2, y - height / 2);
  }
  
  void applyTransform() {
    translate(-loc.x, -loc.y);
  }
  
}
