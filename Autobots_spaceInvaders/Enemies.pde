class Enemy {
  int esize;
  PVector center;
  color c;
  int speed = 40;
  int direction = 1;
  boolean alive;

  Enemy(PVector p, int s) {
    esize = s;
    center = new PVector(p.x, p.y);
  }

  void setColor(color ec) {
    c = ec;
  }

  void display() {
    alive = true;
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
