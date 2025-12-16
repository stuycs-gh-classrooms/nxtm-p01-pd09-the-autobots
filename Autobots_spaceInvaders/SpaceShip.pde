class SpaceShip {
  PVector pos;
  int xspeed;
  int yspeed;
  Ship shipBody;

  SpaceShip(int x, int y, int xspeed, int yspeed) {
    pos = new PVector(x, y);
    this.xspeed = xspeed;
    this.yspeed = yspeed;
    shipBody = new Ship(30, 40, 15, 20);
  }

  class Ship {
    int widthSM, lengthSM;
    int widthSS, lengthSS;
    float offset;

    Ship(int widthSM, int lengthSM, int widthSS, int lengthSS) {
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

      // small bodies at corners
      float smallXOffset = widthSS * 0.5;
      float smallYOffset = lengthSS * 0.5;

      rect(x - smallXOffset, y - smallYOffset, widthSS, lengthSS); // top-left
      rect(x + widthSM - smallXOffset, y - smallYOffset, widthSS, lengthSS); // top-right
      rect(x - smallXOffset, y + lengthSM - smallYOffset, widthSS, lengthSS); // bottom-left
      rect(x + widthSM - smallXOffset, y + lengthSM - smallYOffset, widthSS, lengthSS); // bottom-right
    }
  }

  void display() {
    shipBody.display(pos.x, pos.y);
  }

  void update() {
    pos.x += xspeed;
    pos.y += yspeed;

    float offset = shipBody.lengthSS * 0.5;
    float w = shipBody.widthSM;
    float h = shipBody.lengthSM;

    // screen boundaries
    pos.x = constrain(pos.x, offset, width - w - offset);
    pos.y = constrain(pos.y, offset, height - h - offset);
  }
}
