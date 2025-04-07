String bg_string = "bg.png"; // bg is 640 by 360
String bg_uncovered_string = "bg_uncovered.png";

// dirt is ugly
String dirt_string = "dirt_larger_clump_3.png";

String player_attack_f = "mole-forward-attack-";
String player_walk_r = "mole-face-right-walk-";

String player_forward = "mole-forward-attack-";

Animation player_f, attack_f, walk_r;

PVector playerPos = new PVector();

PImage bg, bg_uncov, dirt;

PImage[] dirt_clump = new PImage[6];

void setup(){
  fullScreen();
  
  frameRate(24);
  player_f = new Animation(player_forward, 1);
  attack_f = new Animation(player_attack_f, 5);
  walk_r = new Animation(player_walk_r, 4);
  
  playerPos.x = width/2;
  playerPos.y = height/2;
  
  bg = loadImage(bg_string);
  bg_uncov = loadImage(bg_uncovered_string);
  dirt = loadImage(dirt_string);
  
  for (int i = 1; i < 7; i++){
    dirt_clump[i-1] = loadImage("dirt_multi_clump" + i + ".png");
  }
  
  println("scr width: " + width);
  println("scr height: " + height);
  println("width: " + bg.width);
  println("height: " + bg.height);
  
  println ( ceil(width/bg.width));
  
}


void draw(){
  
  if (!keyPressed){
    //background(90);
    drawBackground();
    player_f.display(playerPos.x , playerPos.y);
  }
  
  if (mousePressed){
    drawBackground();
    //background(90);
    attack_f.display(playerPos.x , playerPos.y);
  }

}


void keyPressed(){
  drawBackground();
  //background(90);
  if (key == 'd'){
    playerPos.x += 1;
    walk_r.display(playerPos.x, playerPos.y);
  } else if (key == 'a'){
    // would be easier to just have the other left images i think
    pushMatrix();
    float x = playerPos.x - 1 ;
    scale(-1, 1);
    translate(-width - walk_r.getWidth(), 0);
    walk_r.display(x, height/2);
    popMatrix();
  }
  
  
}


void drawBackground(){
  for (int i = 0; i < ceil(width/bg.width); i++){
    for (int j = 0; j < ceil(height/bg.height); j++){
      image(bg, i * bg.width, j * bg.height);
    }
  }
  int n = 0;
  
  //for (int i = 0; i < ceil(width/dirt.width); i++){
  //  for (int j = 0; j < ceil(height/dirt.height); j++){
  //    //image(dirt, i * dirt.width, j * dirt.height);
  //    image(dirt_clump[n%6], i * dirt_clump[0].width, j * dirt_clump[0].height);
  //    n+=1;
  //  }
  //}
  

}
