PImage bg = new PImage();
PImage[][] backgrounds = new PImage[3][3];
int gridX = 1;
int gridY = 1;

String playerString = "mole-";
String yellowBulletImg = "bullet_yellow.jpg";
String antString = "ant-";
//String bgString = "dirt-bg.png";
String bgString = "map-11.png";
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

Character player;
Enemy enemy1;


void setup(){
  
  size(1920,1080);
  
  loadBackgrounds();
  
  bg = loadImage(bgString);
  
  background(bg);
  initialize();
}


void draw(){
  //drawBackground();
  
  
  
  //background(bg);
  
  player.update();
  
  
  checkRoomTransition();
  image(backgrounds[gridX][gridY], 0, 0);
  
  player.display();
  
  enemy1.update(player.loc.x, player.loc.y);
  enemy1.display();
  
  text(dist(player.loc.x, player.loc.y, player.lookX, player.lookY), 300, 300);
  
  for (Projectile p: projectiles){
    p.update();
    p.display();
  }
  text("num bullets: " + projectiles.size(), 800, 800);
  
  
}


void checkRoomTransition() {
    if (player.loc.x > 1920) { 
        gridX++; 
        player.loc.x = 0;  // Wrap to left side of new background
        shiftEnemies(-1920, 0);
    } 
    if (player.loc.x < 0) { 
        gridX--; 
        player.loc.x = 1920; // Wrap to right side of new background
        shiftEnemies(1920, 0);
    } 
    if (player.loc.y > 1080) { 
        gridY++; 
        player.loc.y = 0; // Wrap to top of new background
        shiftEnemies(0, -1080);
    } 
    if (player.loc.y < 0) { 
        gridY--; 
        player.loc.y = 1080; // Wrap to bottom of new background
        shiftEnemies(0, 1080);
    } 
}

void shiftEnemies(int dx, int dy) {
  enemy1.loc.x += dx;
  enemy1.loc.y += dy;
  
    //for (Enemy e : enemies) {
    //    e.x += dx;
    //    e.y += dy;
    //}
}


void loadBackgrounds() {
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            backgrounds[i][j] = loadImage("map-" + i + j + ".png");
        }
    }
}





void mouseMoved(){
  player.mouseMoved();
}


void keyPressed(){
  player.keyPressed(key);
}

void keyReleased(){
  player.keyReleased(key);
}

void mousePressed(){
  player.mousePressed();
  
  PVector mouse = new PVector(mouseX, mouseY);
  PVector dir = PVector.sub(mouse, player.loc);
  dir.normalize();
  dir.mult(3);
  Projectile p = new Projectile(player.loc, dir);
  
  projectiles.add(p);
}


void mouseReleased(){
  player.mouseReleased();
  
}

void initialize(){
  Image[] playerImgArr = new Image[12];
  playerImgArr[0] = new Image(playerString +"0-", 6);
  playerImgArr[1] = new Image(playerString +"1-", 4);
  playerImgArr[2] = new Image(playerString +"2-", 6);
  playerImgArr[3] = new Image(playerString +"3-", 4);
  // attack animations
  playerImgArr[4] = new Image(playerString +"4-", 6);
  playerImgArr[5] = new Image(playerString +"5-", 5);
  playerImgArr[6] = new Image(playerString +"6-", 5);
  playerImgArr[7] = new Image(playerString +"7-", 5);
  
  playerImgArr[8] = new Image(playerString +"0-", 1);
  playerImgArr[9] = new Image(playerString +"1-", 1);
  playerImgArr[10] = new Image(playerString +"2-", 1);
  playerImgArr[11] = new Image(playerString +"3-", 1);
  
  Image[] enemyImgArr = new Image[1];
  enemyImgArr[0] = new Image(antString, 2);
  
  player = new Character(playerImgArr, yellowBulletImg, 5);
  enemy1 = new Enemy(enemyImgArr, yellowBulletImg, 0, 0, 1);
}



void drawBackground(){
  for (int i = 0; i < ceil(width/bg.width); i++){
    for (int j = 0; j < ceil(height/bg.height); j++){
      image(bg, (i * bg.width) + (bg.width/2), (j * bg.height) + (bg.height/2));
    }
  }

}
