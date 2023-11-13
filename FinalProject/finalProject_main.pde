Player player;
ArrayList<FireEnemy> fireEnemies;
ArrayList<WaterEnemy> waterEnemies;
ArrayList<Powerup> powerups;
int score;
int lives;
boolean gameOver;
boolean gameStarted;  // New variable to track whether the game has started
PImage backgroundImage;

void setup() {
  size(400, 400);
  gameStarted = false;  // Set the initial state to not started
  player = new Player();
  fireEnemies = new ArrayList<FireEnemy>();
  waterEnemies = new ArrayList<WaterEnemy>();
  powerups = new ArrayList<Powerup>();
  score = 0;
  lives = 3;
  gameOver = false;

  // Load the background image
  backgroundImage = loadImage("backg.png");

  // Set a readable font for the score and lives
  PFont font = createFont("Arial", 16);
  textFont(font);
}

void draw() {
  if (!gameStarted) {
    // Display the startup screen
    displayStartupScreen();
  } else if (!gameOver) {
    // Display the game screen
    image(backgroundImage, 0, 0, width, height);

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
        lives--;  // Decrement lives on collision
        if (lives <= 0) {
          gameOver = true;
        } else {
          // If there are remaining lives, reset the player's position
          player = new Player();
        }
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
    //background rect
    fill(255, 0, 0); 
    rect(8, 8, 120, 30);
    rect(275, 8, 100, 30);
    // Display score and lives with black font
    fill(0);
    textSize(24);
    text("Score: " + score, 20, 30);
    text("Lives: " + lives, width - 120, 30);
  } else if (gameOver) {
    // All-black screen when the game is over
    background(0);  // Set the background to black

    fill(255);
    textSize(32);
    String gameOverText = "Game Over";
    text(gameOverText, width / 2 - textWidth(gameOverText) / 2, height / 2 - 16);

    textSize(20);
    String finalScoreText = "Final Score: " + score;
    text(finalScoreText, width / 2 - textWidth(finalScoreText) / 2, height / 2 + 20);
  } else {
    // Display the game over screen
    displayGameOverScreen();
  }
}

void keyPressed() {
  if (!gameStarted) {
    // Start the game when any key is pressed
    gameStarted = true;
    initializeGame();
  } else if (!gameOver) {
    // Handle player movement during the game
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
}


void mousePressed() {
  if (gameOver) {
    // Restart the game
    player = new Player();
    fireEnemies.clear();
    waterEnemies.clear();
    powerups.clear();
    score = 0;
    lives = 3;
    gameOver = false;
    initializeGame();
  }
}
void displayStartupScreen() {
  background(173, 216, 230);  // Set the background to light blue

  fill(0);
  textSize(40);
  String titleText = "ELEMENT RUN";
  text(titleText, width / 2 - textWidth(titleText) / 2, height / 2 - 16);

  textSize(15);
  String startText = "PRESS ANY KEY TO START ";
  text(startText, width / 2 - textWidth(startText) / 2, height / 2 + 20);
}

void initializeGame() {
  player = new Player();
  fireEnemies = new ArrayList<FireEnemy>();
  waterEnemies = new ArrayList<WaterEnemy>();
  powerups = new ArrayList<Powerup>();
  score = 0;
  lives = 3;
  gameOver = false;
}

void displayGameOverScreen() {
  background(0);  // Set the background to black

  fill(255);
  textSize(32);
  String gameOverText = "Game Over";
  text(gameOverText, width / 2 - textWidth(gameOverText) / 2, height / 2 - 16);

  textSize(20);
  String finalScoreText = "Final Score: " + score;
  text(finalScoreText, width / 2 - textWidth(finalScoreText) / 2, height / 2 + 20);
}
