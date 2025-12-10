SpaceShip player;

boolean leftHeld = false;
boolean rightHeld = false;
boolean upHeld = false;
boolean downHeld = false;

void setup() {
  size(600, 600);
  player = new SpaceShip(300, 500, 0, 0);
}

void draw() {
  background(0);

  player.update();
  player.display();
}

void keyPressed() {
  if (keyCode == LEFT)  leftHeld = true;
  if (keyCode == RIGHT) rightHeld = true;
  if (keyCode == UP)    upHeld = true;
  if (keyCode == DOWN)  downHeld = true;

  updateMovement();
}

void keyReleased() {
  if (keyCode == LEFT) {
    leftHeld = false;
  }
  if (keyCode == RIGHT) {
    rightHeld = false;
  }
  if (keyCode == UP) {
    upHeld = false;
  }
  if (keyCode == DOWN) {
    downHeld = false;
  }

  updateMovement();
}

void updateMovement() {
  if (leftHeld && !rightHeld) {
    player.xspeed = -5;
  } else if (rightHeld && !leftHeld) {
    player.xspeed = 5;
  } else {
    player.xspeed = 0;
  }

  if (upHeld && !downHeld) {
    player.yspeed = -5;
  } else if (downHeld && !upHeld) {
    player.yspeed = 5;
  } else {
    player.yspeed = 0;
  }
}

