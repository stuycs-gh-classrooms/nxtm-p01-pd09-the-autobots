SpaceShip player;
Enemy[][] grid;
Bullet[] bullet;

boolean moveDown = false;
boolean leftHeld = false;
boolean rightHeld = false;
boolean upHeld = false;
boolean downHeld = false;
boolean gameOver = false;
boolean paused = false;

int lives = 3;
int wave = 1;

void setup() {
  size(600, 600);
  frameRate(30);
  player = new SpaceShip(300, 500, 0, 0);
  grid = new Enemy[3][5];
  bullet = new Bullet[20]; // max bullets
  makeBalls(grid);
}

void draw() {
  background(255);

  // Display lives
  textSize(20);
  fill(0);
  text("Lives: " + lives, 30, 20);

  //Display wave number
  textSize(20);
  fill(0);
  text("Wave: " + wave, 500, 20);

  // Display enemies and player
  displayBalls(grid);
  player.display();
  displayBullets(bullet);

  if (gameOver) {
    displayGameOver();
    return;
  }

  if (paused) {
    displayPause();
    return;
  }

  if (allEnemiesDefeated()) {
    spawnNewWave();
  }

  player.update();

  if (frameCount % 30 == 0) {
    moveGrid(grid);
    arrayShoot(grid);
    spawnBullet(new PVector(player.pos.x + 15, player.pos.y), true);
  }

  checkBulletCollision();
}

void keyPressed() {
  if (keyCode == LEFT)  leftHeld = true;
  if (keyCode == RIGHT) rightHeld = true;
  if (keyCode == UP)    upHeld = true;
  if (keyCode == DOWN)  downHeld = true;

  if (key == ' ') {
    paused = !paused;
  }

  updateMovement();
}

void keyReleased() {
  if (keyCode == LEFT)  leftHeld = false;
  if (keyCode == RIGHT) rightHeld = false;
  if (keyCode == UP)    upHeld = false;
  if (keyCode == DOWN)  downHeld = false;

  updateMovement();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    resetGame();
  }
}

void updateMovement() {
  player.xspeed = (leftHeld && !rightHeld) ? -5 : (rightHeld && !leftHeld) ? 5 : 0;
  player.yspeed = (upHeld && !downHeld) ? -5 : (downHeld && !upHeld) ? 5 : 0;
}

void makeBalls(Enemy[][] g) {
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[r].length; c++) {
      // Determine enemy type based on wave
      float typeChance = random(1);
      float tankChance = 0.1 + wave * 0.05;     // chance for tank enemy grows each wave
      float shooterChance = 0.1 + wave * 0.05;  // chance for shooter enemy grows each wave

      if (typeChance < tankChance) {
        g[r][c] = new Enemy(new PVector(20 + 40*c, 40 + 40*r), 40, "tank");
      } else if (typeChance < tankChance + shooterChance) {
        g[r][c] = new Enemy(new PVector(20 + 40*c, 40 + 40*r), 40, "shooter");
      } else {
        g[r][c] = new Enemy(new PVector(20 + 40*c, 40 + 40*r), 40, "normal");
      }
    }
  }
}

void moveGrid(Enemy[][] g) {
  if (moveDown) {
    for (int r = 0; r < g.length; r++) {
      for (int c = 0; c < g[0].length; c++) {
        if (g[r][c] != null) {
          g[r][c].center.y += g[r][c].esize;
          g[r][c].direction *= -1;
        }
      }
    }
    moveDown = false;
  } else {
    for (int r = 0; r < g.length; r++) {
      for (int c = 0; c < g[0].length; c++) {
        if (g[r][c] != null) g[r][c].move();
      }
    }

    boolean hitside = false;
    for (int r = 0; r < g.length; r++) {
      for (int c = 0; c < g[0].length; c++) {
        if (g[r][c] != null && (g[r][c].center.x <= g[r][c].esize/2 || g[r][c].center.x >= width - g[r][c].esize/2)) {
          hitside = true;
        }
      }
    }
    if (hitside) moveDown = true;

    displayBalls(g);
  }
}

void displayBalls(Enemy[][] g) {
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {
      if (g[r][c] != null) g[r][c].display();
    }
  }
}

void arrayShoot(Enemy[][] g) {
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {
      Enemy e = g[r][c];
      if (e != null && e.alive && random(1) < e.shootProbability) {
        if (findOpenBulletSlot() != -1) {
          spawnBullet(new PVector(e.center.x, e.center.y), false);
        }
      }
    }
  }
}

void displayBullets(Bullet[] arr) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] != null) {
      if (!paused) arr[i].move();
      arr[i].display();
    }
  }
}

int findOpenBulletSlot() {
  for (int i = 0; i < bullet.length; i++) {
    if (bullet[i] == null) {
      return i;
    }
  }
  return -1;
}

void spawnBullet(PVector p, boolean alliance) {
  int i = findOpenBulletSlot();
  if (i != -1) {
    bullet[i] = new Bullet(p, 10, alliance);
  }
}

void checkBulletCollision() {
  for (int i = 0; i < bullet.length; i++) {
    if (bullet[i] == null) {
      continue;
    }

    Bullet b = bullet[i];

    // Player bullet hits enemy
    if (b.alliance) {
      for (int r = 0; r < grid.length; r++) {
        for (int c = 0; c < grid[0].length; c++) {
          Enemy e = grid[r][c];
          if (e != null && e.alive && b.pos.dist(e.center) <= (b.size/2 + e.esize/2)) {
            e.health--;       // decrease enemy health
            bullet[i] = null; // remove bullet

            if (e.health <= 0) {
              grid[r][c] = null; // enemy dies
            }
            break; // stop checking after hitting one enemy
          }
        }
      }
    }

    // Enemy bullet hits player
    else {
      float shipRadius = 30;
      if (b.pos.dist(player.pos) <= (b.size/2 + shipRadius)) {
        lives--;
        bullet[i] = null;

        if (lives <= 0) {
          gameOver = true;
        }
      }
    }

    // Remove bullets that go off-screen
    if (b.offScreen()) {
      bullet[i] = null;
    }
  }
}

void displayGameOver() {
  background(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(255, 0, 0);
  text("GAME OVER", width/2, height/2);
  textSize(20);
  fill(255);
  text("Click to play again", width/2, height/2 + 40);
}

void resetGame() {
  player.pos = new PVector(300, 500);
  player.xspeed = 0;
  player.yspeed = 0;

  lives = 3;

  for (int i = 0; i < bullet.length; i++) bullet[i] = null;

  makeBalls(grid);
  moveDown = false;

  gameOver = false;
}

void displayPause() {
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(0, 0, 255);
  text("PAUSED", width/2, height/2);
  textSize(20);
  fill(0);
  text("Press SPACE to resume", width/2, height/2 + 40);
}

boolean allEnemiesDefeated() {
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[0].length; c++) {
      if (grid[r][c] != null && grid[r][c].alive) return false;
    }
  }
  return true;
}

void spawnNewWave() {
  wave++;
  makeBalls(grid);
  moveDown = false;
}
