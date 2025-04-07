class Camera {
  PVector loc;
  
  Camera(float x, float y){
    loc = new PVector(x, y);
  }
  
  void update(float x, float y){
    loc.set(x - width / 2, y - height / 2);
  }
  
  void applyTransform() {
    float cameraX = constrain(loc.x, 0, 3 * width - width);
    float cameraY = constrain(loc.y, 0, 3 * height - height);
    translate(-cameraX, -cameraY);
  }
  
}
