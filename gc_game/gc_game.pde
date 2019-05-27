import ddf.minim.*;
private static final int MENU  = 0;
private static final int GAME  = 1;
private static final int PAUSE = 2;
private static final int LOSE  = 3;
private static final int WIN   = 4;

int state;

//=========SOUND VARIABLES=========
Minim menuMusic;
AudioPlayer menuPlayer;

Minim gameMusic;
AudioPlayer gamePlayer;

//=========MENU VARIABLES==========
boolean mouseHoverMenuStart = false;
boolean mouseHoverMenuExit  = false;
boolean mouseHoverPauseMenu = false;

float startButtonX;
float startButtonY;
float startButtonW;
float startButtonH;

float exitButtonX;
float exitButtonY;
float exitButtonW;
float exitButtonH;

float menuButtonX;
float menuButtonY;
float menuButtonW;
float menuButtonH;

float x = 150;
float y = 400;
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
int m = 10;
int time = 15000;

float xBrain = 580;
float yBrain = 580;

long timeGameLoop = millis();

boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;

int numBalls = 15;
Ball[] balls = new Ball[numBalls];

int life = 5;

void setup() {
  
  size(1280, 720);//Checar resolucao
  noStroke();
  smooth();
  ellipseMode(RADIUS);
  
  img1 = loadImage("bolomon2.png");
  img2 = loadImage("Bolsonaro_Loses.jpg");
  img3 = loadImage("brain.png");
  img4 = loadImage("Space_Image.png");
  img5 = loadImage("Bolsonaro_Wins.jpg");
  
  
  x = 590;
  y = 50;
  
  // TODO
  menuMusic = new Minim(this);
  menuPlayer = menuMusic.loadFile("menu.mp3");
  menuPlayer.play();
  
  gameMusic = new Minim(this);
  gamePlayer = gameMusic.loadFile("game.mp3");
  
  // Start button dimension and position
  startButtonW = width / 2;
  startButtonH = 100;
  startButtonX = (width / 2) - (startButtonW / 2);
  startButtonY = (height / 2) + 100;
 
  // Exit button dimension and position
  exitButtonW = width / 2;
  exitButtonH = 60;
  exitButtonX = (width / 2) - (exitButtonW / 2);
  exitButtonY = (height / 2) + 100 + 120;
  
  // Menu button dimension and position
  menuButtonW = width / 8;
  menuButtonH = 40;
  menuButtonX = (width / 2) - (menuButtonW / 2);
  menuButtonY = (height / 2) + 227;
  
  state = MENU;
  
  //Balls
   for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(200, 500), random(20, 30), 0, random(5, 15), i, color(random(0, 256), random(0, 256), random(0, 256)));
  }
}

void draw() {
  updateMouseVariables();
  
  switch (state) {
    case MENU:
      menu();
      break;
    
    case GAME:
      game();
      break;
      
    case PAUSE:
      pause();
      break;
      
    case LOSE:
      lose();
      break;
      
    case WIN:
      win();
      break;
  }
}

void menu() {
  // General menu background
  background(155);
  
  // General text align
  textAlign(CENTER, CENTER);
  
  //============================Menu text=============================
  fill(0, 53, 89); // Menu title text color
  textSize(100); // Menu title text size
  text("MENU", width / 2, 100); // Menu title text and position
  
  //===========================Start button===========================
  if (mouseHoverMenuStart) { // Button background
     fill(179, 176, 0); 
  } else {
     fill(255, 251, 0);
  }
  
  rect(startButtonX, startButtonY, startButtonW, startButtonH); // Draw button
  
  // Start button text
  fill(255, 255, 255); // Button text color
  textSize(50); // Button text size
  text("START", width / 2, (height / 2) + 145); // Button text and position
  
  //============================Exit button============================
  if (mouseHoverMenuExit) { // Button background
     fill(179, 0, 0); 
  } else {
     fill(255, 0, 0);
  }
  
  rect(exitButtonX, exitButtonY, exitButtonW, exitButtonH); // Draw button
  
  fill(255, 255, 255); // Button text color
  textSize(30); // Button text size
  text("EXIT", width / 2, (height / 2) + 245); // Button text and position
}

void game() {

  textSize(40);
  menuPlayer.close();
  gamePlayer.play();
  
  if (millis() - timeGameLoop <= 60) {
    return;
  }
  timeGameLoop = millis();
  
  //Main sprite movement
  if (right) {
    x = x + m;
  }
  
  if (left) {
    x = x - m;
  }
  
  if (up) {
    y = y - m;
  }
  
  if (down) {
    y = y + m;
  }
  
  background(img4);
  
  image(img3, xBrain, yBrain);
  
  x = constrain(x, 0, 1220);
  y = constrain(y, 0, 600);
  
  image(img1, x, y);
  
  for (Ball ball : balls){
    ball.move();
    ball.display();
  }
  
  float caracterX = x;
  float caracterY = y;
  
  for (int i = 0; i < numBalls; i++){
    Ball b1 = balls[i];
    if (b1.xpos > caracterX && b1.xpos < (caracterX + 52)){
      if (b1.ypos > caracterY && b1.ypos < (caracterY + 114)){
        x = 590;
        y = 50;
        life -= 1;
      }
    }
  }
  
  if ((xBrain + 80) > caracterX && xBrain < (caracterX + 52)){
    if((yBrain + 72) > caracterY && yBrain < (caracterY + 114)){
      background(img5);
      text("PARABENS \n VOCE VENCEU", width/2,height/1.5);
    }
  } 
  if (life == 0){
    background(img2);
    text("MORREU", width/2, height/2);
    if(millis() > time)
      life = 5;
  }
  text("VIDA:" + str(life), 70, 20);
}

