// Image class can hold an array of images that are supposed to be played as animation
// eg: walking , attacking, etc

class Image {
  PImage[] images;
  int imgCount;
  int frame;
  int frameDelay = 3;
  int frameCounter = 0;
  
  // constructor : load images
  Image(String imagePrefix, int count){
    imgCount = count;
    images = new PImage[imgCount];
    
    for (int i = 0; i < imgCount; i++){
      String filename = imagePrefix + i + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  // another constructor with ability to set frameDelay
  Image(String imagePrefix, int count, int frameDelay){
    this.frameDelay = frameDelay;
    
    imgCount = count;
    images = new PImage[imgCount];
    
    for (int i = 0; i < imgCount; i++){
      String filename = imagePrefix + i + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  
  // display the current image in the sequence of images
  public void display(float xpos, float ypos) {
    frameCounter++;
    if (frameCounter >= frameDelay){
      frame = (frame+1) % imgCount;
      frameCounter = 0;
    }
    image(images[frame], xpos, ypos, images[frame].width, images[frame].height);
  }
  
  // ##########################  GETTERS , SETTERS , Basic functions ########################## //
  // is animation finished 
  public boolean isFinished(){
    return (frame >= images.length-1) && (frameCounter == frameDelay - 1); 
  }
  
  public int getWidth() {
    return images[0].width;
  }
  
  public int getHeight() {
    return images[0].height;
  }
  
  public void setFrameDelay(int frameDelay) {
    this.frameDelay = frameDelay;
  }
  
  public void resetFrame(){
    frame = 0;
    frameCounter = 0;
  }
  
}
