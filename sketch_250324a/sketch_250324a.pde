String playerImg = "player.png";
String yellowBulletImg = "bullet_yellow.jpg";
String enemyImg = "enemy.png";

ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

Character player;
Enemy enemy1;


void setup(){
  size(800, 800);
  fullScreen();
 
 initialize();
  
  
}


void draw(){
  background(90);
  player.update();
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
  PVector mouse = new PVector(mouseX, mouseY);
  PVector dir = PVector.sub(mouse, player.loc);
  dir.normalize();
  dir.mult(3);
  Projectile p = new Projectile(player.loc, dir);
  
  projectiles.add(p);
}


void initialize(){
 player = new Character(playerImg, yellowBulletImg, 5);
 enemy1 = new Enemy(enemyImg, yellowBulletImg, 0, 0, 1);
  
}
