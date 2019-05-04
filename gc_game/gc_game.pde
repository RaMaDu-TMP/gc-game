import processing.sound.*; //<>//

private static final int MENU  = 0;
private static final int GAME  = 1;
private static final int PAUSE = 2;
private static final int LOSE  = 3;
private static final int WIN   = 4;

int state;

//=========SOUND VARIABLES=========
SoundFile file;
  
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

void setup() {
  
  size(800, 600);
  noStroke();
  smooth();
  ellipseMode(CENTER);
  
  /*
  // TODO
  file = new SoundFile(this, "menu.wav"); //<>//
  file.play();
  */
  
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
  // TODO
  background(0);
  textSize(100);
  fill(255, 255, 255);
  text("GAME", width / 2, height / 2);
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
