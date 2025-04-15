// holds the images for 3x3 game grid and their positions
class Map {
  private PImage img;
  private PVector position;
  
  Map(PImage img, float x, float y) {
    this.img = img;
    this.position = new PVector(x, y);
  }

  public void draw() {
    image(img, position.x, position.y);
  }
}
