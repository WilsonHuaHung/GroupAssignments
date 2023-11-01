class Player {
  float x;
  float y;
  float speed;
  int size;
  
  Player() {
    x = width / 2;
    y = height - 30;
    speed = 5; // Adjust the speed as needed
    size = 30; // Adjust the size as needed
  }
  
  void update() {
    // Update player position based on controls
    if (keyPressed) {
      if (key == 'a' || key == 'A') {
        move(-1);
      } else if (key == 'd' || key == 'D') {
        move(1);
      }
    }
  }
  
  void display() {
    // Display the player character
    fill(0, 0, 255); // Blue color
    ellipse(x, y, size, size);
  }
  
  boolean hits(Enemy enemy) {
    // Check for collision with an enemy
    float distance = dist(x, y, enemy.x, enemy.y);
    return distance < size / 2 + enemy.size / 2;
  }
  
  void move(int dir) {
    // Move the player character
    x += dir * speed;
    x = constrain(x, size / 2, width - size / 2);
  }
}
