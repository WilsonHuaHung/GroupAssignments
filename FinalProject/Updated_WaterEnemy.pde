PImage waterEnemyImage;
class WaterEnemy {
  Animation waterEnemyAnimation;
  float x;
  float y;
  float speedX;
  float speedY;
  float size;

  WaterEnemy() {
    String[] filenames = {"waterEnemy1.png", "waterEnemy2.png", "waterEnemy3.png", "waterEnemy4.png", "waterEnemy5.png", "waterEnemy6.png", "waterEnemy7.png"};
    waterEnemyAnimation = new Animation(filenames, 12, 2); // Initialize the animation with 12 frames per second
    x = random(width);
    y = 0;
    speedX = random(-2, 2);
    speedY = random(2, 4);
    size = 20;
  }

  void update() {
    waterEnemyAnimation.update();
    x += speedX;
    y += speedY;
  }

  void display() {
    waterEnemyAnimation.display(this.x, this.y);
    fill(0, 0, 255); // Blue color for Water enemies
  }

  boolean offscreen() {
    return (y > height);
  }
}
