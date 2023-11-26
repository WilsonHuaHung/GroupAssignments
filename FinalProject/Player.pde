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
  boolean elementSelected = false; // Flag to track if the element is selected
  ArrayList<Projectile> projectiles;
  boolean elementSelectionMenuActive = false;
  Shield shield; // Declare shield at the class level
  int powerupCount;

  
  // projectile cooldowns
  int fireCooldown = 30; // Cooldown for fire projectiles in frames (adjust as needed)
  int waterCooldown = 20; // Cooldown for water projectiles in frames (adjust as needed)
  int earthCooldown = 60; // Cooldown for earth projectiles in frames (adjust as needed)
  int airCooldown = 10; // Cooldown for air projectiles in frames (adjust as needed)

  int fireCooldownCounter = 0;
  int waterCooldownCounter = 0;
  int earthCooldownCounter = 0;
  int airCooldownCounter = 0;

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
    powerupCount = 0;
  }

  void update() {
    // Check for level up
    if (powerupCount >= 200 && player.level == 1) {
      player.levelUp();
    } else if (powerupCount >= 400 && player.level == 2) {
      player.levelUp();
    } else if (powerupCount >= 600 && player.level == 3) {
      player.levelUp();
    }

    // Update projectile cooldown counters
    if (fireCooldownCounter > 0) {
      fireCooldownCounter--;
    }
    if (waterCooldownCounter > 0) {
      waterCooldownCounter--;
    }
    if (earthCooldownCounter > 0) {
      earthCooldownCounter--;
    }
    if (airCooldownCounter > 0) {
      airCooldownCounter--;
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
        if (shield == null) {
          shield = new Shield(x, y, size, selectedElement);
        }
  
        shield.update(x, y); // Update shield position
        shield.display();
  
      // Display projectiles
      for (Projectile projectile : projectiles) {
          projectile.display();
      }
    }
  }
  void displayShield() {
    if (shield != null) {
      shield.display();
      }
    }
  
  
 // Hitting interactions
  boolean hits(FireEnemy enemy) {
    // Check if the shield is active and the enemy is close to the player
    if (shield != null && dist(x, y, enemy.x, enemy.y) < shield.getRadius()) {
      // Enemy touches the shield, make the enemy disappear
      return true;
    }

    float distance = dist(x, y, enemy.x, enemy.y);
    if (!shieldActive() && distance < size / 2 + enemy.size / 2) {
      // Only decrement lives if the shield is not active
      lives--;
      if (lives <= 0) {
        gameOver = true;
      } else {
        // If there are remaining lives, reset the player's position
        x = width / 2;
        y = height - 30;
      }
      return true;
    }
    return false;
  }

  boolean hits(WaterEnemy enemy) {
    // Check if the shield is active and the enemy is close to the player
    if (shield != null && dist(x, y, enemy.x, enemy.y) < shield.getRadius()) {
      // Enemy touches the shield, make the enemy disappear
      return true;
    }

    float distance = dist(x, y, enemy.x, enemy.y);
    if (!shieldActive() && distance < size / 2 + enemy.size / 2 && canGrow) {
      size += growthIncrement;
      canGrow = false;
      return true;
    } else if (!shieldActive() && distance >= size / 2 + enemy.size / 2) {
      canGrow = true;
    }
    return false;
  }
  
  boolean hits(Powerup powerup) {
    float distance = dist(x, y, powerup.x, powerup.y);
    if (distance < size / 2 + powerup.size / 2) {
      // Shrink the player's size by the growth increment
      size -= growthIncrement;
      size = max(size, minSize); // Ensure the size doesn't go below the minimum size
      powerupCount++;
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

  boolean shieldActive() {
    return shield != null;
  }


  // Level up interaction
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
    
    if (level == 3) {
        shield = new Shield(x, y, size, selectedElement);
    }
  }



  // Element Selection Menu
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



  // Level 2 Projectiles (Fire, Water, Earth, Air)
  void shootProjectile() {
    // Check if an element is selected
    if (elementSelected) {
      if (selectedElement.equals("fire") && fireCooldownCounter == 0) {
        projectiles.add(new FireProjectile(x, y));
        fireCooldownCounter = fireCooldown;
      } else if (selectedElement.equals("water") && waterCooldownCounter == 0) {
        projectiles.add(new WaterProjectile(x, y));
        waterCooldownCounter = waterCooldown;
      } else if (selectedElement.equals("earth") && earthCooldownCounter == 0) {
        projectiles.add(new EarthProjectile(x, y));
        earthCooldownCounter = earthCooldown;
      } else if (selectedElement.equals("air") && airCooldownCounter == 0) {
        projectiles.add(new AirProjectile(x, y));
        airCooldownCounter = airCooldown;
      }
    }
  }
}
