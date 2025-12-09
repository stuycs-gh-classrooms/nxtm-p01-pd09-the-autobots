class SpaceShip {
  int x;
  int y;
  int speed;
  
  SpaceShip(int x, int y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
  }
  
  class ship {
    //make spaceship
    int widthSM; //ship main body
    int lengthSM;
    int widthSS; //ship smaller bodies (accessories)
    int lengthSS;
    float offset;
    
    ship(int x, int y, int widthSM, int lengthSM, int widthSS, int lengthSS) {
      this.widthSM = widthSM;
      this.lengthSM = lengthSM;
      this.widthSS = widthSS;
      this.lengthSS = lengthSS;
      
      offset = 0.5 * widthSM;
    }
    
    void display() {
      fill(255);
      rect(x, y, widthSM, lengthSM); //main body
      rect(x - offset, y - offset, widthSS, lengthSS); //top left
      rect(x + widthSM + offset, y - offset, widthSS, lengthSS); //top right
      rect(x - offset, y + lengthSM + offset, widthSS, lengthSS); //bottom left
      rect(x + widthSM + offset, y + lengthSM + offset, widthSS, lengthSS); //bottom right
    }
  }
  
  void display() {
    //ship();
    //Pvector to move?
  }
}
