class Map {
  PImage img;
  PVector position;
  
  Map(PImage img, float x, float y) {
    this.img = img;
    this.position = new PVector(x, y);
  }

  void draw() {
    image(img, position.x, position.y);
  }
}
