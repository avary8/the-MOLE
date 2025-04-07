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
    Image[] playerImgArr = new Image[12];
    // walking 
    playerImgArr[0] = new Image(playerString +"0-", 6);
    playerImgArr[1] = new Image(playerString +"1-", 4);
    playerImgArr[2] = new Image(playerString +"2-", 6);
    playerImgArr[3] = new Image(playerString +"3-", 4);
    // attack animations
    playerImgArr[4] = new Image(playerString +"4-", 6);
    playerImgArr[5] = new Image(playerString +"5-", 5);
    playerImgArr[6] = new Image(playerString +"6-", 5);
    playerImgArr[7] = new Image(playerString +"7-", 5);
    
    // still
    playerImgArr[8] = new Image(playerString +"0-", 1);
    playerImgArr[9] = new Image(playerString +"1-", 1);
    playerImgArr[10] = new Image(playerString +"2-", 1);
    playerImgArr[11] = new Image(playerString +"3-", 1);
    
    Image[] enemyImgArr = new Image[2];
    // attack
    enemyImgArr[0] = new Image(antString, 2, 10);
    // still
    enemyImgArr[1] = new Image(antString, 1);

    
    if (difficulty == 0){
      player = new Character(playerImgArr, 5, 5, 750, 0.3);
    } else {
      player = new Character(playerImgArr, 5, 2, 750, 0.3);
      
    }
    enemy1 = new Enemy(enemyImgArr, 1, 1, 300);
    enemies.add(enemy1);
    
    camera = new Camera(width/2, height/2);
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
