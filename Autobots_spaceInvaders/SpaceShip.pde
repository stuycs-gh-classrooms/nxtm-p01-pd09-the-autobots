class SpaceShip {
  PVector pos;
  int xspeed;
  int yspeed;
  Ship shipBody;

  SpaceShip(int x, int y, int xspeed, int yspeed) {
    pos = new PVector(x, y);
    this.xspeed = xspeed;
    this.yspeed = yspeed;

    shipBody = new Ship(0, 0, 30, 40, 15, 20);
  }

  class Ship {
    int xOffset; //xPos of ship
    int yOffset; //yPos of ship
    int widthSM; //size of main body
    int lengthSM;
    int widthSS; //size of small bodies
    int lengthSS;
    float offset; //offsets for small bodies

    Ship(int xOffset, int yOffset, int widthSM, int lengthSM, int widthSS, int lengthSS) {
      this.xOffset = xOffset;
      this.yOffset = yOffset;
      this.widthSM = widthSM;
      this.lengthSM = lengthSM;
      this.widthSS = widthSS;
      this.lengthSS = lengthSS;
      offset = 0.5 * widthSM;
    }

    void display(float x, float y) {
      fill(255);

      // main body
      rect(x, y, widthSM, lengthSM);

      // offsets for small bodies
      float xOffset = widthSS * 0.5;
      float yOffset = lengthSS * 0.5;

      rect(x - xOffset, y - yOffset, widthSS, lengthSS); //top left
      rect(x + widthSM - xOffset, y - yOffset, widthSS, lengthSS); //top right
      rect(x - xOffset, y + lengthSM - yOffset, widthSS, lengthSS); //bottom left
      rect(x + widthSM - xOffset, y + lengthSM - yOffset, widthSS, lengthSS); //bottom right
    }
  }

  void display() {
    shipBody.display(pos.x, pos.y);
  }

  void update() {
    pos.x += xspeed;
    pos.y += yspeed;

    float offset = shipBody.lengthSS * 0.5;   // half the small body width
    float w = shipBody.widthSM; // main body width
    float h = shipBody.lengthSM;

    // check size of full ship
    float leftEdge = pos.x - offset;
    float rightEdge = pos.x + w + offset;
    float topEdge = pos.y - offset;
    float bottomEdge = pos.y + h + offset;

    // prevent leaving the screen
    if (leftEdge < 0) {
      pos.x = offset;
    }
    if (rightEdge > width) {
      pos.x = width - w - offset;
    }
    if (topEdge < 0) {
      pos.y = offset;
    }
    if (bottomEdge > height) {
      pos.y = height - h - offset;
    }
  }

  //stop moving x direction
  void stopX() {
    xspeed = 0;
  }
  
  //stop moving y direction
  void stopY() {
    yspeed = 0;
  }
}
