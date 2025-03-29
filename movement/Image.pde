class Image {
  PImage[] images;
  int imgCount;
  int frame;
  
  Image(String imagePrefix, int count){
    imgCount = count;
    images = new PImage[imgCount];
    
    for (int i = 0; i < imgCount; i++){
      String filename = imagePrefix + i + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  void display(float xpos, float ypos) {
    frame = (frame+1) % imgCount;
    image(images[frame], xpos, ypos, images[frame].width, images[frame].height);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
