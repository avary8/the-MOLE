class GamePlay{
  private String playerString = "mole-";
  private String antString = "ant-";
  
  private Map[][] gameBGs = new Map[3][3];
  private Camera camera;
  private Player player;
  private ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  private Boss boss;
  private Image[] enemyImgs;
  private ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  
  private int maxEnemyCount = 20;
  
  UpgradeManager upgradeManager;
  private boolean upgradeScreen = false;
  
  private int gameStatus = -1; // -1 = playing , 0 = lost , 1 = won
  

  private int difficulty = 0;
  private int level = 1;
  private int kills = 0;
  private float multiplier = 1;
  
  private float effectsVol = 1.0;
  
  
  GamePlay(int difficulty){
    this.difficulty = difficulty;
    if (difficulty == 1){
      println("multiplier = 1.5");
      multiplier = 1.5;
    }

    loadGameBackgrounds();
    loadClasses();
    
    upgradeManager = new UpgradeManager(player);
  }


  public void updateDraw(){
    background(0);
    if (upgradeScreen){ // if on upgradeScreen, show it and then return (so game is effectively paused)
      pushMatrix();
      imageMode(CENTER);
      drawBackgrounds();
      popMatrix();
      drawOverlay();

      upgradeManager.display();
      return;
    }
    
    camera.update(player.getX(), player.getY());
    camera.applyTransform();
    drawBackgrounds();
  
    pushMatrix();
    imageMode(CENTER);
    player.update();
    player.display();
    
    
    for (Enemy e : enemies){ //<>//
      e.update(player.getX(), player.getY(), enemyImgs); // display called from within update //<>//
    }
    
    if (level == 10){
      boss.update(player.getX(), player.getY());
      checkBossCollisions();
    }
    popMatrix();
    
    checkCollisions();
    if (player.isCheckingShields()){
      player.checkShield(kills);
    }
    
    drawOverlay();
  }
  
  
  
  // Player controls functions
  
  public void keyPressed(char key){
    player.keyPressed(key);
  }
  
  public void keyReleased(char key){
    player.keyReleased(key);
  }
  
  public void mousePressed(){
    player.mousePressed();
  }
  
  // ##########################  GETTERS , SETTERS , Basic functions ########################## //
  public int getGameStatus(){
    return gameStatus;
  }
  
  public int getDifficulty(){
    return difficulty;
  }
  
  public int getKills(){
    return kills;
  }
  
  public int getLevel(){
    return level;
  }
  
  public void setEffectsVol(float effectsVol){
    this.effectsVol = effectsVol/100.0;
  }
  
  // After player confirms upgrade, this gets called
  public void setUpgradeScreenOff(){
    upgradeManager.upgrade();
    upgradeScreen = false; 
    player.startImmunity();// give player some immunity coming out of upgrade screen
    if (level == 10){
      music.stop();
      music = bossMusic;
      music.loop();
    }
  }
  
  // hides buttons .. used if in-game settings are pulled up during upgrade selection
  public void hideUpgradeScreen(){
    upgradeManager.hideUpgrades();
    upgradeScreen = false;
  }
  
  public void setSelected(int selected){
    upgradeManager.setSelected(selected);
  }
  
  public int getSelected(){
    return upgradeManager.getSelected();
  }
  
  // ##########################  Game Core Mechanic Functions ########################## //

  // draw the backgrounds according to current position
  private void drawBackgrounds() {
    pushMatrix();
    imageMode(CORNER);
    int gridX = int(camera.getX() / 1920);
    int gridY = int(camera.getY() / 1080);
    
    for (int i = max(0, gridX - 1); i <= min(2, gridX + 1); i++) {
      for (int j = max(0, gridY - 1); j <= min(2, gridY + 1); j++) {
        gameBGs[i][j].draw();
      }
    }
    popMatrix();
  }
  
  // draws in-game text overlays
  private void drawOverlay(){
    pushMatrix();
    resetMatrix();
    fill(255);
    textSize(32);
    
    // left corner
    text("[ESC]", 50, 50);
    text("HEALTH: " + int(player.health), 50, 80);
    
    // right corner
    text("Kills: " + kills, width - 150, 50);
    text("Level: " + level, width - 150, 80);

    popMatrix();
  }
  
  
  // check which level the player is on
  private void checkLevel(){
    if (level < 10 && kills >= (int)(5 * pow(1.5, (level))) / multiplier){
      level += 1;
      maxEnemyCount = max(maxEnemyCount + 5, 100); 
      upgradeScreen = true;
    }
  }

  // checks collisions of enemies and player
  private void checkCollisions(){
    //Image[] enemyImg = enemies.get(0).getImg();
    
    // iterate through all enemies
    for (int i = enemies.size() - 1; i >= 0; i--) {
      // set volume for each sfx
      gameSounds[1].amp(effectsVol);
      gameSounds[2].amp(effectsVol);  
      gameSounds[0].amp(effectsVol);
    
      Enemy enemy = enemies.get(i);
      
      // if enemy is within a range of the entity with bigger melee range plus a little buffer
      // helps with memory a bit 
      if (enemy.isWithinRange(player.getX(), player.getY(), max(player.getMeleeRange(), enemy.getMeleeRange()) * 1.2)){
      
        // CHECK if PLAYER hits ENEMY
        if (player.getIsAttacking()){
          if (!player.hasHit && player.attackIntersects(enemy)){ // if player hits their first enemy during this for loop check
            gameSounds[1].stop();
            gameSounds[1].play(); // hit sound
  
            enemy.takeDamage(player.attackDamage);
            player.hasHit = true; // this variable is set so that Player cant just swing through a group of 10 
            
          } else if (!player.hasHit && !player.attackIntersects(enemy)) { // if player misses
            gameSounds[2].stop();
            gameSounds[2].play(); // miss sound
          }
        }
        
        // CHECK if ENEMY hits PLAYER
        // some iframes to player after being hit. check if player is immune or not. check other stuff too . basically same as above 
        if (!player.isImmune() && enemy.getIsAttacking() && !enemy.hasHit  && enemy.attackIntersects(player)) { 
          gameSounds[0].stop();
          gameSounds[0].play(); // player hurt sound
          
          player.takeDamage(enemy.attackDamage);
          player.startImmunity(); // function to begin timing the immunity
          enemy.hasHit = true;
        }
        
        
        // CHECK HEALTH of ENEMY
        if (enemy.health <= 0){ 
          enemies.remove(i);
          kills += 1;
          checkLevel();
        }
        
        // CHECK HEALTH of PLAYER
        if (player.health <= 0){
          println(" PLAYER HAS " + player.health + " LIVES ");
          gameStatus = 0; // game LOST
          return;
        }
        
      } else if (player.getIsAttacking() && !player.hasHit && !player.attackIntersects(enemy)){
        gameSounds[2].stop();
        gameSounds[2].play(); // miss sound
      }
      spawnEnemies(); // spawn enemies to replace ones that have died
    }
  }
  
  // similar to above, but for the Boss
  private void checkBossCollisions(){
    // set volume for each sfx
    gameSounds[0].amp(effectsVol);
    gameSounds[1].amp(effectsVol);
    gameSounds[2].amp(effectsVol);  
    gameSounds[3].amp(effectsVol);
      
      
    // Check if any projectiles hit Player
       
    for (int i = 0; i < boss.getProjectiles().size(); i++){
      Projectile proj = boss.getProjectiles().get(i);
      if (boss.isWithinRange(proj.getX(), proj.getY(), player.getX(), player.getY(), proj.getRadius() * 2)){
        if (proj.checkCollision(player)){
          
          boss.getProjectiles().remove(i);
          
          gameSounds[3].stop();
          gameSounds[3].play(); // projectile hit sound
          player.takeDamage(proj.getDamage());
          player.startImmunity();
          
          // CHECK HEALTH of PLAYER
          if (player.health <= 0){
            println(" PLAYER HAS " + player.health + " LIVES ");
            gameStatus = 0; // game LOST
            return;
          }
        }
       }
     }
     

      
      
      
      // if BOSS is within a range of the entity with bigger melee range plus a little buffer
      // helps with memory a bit 
      if (boss.isWithinRange(player.getX(), player.getY(), max(player.getMeleeRange(), boss.getMeleeRange()) * 1.2)){
      
        // CHECK if PLAYER hits BOSS
        if (player.getIsAttacking()){
          if (!player.hasHit && player.attackIntersects(boss)){ 
            gameSounds[1].stop();
            gameSounds[1].play(); // hit sound
  
            boss.takeDamage(player.attackDamage);
            player.hasHit = true; // this variable is set so that Player cant just swing through a group of 10 
          } else if (!player.hasHit && !player.attackIntersects(boss)) { // if player misses
            gameSounds[2].stop();
            gameSounds[2].play(); // miss sound
          }
        }
        
        // CHECK HEALTH of BOSS
        if (boss.health <= 0){ 
          gameStatus = 1; // game WON
          return;
        }
      
              
        // CHECK if BOSS hits PLAYER
        // some iframes to player after being hit. check if player is immune or not. check other stuff too . basically same as above 
        if (!player.isImmune() && boss.getIsAttacking() && !boss.hasHit  && boss.attackIntersects(player)) { 
          gameSounds[0].stop();
          gameSounds[0].play(); // player hurt sound
          
          player.takeDamage(boss.attackDamage);
          player.startImmunity(); // function to begin timing the immunity
          boss.hasHit = true;
        }
        
        
        // CHECK HEALTH of PLAYER
        if (player.health <= 0){
          println(" PLAYER HAS " + player.health + " LIVES ");
          gameStatus = 0; // game LOST
          return;
        }
        
      } else if (player.getIsAttacking() && !player.hasHit && !player.attackIntersects(boss)){
        gameSounds[2].stop();
        gameSounds[2].play(); // miss sound
      }
 } 
 
  
  
    private void spawnEnemies(){
    /*  - spawn enemies a little outside the game borders. randomize distance from border and which side (top, bottom, left, right)
        - there is a max number of enemies able to be present at a time
    */
    
    for (int i = enemies.size(); i < maxEnemyCount; i++){
      int spawnBuffer = int(random(200));
      int spawnSide = int(random(4));
      float spawnX, spawnY;
    
      switch (spawnSide){
        case 0: // top
          spawnX = random(width * 3);
          spawnY = -spawnBuffer;
          break;
       case 1:  // right
         spawnX = (width * 3) + spawnBuffer;
         spawnY = random(height * 3);
         break;
       case 2:  // bottom
         spawnX = random(width * 3);
         spawnY = (3 * height) + spawnBuffer;
         break;
       default:  // left
         spawnX = (width * 3) - spawnBuffer;
         spawnY = random(height * 3);
         break;
      }
      // Enemy(float x, float y, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach, float imgWidth, float imgHeight)
      enemies.add(new Enemy(spawnX, spawnY, 1, 1, 100, 0.7, 10, enemyImgs[0].getWidth(), enemyImgs[0].getHeight()));
    }
  }
  
  
  
  // ########################## INITIALIZE ########################## //
  // Load game backgrounds into the Map class. background is 3x3 grid of 1920x1080 images
  private void loadGameBackgrounds(){
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          PImage img = loadImage("map-" + i + j + ".png");
            gameBGs[j][i] = new Map(img, j * 1920, i * 1080);
        }
    }
  }
  
  
  // LOAD ENTITY IMAGE CLASS ARRAYS (load animations for Entities)
  void loadClasses(){
    
    int[] playerNums = { 6, 4, 6, 4, 6, 5, 5, 5, 1, 1, 1, 1 };
    Image[] playerImgArr = loadEntityImages(playerString, playerNums, 3);
    
    int[] enemyNums = { 2, 2, 2, 2, 1, 1, 1, 1 };
    enemyImgs = loadEntityImages(antString, enemyNums, 3);
    
    
    println("player width: "+ playerImgArr[0].getWidth());
    println("player height: "+ playerImgArr[0].getHeight());
    println("enemy width: "+ enemyImgs[0].getWidth());
    println("enemy height: "+ enemyImgs[0].getHeight());
    
    // set difficulty based health
    if (difficulty == 0){
      // Player(Image[] img, float speed, float health, float attackCooldown, float attackDamage, float hitBoxAdj, float attackReach)
      player = new Player(playerImgArr, 2, 5, 750, 1, 0.5, 50);
    } else {
      player = new Player(playerImgArr, 2, 2, 750, 1, 0.5, 50);
      
    }

    spawnEnemies();
    
    
    Image[] bossImgArray = new Image[1];
    bossImgArray[0] = new Image("boss-", 1, 3);
    // Boss(Image[] img, float x, float y, float speed, float health, float attackCooldown, float hitBoxAdj, float attackReach)
    boss = new Boss(bossImgArray, 0, 0, 1, 50, 200, 0.5, 20);
    
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
  
 //<>//

}
