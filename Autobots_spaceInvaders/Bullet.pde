class Bullet {
  PVector pos;
  int shootSpeed;
  int size;
  boolean alliance; // true = player bullet, false = enemy bullet

  Bullet(PVector p, int s, boolean side) {
    size = s;
    pos = new PVector(p.x, p.y);
    alliance = side;
    shootSpeed = (side ? -7 : 5);  // player shoots upward, enemies downward
  }

  void display() {
    fill(alliance ? color(0,0,255) : color(255,0,0));
    circle(pos.x, pos.y, size);
  }

  void move() {
    pos.y += shootSpeed;
  }

  boolean offScreen() {
    return pos.y < 0 || pos.y > height;
  }
}
