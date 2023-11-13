class FireEnemy {
  float x;
  float y;
  float speedX;
  float speedY;
  float size;

  FireEnemy() {
    x = random(width);
    y = 0;
    speedX = random(-2, 2);
    speedY = random(2, 5);
    size = 20;
  }

  void update() {
    x += speedX;
    y += speedY;
  }

  void display() {
    fill(255, 0, 0); // Red color for Fire enemies
    ellipse(x, y, size, size);
  }

  boolean offscreen() {
    return (y > height);
  }
}