void pause() {
  // General pause background
  background(0);
  
  // General text align
  textAlign(CENTER, CENTER);
  
  //===========================Pause text=============================
  fill(255, 255, 255);
  textSize(100);
  text("PAUSE", width / 2, height / 2);
  
  //============================Menu button============================
  if (mouseHoverPauseMenu) { // Button background
     fill(3, 64, 102); 
  } else {
     fill(9, 133, 179);
  }
  
  rect(menuButtonX, menuButtonY, menuButtonW, menuButtonH); // Draw button
  
  fill(255, 255, 255); // Button text color
  textSize(20); // Button text size
  text("MENU", width / 2, (height / 2) + 145 + 100); // Button text and position
}

void lose() {
  // TODO
}

void win() {
  // TODO
}

void updateMouseVariables() {
  mouseHoverMenuStart = (state == MENU)  && isMouseOverRect(startButtonX, startButtonY, startButtonW, startButtonH);
  mouseHoverMenuExit  = (state == MENU)  && isMouseOverRect(exitButtonX, exitButtonY, exitButtonW, exitButtonH);
  mouseHoverPauseMenu = (state == PAUSE) && isMouseOverRect(menuButtonX, menuButtonY, menuButtonW, menuButtonH);
}

boolean isMouseOverRect(float x, float y, float width, float height)  {
  return mouseX >= x && mouseX <= x + width 
      && mouseY >= y && mouseY <= y + height;
}

void mousePressed() {
  switch (state) {
    case MENU:
      mousePressedMenu();
      break;
    
    case GAME:
      mousePressedGame();
      break;
      
    case PAUSE:
      mousePressedPause();
      break;
      
    case LOSE:
      mousePressedLose();
      break;
      
    case WIN:
      mousePressedWin();
      break;
  }
}

void mousePressedMenu() {
  if (mouseHoverMenuStart) {
    state = GAME;
  }
  
  if (mouseHoverMenuExit) {
    exit();
  }
}

void mousePressedGame() {
  // TODO
}

void mousePressedPause() {
  if (mouseHoverPauseMenu) {
    state = MENU;
  }
}

void mousePressedLose() {
  // TODO
}

void mousePressedWin() {
  // TODO
}

void keyPressed() {
  switch (state) {
    case MENU:
      keyPressedMenu();
      break;
    
    case GAME:
      keyPressedGame();
      break;
      
    case PAUSE:
      keyPressedPause();
      break;
      
    case LOSE:
      keyPressedLose();
      break;
      
    case WIN:
      keyPressedWin();
      break;
  }
}

void keyPressedMenu() {
  // TODO
}

void keyPressedGame() {
  if (key == CODED) {
    if (keyCode == UP) {
     up = true;
    // sp  = true;
    }
    else if (keyCode == DOWN) {
      down = true;
    //  sp = false;
    }
    else if (keyCode == RIGHT) {
      right = true;
    }
    else if (keyCode == LEFT) {
      left = true;
    }
  }
  if (keyCode == ESC) {
    key = 0;
    state = PAUSE;
  }
}

void keyPressedPause() {
  if (keyCode == ESC) {
    key = 0;
    state = GAME;
  }
}

void keyPressedLose() {
  // TODO
}

void keyPressedWin() {
  // TODO
}

void keyReleased() {
  switch (state) {
    case MENU:
      //keyReleasedMenu();
      break;
    
    case GAME:
      keyReleasedGame();
      break;
      
    case PAUSE:
      //keyReleasedPause();
      break;
      
    case LOSE:
      //keyReleasedLose();
      break;
      
    case WIN:
      //keyReleasedWin();
      break;
  }
}

void keyReleasedGame() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      right = false;
    }
    else if (keyCode == LEFT) {
      left = false;
    }
    if (keyCode == UP) {
      up = false;
    }
    else if (keyCode == DOWN) {
      down = false;
    }
  }
}

class Ball {
  
  float xpos, ypos;
  float xspeed, yspeed;
  int id;
  float radius;
  color c;
  
  Ball(float xin, float yin, float xdirection, float ydirection, float irad, int idin, color ballcolor) {
    xpos = xin;
    ypos = yin;
    xspeed = xdirection;
    yspeed = ydirection;
    radius = irad;
    id = idin;
    c = ballcolor;

  } 
 
  void move() {
    xpos += xspeed;
    ypos += yspeed;
    
    if (xpos > width-radius){
      xspeed = -1 * abs(xspeed);
    }
    else if (xpos <= 5){
      xspeed = abs(xspeed);
    }
    
    if (ypos > height-radius){
      yspeed = -1 *abs(yspeed);
    }
    else if (ypos <= 5){
      yspeed = abs(yspeed);
    }
  }
  
  void display() {
    fill(c);
    ellipse(xpos, ypos, radius, radius);
  }
}
