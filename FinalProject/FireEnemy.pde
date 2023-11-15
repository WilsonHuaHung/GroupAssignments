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
    ellipse(x, y, size, size);
  }

  boolean offscreen() {
    return y > height + size / 2;
  }

  boolean hitsPlayer(Player player) {
    float distance = dist(x, y, player.x, player.y);
    return distance < size / 2 + player.size / 2 && !player.shieldActive();
  }
}
