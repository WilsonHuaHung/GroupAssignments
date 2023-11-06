Player player;
ArrayList<FireEnemy> fireEnemies;
ArrayList<WaterEnemy> waterEnemies;
ArrayList<Powerup> powerups;
int score;
boolean gameOver;

void setup() {
  size(400, 400);
  player = new Player();
  fireEnemies = new ArrayList<FireEnemy>();
  waterEnemies = new ArrayList<WaterEnemy>();
  powerups = new ArrayList<Powerup>();
  score = 0;
  gameOver = false;
}

void draw() {
  background(220);

  if (!gameOver) {
    player.update();
    player.display();

    // Create and display Fire enemies
    if (frameCount % 90 == 0) {
      fireEnemies.add(new FireEnemy());
    }
    for (int i = fireEnemies.size() - 1; i >= 0; i--) {
      FireEnemy fireEnemy = fireEnemies.get(i);
      fireEnemy.update();
      fireEnemy.display();
      if (fireEnemy.offscreen()) {
        fireEnemies.remove(i);
        score++;
      }
    }

    // Create and display Water enemies
    if (frameCount % 75 == 0) {
      waterEnemies.add(new WaterEnemy());
    }
    for (int i = waterEnemies.size() - 1; i >= 0; i--) {
      WaterEnemy waterEnemy = waterEnemies.get(i);
      waterEnemy.update();
      waterEnemy.display();
      if (waterEnemy.offscreen()) {
        waterEnemies.remove(i);
        score++;
      }
      
      // Check for collisions with Water enemies
      for (int j = waterEnemies.size() - 1; j >= 0; j--) {
        if (player.hits(waterEnemy)) {
          // Water enemy hit logic already handled in the Player class
        }
      }
    }

    // Check for collisions with Fire enemies
    for (int i = fireEnemies.size() - 1; i >= 0; i--) {
      FireEnemy fireEnemy = fireEnemies.get(i);
      if (player.hits(fireEnemy)) {
        gameOver = true;
      }
    }

    // Create and display Powerups
    if (frameCount % 100 == 0) {
      powerups.add(new Powerup());
    }
    for (int i = powerups.size() - 1; i >= 0; i--) {
      Powerup powerup = powerups.get(i);
      powerup.update();
      powerup.display();
      if (powerup.offscreen()) {
        powerups.remove(i);
        score--;
      }

      // Check for collisions with powerups
      if (player.hits(powerup)) {
        // Handle powerup collision logic here
      }
    }

    // Display score
    fill(0);
    textSize(16);
    text("Score: " + score, 20, 20);
  } else {
    // Game over screen
    fill(0);
    textSize(32);
    text("Game Over", width / 2 - 100, height / 2 - 16);
    textSize(20);
    text("Final Score: " + score, width / 2 - 50, height / 2 + 20);
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    player.move(-1, 0);
  } else if (key == 'd' || key == 'D') {
    player.move(1, 0);
  } else if (key == 'w' || key == 'W') {
    player.move(0, -1);
  } else if (key == 's' || key == 'S') {
    player.move(0, 1);
  }
}

void mousePressed() {
  if (gameOver) {
    // Restart the game
    player = new Player();
    fireEnemies.clear();
    waterEnemies.clear();
    powerups.clear(); // Clear powerups when restarting
    score = 0;
    gameOver = false;
  }
}
