class Enemy {
  int esize;
  PVector center;
  color c;
  int speed = 40;
  int direction = 1;
  boolean alive;
  Bullet bullet[];

  Enemy(PVector p, int s) {
    esize = s;
    center = new PVector(p.x, p.y);
    alive = true;
  }

  void setColor(color ec) {
    c = ec;
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

  void shoot() {
    for (int i = 0; i < 5; i++) {
      int b = (int)random(0, 11);
      print(b);
      if (b == 5) {
        bullet[1] = new Bullet(center, 10, false);
      }
    }
  }
}
