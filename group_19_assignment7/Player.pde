class Player {
  float x;
  float y;
  float speed;
  int size;
  int growthIncrement; // Define the growth increment
  boolean canGrow; // Add a flag to control growth

  Player() {
    x = width / 2;
    y = height - 30;
    speed = 40;
    size = 30;
    growthIncrement = 1; // Set the growth increment size
    canGrow = true; // Initialize the flag as true
  }

  void update() {
    // Update player position based on controls
  }

  void display() {
    // Display the player character
    fill(0, 0, 255); // Blue color
    ellipse(x, y, size, size);
  }

  boolean hits(FireEnemy enemy) {
    float distance = dist(x, y, enemy.x, enemy.y);
    return distance < size / 2 + enemy.size / 2;
  }

  boolean hits(WaterEnemy enemy) {
    float distance = dist(x, y, enemy.x, enemy.y);
    if (distance < size / 2 + enemy.size / 2 && canGrow) {
      // Increase the player's size by the growth increment
      size += growthIncrement;
      canGrow = false; // Set the flag to false to prevent continuous growth
      return true;
    }
    else if (distance >= size / 2 + enemy.size / 2) {
      canGrow = true; // Reset the flag when no longer colliding
    }
    return false;
  }


  void move(int xDir, int yDir) {
    x += xDir * speed;
    y += yDir * speed;
    x = constrain(x, size / 2, width - size / 2);
    y = constrain(y, size / 2, height - size / 2);
  }
}
