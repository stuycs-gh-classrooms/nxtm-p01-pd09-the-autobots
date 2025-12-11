class Bullet {
  PVector pos;
  int shootSpeed;
  int size;
  boolean alliance; //false means enemy shot, true means spaceship shot
  color c;

  Bullet(PVector p, int s, boolean side) {
    size = s;
    pos = new PVector(p.x, p.y);
    side = alliance;
  }

  boolean collisionCheck(Enemy enemy, SpaceShip mShip, SpaceShip.Ship sShip) {
    if (alliance == true) {
      return (this.pos.dist(enemy.center)
        <= (this.size/2 + enemy.esize/2) );
    } else if (alliance == false) {
      return (this.pos.dist(mShip.pos)
        <= (this.size/2 + sShip.lengthSM/2) );
    } else {
      return false;
    }
  }

  void setColor(color newC) {
    c = newC;
  }//setColor


  void display() {
    fill(255);
    circle(pos.x, pos.y, size);
  }//display

  //movement behavior
  void move() {
    if (pos.y > height - size/2 || pos.y < size/2) {
      if (alliance == true) {
        shootSpeed *= -1;
      } else if (alliance == false) {
        shootSpeed *= 1;
      }
    }
    pos.y+= shootSpeed;
  }//move
}
