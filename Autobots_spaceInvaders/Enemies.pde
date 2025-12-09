class Enemy {
  int x;
  int y;
  int esize;
  PVector center;
  color c;
  
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
   
  }
    
  
}
