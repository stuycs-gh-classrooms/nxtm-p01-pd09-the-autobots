SpaceShip player;
Enemy[][] grid;

boolean leftHeld = false;
boolean rightHeld = false;
boolean upHeld = false;
boolean downHeld = false;

void setup() {
  size(600, 600);
  player = new SpaceShip(300, 500, 0, 0);
  grid = new Enemy[3][5];
  makeBalls(grid);
}

void draw() {
  background(255);
  frameRate(30);


  if (frameCount % 30 == 0) {
    moveGrid(grid);
  }
   else {
    displayBalls(grid);
  }

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

void makeBalls(Enemy[][] g) {
  for (int r = 0; r < g.length; r ++) {
    for (int c = 0; c < g[r].length; c ++) {
      g[r][c] = new Enemy(new PVector(20 + (40 * c), 40 + (40 * r)), 40); //was thinking of using step again for in between the ballls but i realized theres no point and did it manually by making it the same as the size of hte ball
    }
  }
}


void moveGrid(Enemy[][] g) {
  for (int r = 0; r < g.length; r ++) {
    for (int c = 0; c < g[0].length; c ++) {
      if (g[r][c] != null) {
        g[r][c].move();
      }
    }
  }
  boolean hitside = false;
  for (int r = 0; r < g.length; r ++) {
    for (int c = 0; c < g[0].length; c ++) {
      if (g[r][c] != null) {
        if (g[r][c].center.x <= g[r][c].esize/2 || g[r][c].center.x >= width - g[r][c].esize/2) {
          hitside = true;
        }
      }
    }
  }
  if (hitside) {
    if (frameCount % 60 == 0) {
      for (int r = 0; r < g.length; r ++) {
        for (int c = 0; c < g[0].length; c ++) {
          if (g[r][c] != null) {
            g[r][c].center.y += g[r][c].esize;
            g[r][c].direction *= -1;
          }
        }
      }
    }
  }

  for (int r = 0; r < g.length; r ++) {
    for (int c = 0; c < g[0].length; c ++) {
      if (g[r][c] != null) {
        g[r][c].display();
      }
    }
  }
}


void displayBalls(Enemy[][] g) {
  for (int r = 0; r < g.length; r ++) {
    for (int c = 0; c < g[0].length; c ++) {
      if (g[r][c] != null) {
        g[r][c].display();
      }
    }
  }
}
