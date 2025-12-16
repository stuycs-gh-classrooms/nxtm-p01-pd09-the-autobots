class Enemy {
  int esize;
  PVector center;
  color c;
  int speed = 40;
  int direction = 1;
  boolean alive;
  int health = 1;
  float shootProbability = 0.1;


  Enemy(PVector pos, int size, String type) {
    this.center = pos.copy();
    this.esize = size;
    this.alive = true;
    this.direction = 1;

    if (type.equals("tank")) {
      health = 2; // needs 2 hits
      shootProbability = 0.05;
      c = color(0, 255, 0);
    } else if (type.equals("shooter")) {
      health = 1;
      shootProbability = 0.25; // more likely to shoot
      c = color(255, 0, 0);
    } else {
      health = 1;
      shootProbability = 0.1;
    }
  }

  void display() {
    if (alive) {
      fill(c);
      circle(center.x, center.y, esize);
    } else {
      fill(255);
    }
  }

  void move() {
    center.x += speed * direction;
  }
}
