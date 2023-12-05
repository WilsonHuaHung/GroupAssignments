
PImage waterEnemyImage;
class WaterEnemy {
  float x;
  float y;
  float speedX;
  float speedY;
  float size;

  WaterEnemy() {
    x = random(width);
    y = 0;
    speedX = random(-2, 2);
    speedY = random(2, 4);
    size = 20;
  }

  void update() {
    x += speedX;
    y += speedY;
  }

  void display() {
    fill(0, 0, 255); // Blue color for Water enemies
    image(waterEnemyImage, x - waterEnemyImage.width / 2, y - waterEnemyImage.height / 2);
  }

  boolean offscreen() {
    return (y > height);
  }
}
