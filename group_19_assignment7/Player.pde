class Player {
  float x;
  float y;
  float speed;
  int size;
  int growthIncrement; // Define the growth increment
  boolean canGrow; // Add a flag to control growth
  int minSize; // Minimum size for the player

  Player() {
    x = width / 2;
    y = height - 30;
    speed = 40;
    size = 30;
    growthIncrement = 3; // Set the growth increment size
    canGrow = true; // Initialize the flag as true
    minSize = 20; // Set the minimum size
  }

  void update() {
    // Update player position based on controls
  }

  void display() {
    // Display the player character
    fill(0, 100, 100);
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
  } else if (distance >= size / 2 + enemy.size / 2) {
    canGrow = true; // Reset the flag when no longer colliding
  }
  return false;
}

  boolean hits(Powerup powerup) {
    float distance = dist(x, y, powerup.x, powerup.y);
    if (distance < size / 2 + powerup.size / 2) {
      // Shrink the player's size by the growth increment
      size -= growthIncrement;
      size = max(size, minSize); // Ensure the size doesn't go below the minimum size
      return true;
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
