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
  ArrayList<Projectile> projectiles;

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
    projectiles = new ArrayList<>(); // Initialize the projectiles list
  }

  void update() {
    // Update player position based on controls
    // ...

    // Check for level up
    if (score >= 10 && player.level == 1) {
      player.levelUp();
    } else if (score >= 20 && player.level == 2) {
      player.levelUp();
    } else if (score >= 30 && player.level == 3) {
      player.levelUp();
    }

    // Update projectiles
    for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile projectile = projectiles.get(i);
      projectile.update();

      // Check for projectile collisions with enemies
      for (int j = fireEnemies.size() - 1; j >= 0; j--) {
        if (projectile.hits(fireEnemies.get(j))) {
          fireEnemies.remove(j);
          projectiles.remove(i);
          score++;
        }
      }
      for (int j = waterEnemies.size() - 1; j >= 0; j--) {
        if (projectile.hits(waterEnemies.get(j))) {
          waterEnemies.remove(j);
          projectiles.remove(i);
          score++;
        }
      }
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

    // Display projectiles
    for (Projectile projectile : projectiles) {
      projectile.display();
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

    // Pause the game (you might want to add a variable to control the game state)
    gamePaused = true;

    // Show level up message
    fill(255);
    textSize(32);
    String levelUpText = "Level Up!";
    text(levelUpText, width / 2 - textWidth(levelUpText) / 2, height / 2 - 16);

    // ... Additional logic for level up message

    // Display element selection menu
    displayElementSelectionMenu();

    // Resume the game after displaying the element selection menu
    gamePaused = false;

    inElementSelection = true;
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

  boolean elementSelectionMenuActive = false;

  void displayElementSelectionMenu() {
    if (level == 2 && !elementSelected) {
      // Display element selection menu
      background(200);  // Example background for the menu
      fill(0);
      textSize(20);
      text("Select your element:", width / 2 - 100, height / 2 - 30);
      text("1. Fire", width / 2 - 100, height / 2);
      text("2. Water", width / 2 - 100, height / 2 + 30);
      text("3. Earth", width / 2 - 100, height / 2 + 60);
      text("4. Air", width / 2 - 100, height / 2 + 90);
      elementSelectionMenuActive = true;
    } else {
      elementSelectionMenuActive = false;
    }
  }

  void handleElementSelection(char key) {
    // Check the user's input and set the selectedElement accordingly
    if (key == '1') {
      selectedElement = "fire";
      elementSelected = true;
    } else if (key == '2') {
      selectedElement = "water";
      elementSelected = true;
    } else if (key == '3') {
      selectedElement = "earth";
      elementSelected = true;
    } else if (key == '4') {
      selectedElement = "air";
      elementSelected = true;
    }
  }

  void shootProjectile() {
    // Check if an element is selected
    if (elementSelected) {
      // Create a new projectile based on the selected element
      if (selectedElement.equals("fire")) {
        projectiles.add(new FireProjectile(x, y));
      } else if (selectedElement.equals("water")) {
        projectiles.add(new WaterProjectile(x, y));
      } else if (selectedElement.equals("earth")) {
        projectiles.add(new EarthProjectile(x, y));
      } else if (selectedElement.equals("air")) {
        projectiles.add(new AirProjectile(x, y));
      }
    }
  }
}
