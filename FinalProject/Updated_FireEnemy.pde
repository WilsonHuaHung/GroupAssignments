
PImage fireEnemyImage;
class FireEnemy {
  float x;
  float y;
  float speed;
  int size;

  FireEnemy() {
    x = random(width);
    y = 0;
    speed = 2;
    size = 20;
  }

  void update() {
    y += speed;
  }

  void display() {
    fill(255, 0, 0);
    image(fireEnemyImage, x - fireEnemyImage.width / 2, y - fireEnemyImage.height / 2);
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
