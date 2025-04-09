String playerString = "mole-";
String antString = "ant-";

class GamePlay{
  Map[][] gameBGs = new Map[3][3];
  Camera camera;
  Character player;
  Enemy enemy1;
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  
  //UpgradeManager upgradeManager;
  boolean upgradeScreen = false;
  
  int difficulty = 0;
  int level = 0;
  int kills = 0;
  
  
  GamePlay(int difficulty){
    this.difficulty = difficulty;
    
    loadGameBackgrounds();
    loadClasses();
  }
  


  void updateDraw(){
    background(0);
    camera.update(player.loc.x, player.loc.y);
    camera.applyTransform();
    drawBackgrounds();
  
    pushMatrix();
    imageMode(CENTER);
    player.update();
    player.display();
    
    enemy1.update(player.loc.x, player.loc.y);
    enemy1.display();
    popMatrix();
    
    text(dist(player.loc.x, player.loc.y, player.look.x, player.look.y), 300, 300);
    
    for (Projectile p: projectiles){
      p.update();
      p.display();
    }
    
    checkCollisions();  
    
    text("num bullets: " + projectiles.size(), 800, 800);
    
    
    text("player HEALTH: " + player.health, 900, 900);
    
  }
  
  
  
  void keyPressed(char key){
    player.keyPressed(key);
  }
  
  void keyReleased(char key){
    player.keyReleased(key);
  }
  
  void mousePressed(){
    player.mousePressed();
  }
  
  
  void drawBackgrounds() {
    pushMatrix();
    imageMode(CORNER);
    int gridX = int(camera.loc.x / 1920);
    int gridY = int(camera.loc.y / 1080);
    
    for (int i = max(0, gridX - 1); i <= min(2, gridX + 1); i++) {
      for (int j = max(0, gridY - 1); j <= min(2, gridY + 1); j++) {
        gameBGs[i][j].draw();
      }
    }
    popMatrix();
  }
  
  
  void checkCollisions(){
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      
      //if (player.isAttacking && player.hitbox.intersects(enemy.hitbox())) {
      //  enemy.takeDamage(player.attackDamage);
      //}
      
      //if (enemy.isAttacking && enemy.hitbox().intersects(player.hitbox())) {
      //  player.takeDamage(enemy.attackDamage);
      //}
      
      if (enemy.health <= 0){
        enemies.remove(i);
      }
      
    }
    
  }
  
  
  
  // ########################## INITIALIZE ########################## //
  
  void loadGameBackgrounds(){
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          PImage img = loadImage("map-" + i + j + ".png");
            gameBGs[j][i] = new Map(img, j * 1920, i * 1080);
        }
    }
  }
  
  void loadClasses(){
    // LOAD ENTITY IMAGE CLASS ARRAYS (load animations for Entities)
    int[] playerNums = { 6, 4, 6, 4, 6, 5, 5, 5, 1, 1, 1, 1 };
    Image[] playerImgArr = loadEntityImages(playerString, playerNums, 3);
    
    int[] enemyNums = { 2, 2, 2, 2, 1, 1, 1, 1 };
    Image[] enemyImgArr = loadEntityImages(antString, enemyNums, 3);
    
    // set difficulty based health
    if (difficulty == 0){
      player = new Character(playerImgArr, 5, 5, 750, 0.3, 0.8);
    } else {
      player = new Character(playerImgArr, 5, 2, 750, 0.3, 0.8);
      
    }
    //  Enemy(Image[] img, float speed, float health, float attackCooldown, float hitBoxAdj)
    enemy1 = new Enemy(enemyImgArr, 1, 1, 100, 0.5);
    enemies.add(enemy1);
    
    camera = new Camera(width/2, height/2);
    
  }
  
  
  // All entities (player / enemy sprites) have similar file naming based off location and how many images are in the single animation 
  // numPics is the number of pictures in the animation. 
  // So the Image class is a class for a single animation (walking , attacking , etc) and needs a predefined number of images that make up this animation
  // the array holds all animations pertaining to a single Entity 
  Image[] loadEntityImages(String filePrefix, int[] numPics, int frameDelay){
    Image[] imageArray = new Image[numPics.length];
    
    for (int i = 0; i < imageArray.length; i++){
      //int imageIndex = 0;
      if (i >= imageArray.length - 4){
        //imageIndex = i - (imageArray.length - 4);
        imageArray[i] = new Image(filePrefix + (i - (imageArray.length - 4)) + "-", numPics[i], frameDelay); 

      } else {
        //imageIndex = i;
        imageArray[i] = new Image(filePrefix + i + "-", numPics[i], frameDelay);
      }
      
      //imageArray[i] = new Image(filePrefix + imageIndex + "-", numPics[i], frameDelay); 
      
    }
    
    
    return imageArray;
    
    
    /* BELOW is what it would look like all written out 
         and helps to see what I'm talking about
    
          (I'll use Player as example)
      the Player has multiple actions: walking, attacking, standing still
      
      additionally, I have drawn these actions for each direction (up, down, right left)
      
      for each action, there is a number of pictures that make up the animation
      
     
          example taken from below   //playerImgArr[0] = new Image(playerString +"0-", 6);
            In order to WALK UP, the game must load the WALK UP animation which is 6 images into the Image CLASS that I made
            
     
     Files are named like "mole-x-y.png" where x is the action-direction and y is the picture index in the animation
     so the WALK UP animation will look like "mole-0-0.png" "mole-0-1.png" ... "mole-0-5.png" 
    */
    
    // Player Images
    //Image[] playerImgArr = new Image[12];
    
    //// walking 
    //playerImgArr[0] = new Image(playerString +"0-", 6);
    //playerImgArr[1] = new Image(playerString +"1-", 4);
    //playerImgArr[2] = new Image(playerString +"2-", 6);
    //playerImgArr[3] = new Image(playerString +"3-", 4);
    
    //// attack animations
    //playerImgArr[4] = new Image(playerString +"4-", 6);
    //playerImgArr[5] = new Image(playerString +"5-", 5);
    //playerImgArr[6] = new Image(playerString +"6-", 5);
    //playerImgArr[7] = new Image(playerString +"7-", 5);
    
    //// still
    //playerImgArr[8] = new Image(playerString +"0-", 1);
    //playerImgArr[9] = new Image(playerString +"1-", 1);
    //playerImgArr[10] = new Image(playerString +"2-", 1);
    //playerImgArr[11] = new Image(playerString +"3-", 1);
    
    
    // Ant Enemy Images
    //Image[] enemyImgArr = new Image[2];
    //// attack
    //enemyImgArr[0] = new Image(antString, 2, 10);
    //// still
    //enemyImgArr[1] = new Image(antString, 1);
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
