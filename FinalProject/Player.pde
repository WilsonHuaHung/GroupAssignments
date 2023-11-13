class Player {
  float x;
  float y;
  float speed;
  int size;
  int growthIncrement; // Define the growth increment
  boolean canGrow; // Add a flag to control growth
  int minSize; // Minimum size for the player
  int level; // Player level
  String selectedElement; // Selected element
  boolean elementSelected; // Flag to track if the element is selected

  Player() {
    x = width / 2;
    y = height - 30;
    speed = 40;
    size = 30;
    growthIncrement = 3; // Set the growth increment size
    canGrow = true; // Initialize the flag as true
    minSize = 20; // Set the minimum size
    level = 1; // Start at level 1
    selectedElement = "";
    elementSelected = false;
  }

  void update() {
    // Update player position based on controls
    // ...

    // Check for level up
    if (score >= 10 && level == 1) {
      levelUp();
    } else if (score >= 20 && level == 2) {
      levelUp();
      // Pause the game and show element selection menu at level 2
      // Set elementSelected and selectedElement based on user input
    } else if (score >= 30 && level == 3) {
      levelUp();
    }
  }

  void display() {
    // Display the player character
    fill(0, 100, 100);
    ellipse(x, y, size, size);

    // Display shield animation at level 3
    if (level == 3) {
      displayShield();
    }
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

  void levelUp() {
    level++;
    // Implement level up logic here
    // Pause the game, show level up message, etc.
    // ...
  }

  void displayShield() {
    // Implement shield animation based on the selected element
    if (selectedElement.equals("fire")) {
      // Fire shield animation
      // ...
    } else if (selectedElement.equals("water")) {
      // Water shield animation
      // ...
    } else if (selectedElement.equals("earth")) {
      // Earth shield animation
      // ...
    } else if (selectedElement.equals("air")) {
      // Air shield animation
      // ...
    }
  }
}
