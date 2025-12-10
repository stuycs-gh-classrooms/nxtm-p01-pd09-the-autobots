class Enemy {
  int esize;
  PVector center;
  color c;
  int speed = 40;
  int direction = 1;
  
  Enemy(PVector p, int s){
    esize = s;
    center = new PVector(p.x, p.y);
  }
  
  void setColor(color ec) {
    c = ec;
  }
  
  void display() {
    fill(c);
    circle(center.x, center.y, esize);
  }
  void move() {
    center.x += speed * direction;
    }
   
  }
