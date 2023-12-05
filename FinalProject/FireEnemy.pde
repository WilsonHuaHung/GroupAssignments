
PImage fireEnemyImage;
class FireEnemy {
  Animation fireEnemyAnimation;
  float x;
  float y;
  float speed;
  int size;

  FireEnemy() {
    String[] filenames = {"fireEnemy1.png", "fireEnemy2.png", "fireEnemy3.png", "fireEnemy4.png", "fireEnemy5.png", "fireEnemy6.png", "fireEnemy7.png"};
    fireEnemyAnimation = new Animation(filenames, 12, 2); // Initialize the animation with 12 frames per second
    x = random(width);
    y = 0;
    speed = 2;
    size = 20;
  }

  void update() {
    fireEnemyAnimation.update();
    y += speed;
  }

  void display() {
    fireEnemyAnimation.display(this.x, this.y);
    fill(255, 0, 0);
  }

  boolean offscreen() {
    return y > height + size / 2;
  }

  boolean hits(Player player) {
    // Check for collision with the player
    float distance = dist(x, y, player.x, player.y);
    return distance < size / 2 + player.size / 2;
  }
}
