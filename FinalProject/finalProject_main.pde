import processing.sound.*;
SoundFile audioFile;

Player player;
ArrayList<FireEnemy> fireEnemies;
ArrayList<WaterEnemy> waterEnemies;
ArrayList<Powerup> powerups;
ArrayList<Projectile> projectiles;
int score;
int lives;
boolean gameOver;
boolean gameStarted;  // New variable to track whether the game has started
PImage backgroundImage;
boolean gamePaused = false;
boolean inElementSelection = false;
boolean settingsOn = false;
boolean howTo = false;
boolean leaderboard = false;
// defaults to medium difficulty
int fireDifficulty = 90;
int waterDifficulty = 75;
int powerDifficulty = 100;

Buttons[] diffButtons = new Buttons[3];
Buttons[] audioButtons = new Buttons[5];

void setup() {
  size(400, 400);
  gameStarted = false;  // Set the initial state to not started
  player = new Player();
  fireEnemies = new ArrayList<FireEnemy>();
  waterEnemies = new ArrayList<WaterEnemy>();
  powerups = new ArrayList<Powerup>();
  projectiles = new ArrayList<Projectile>();
  score = 0;
  lives = 3;
  gameOver = false;

  // Load the background image
  backgroundImage = loadImage("backg.png");

  // Set a readable font for the score and lives
  PFont font = createFont("Arial", 16);
  textFont(font);
  
  for (int i = 0; i < diffButtons.length; i++) {
    int x =100 + i*50;
    diffButtons[i] = new Buttons(x, 155, 10, color(255), color(0), i,diffButtons);
  }
  
 audioFile = new SoundFile(this, "sound.mp3");
 audioFile.loop();
 audioFile.amp(.5);
  for (int i = 0; i < audioButtons.length; i++) {
    int x =100 + i*50;
    audioButtons[i] = new Buttons(x, 280, 10, color(255), color(0), i,audioButtons);
  }
  
  // manually sets buttons to middle to begin
  diffButtons[1].isPressed(151,155);
  audioButtons[2].isPressed(204,289);
  
}

void draw() {
  if (!gameStarted) {
    // Display the startup screen
    if (settingsOn){
      displaySettingsScreen();
        for (Buttons b : diffButtons) {
        b.display();}
        
       for (Buttons b : audioButtons) {
        b.display();}
    }
    if(leaderboard){
      displayLeaderboard();
    }
      else{
      displayStartupScreen();
      //  how to play screen
      if (howTo){
          displayHowTo();}
  }
    
  } else if (!gameOver && !gamePaused) {
    // Display the game screen
    image(backgroundImage, 0, 0, width, height);

    player.update();
    player.display();

    // Create and display Fire enemies
    if (frameCount % fireDifficulty == 0) {
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
      // Check for collisions with Water enemies
      for (int j = fireEnemies.size() - 1; j >= 0; j--) {
        if (player.hits(fireEnemy)) {
          // Fire enemy hit logic already handled in the Player class
        }
      }
    }
    // Create and display Water enemies
    if (frameCount % waterDifficulty == 0) {
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

    // Create and display Powerups
    if (frameCount % powerDifficulty == 0) {
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
        player.powerupCount++;
      }
    }

    // Update and display projectiles
    for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile projectile = projectiles.get(i);
      projectile.update();
      projectile.display();
        if (projectile.offscreen()) {
          projectiles.remove(i);
        }
      // Check for collisions with enemies
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

    //background rect
    fill(255, 0, 0); 
    rect(8, 8, 120, 30);
    rect(275, 8, 100, 30);
    rect(8, 360, 100, 30);
    // Display score and lives with black font
    fill(0);
    textSize(24);
    text("Score: " + score, 20, 30);
    text("Lives: " + lives, width - 120, 30);
    text("XP: " + player.powerupCount, width - 390, 385);
    
    
    // Shooting projectile
    // Display projectiles
    for (Projectile projectile : player.projectiles) {
      projectile.display();
    }
    
    // When user turns level two. Users will be prompted to select a specific element.
    player.displayElementSelectionMenu();

    if (player.elementSelectionMenuActive) {
      // Element selection menu is active
      return;  
    }
    // Check if the element is selected
    if (player.elementSelected) {
      // Handle element selection
      player.handleElementSelection(key);
    }

    if (inElementSelection) {
      // Handle element selection during the element selection state
      handleElementSelection(key);
      // Set the game state back to normal after element selection
      inElementSelection = false;
      // Unpause the game
      gamePaused = false;
    }
    
    // Display projectiles at level 2
    if (player.level == 2 && !player.elementSelected && !inElementSelection) {
      player.displayElementSelectionMenu();
    } else if (player.level == 2 && player.elementSelected) {
      // Display projectiles
      for (Projectile projectile : player.projectiles) {
        projectile.display();
      }
    } else if (player.level > 3) {
      // Display shield animation
      player.displayShield();
    }
    
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
    
    String returnText = "Click to return to home";
    text(returnText, width / 2 - textWidth(returnText) / 2, height / 2 + 100);
    
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
  } else if (!gameOver && key == 'p') {
    // Toggle game pause on spacebar press during the game
    gamePaused = !gamePaused;
    if (gamePaused) {
      // Pause the game
      noLoop();
    } else {
      // Resume the game
      loop();
    }
  } else if (!gameOver && !gamePaused) {
    // Handle player movement during the game
    if (key == 'a' || key == 'A') {
      player.move(-1, 0);
    } else if (key == 'd' || key == 'D') {
      player.move(1, 0);
    } else if (key == 'w' || key == 'W') {
      player.move(0, -1);
    } else if (key == 's' || key == 'S') {
      player.move(0, 1);
    } else if (player.level == 2 && !player.elementSelected) {
      // Element selection menu at level 2
      handleElementSelection(key);
    } else if (mousePressed && player.level >= 2) {
      // Handle shooting projectiles
      player.shootProjectile();
    }
  }
  if (inElementSelection) {
    // Handle element selection during the element selection state
    handleElementSelection(key);
    // Set the game state back to normal after element selection
    inElementSelection = false;
    // Unpause the game
    gamePaused = false;
  }
}

void mousePressed() {
  if (gameOver) {
    // Restart the game
    saveScore();
    player = new Player();
    fireEnemies.clear();
    waterEnemies.clear();
    powerups.clear();
    projectiles.clear();  // Clear projectiles as well
    score = 0;
    lives = 3;
    gameOver = false;
    gameStarted = false;
    displayStartupScreen();
  }
  // Check if the left mouse button is pressed
  if (mouseButton == LEFT && player.level >= 2 && !player.elementSelectionMenuActive) {
    // Handle shooting projectiles
    player.shootProjectile();
  }

  // if settings button is clicked and user is on start screen
  if (mouseX >= 300 && mouseX <= 375 && mouseY >= 330 && mouseY <= 370 && !gameStarted) {
    settingsOn = true;}
    
    //updates difficulty based on user selection
    for (int i = 0; i < diffButtons.length; i++) {
      diffButtons[i].isPressed(mouseX, mouseY);
      if (diffButtons[i].isPressed(mouseX, mouseY) == true){
          fireDifficulty = 130 - (i*40);
          waterDifficulty = 115 - (i*40);
          powerDifficulty = 90 + (i*10);
          //print(fireDifficulty, waterDifficulty, powerDifficulty); 
        }}
        
    //updates audio based on user selection
    for (int i = 0; i < audioButtons.length; i++) {
      audioButtons[i].isPressed(mouseX, mouseY);
      if (audioButtons[i].isPressed(mouseX, mouseY) == true){
      audioFile.amp(map(i, 0, 5, 0, 1));}
    }
       
  // go back to home
  if (mouseX >= 280 && mouseX <= 390 && mouseY >= 350 && mouseY <= 380 && !gameStarted) {
    settingsOn = false;
    howTo = false;
    leaderboard = false;}
  
  // how to play screen
  if (mouseX >= 20 && mouseX <= 100 && mouseY >= 330 && mouseY <= 360 && !gameStarted) {
    howTo = !howTo;}
  
  //leaderboard
  if (mouseX >= 150 && mouseX <= 250 && mouseY >= 330 && mouseY <= 370 && !gameStarted) {
    leaderboard = true;}
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
  
  // settings button, how to play button  
  fill(255);
  rect(300,330, 75,40);
  rect(20,330,100,30);
  rect(150, 330, 100, 40); 
  
  fill(0);
  text("Settings", 310,355);
  text("How to Play", 30,350);
  text("High Score", 160, 355);
}

 void displaySettingsScreen() {
   background(173, 216, 230);
   //textAlign(CENTER, CENTER);
  fill(255);
  stroke(0);
  rect(280,350, 110,30);  
  fill(0);
  text("Back to Home", 290,370);
   
   fill(0);
   textSize(30);
   text("Settings", 150, 50);
   textSize(20);
   text("Difficulty:", 50,100); 
   text("Audio: ", 50,230);
   fill(100);
   textSize(15);
   text("Easy",80,190);
   text("Hard", 190,190);
   text("Low", 80,310);
   text("High", 290,310); 
 }
 
 void displayHowTo() {
   fill(255);
   rect(50,40,300,280);
   textSize(25);
   fill(0);
   text("How to Play", 140, 80);
   textSize(15);
   text("1. Press W, A, S, D to move character ", 70, 110);
   text("2. Left click to shoot projectile", 70, 130);
   text("3. Press P to pause the game", 70,150);
   text("4. Avoid the fire enemies as you will lose", 70, 170);
   text("a life if you collide with the player", 70, 190);
   text("5. Water enemies are both your enemy", 70, 210);
   text("and ally. They make you bigger to make", 70, 230);
   text("it easier for you to earn power-ups, but", 70, 250);
   text("also harm you as it is harder to dodge to", 70, 270);
   text("fire enemies", 70, 290); 
   text("6. Power Ups _____", 70, 310); 
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
  audioFile.play();
  fill(255);
  textSize(32);
  String gameOverText = "Game Over";
  text(gameOverText, width / 2 - textWidth(gameOverText) / 2, height / 2 - 16);

  textSize(20);
  String finalScoreText = "Final Score: " + score;
  text(finalScoreText, width / 2 - textWidth(finalScoreText) / 2, height / 2 + 20);
  String returnText = "Click to return to home";
  text(returnText, width / 2 - textWidth(returnText) / 2, height / 2 + 100);
}

void handleElementSelection(char key) {
  // Check the user's input and set the selectedElement accordingly
  if (key == '1') {
    player.selectedElement = "fire";
    player.elementSelected = true;
  } else if (key == '2') {
    player.selectedElement = "water";
    player.elementSelected = true;
  } else if (key == '3') {
    player.selectedElement = "earth";
    player.elementSelected = true;
  } else if (key == '4') {
    player.selectedElement = "air";
    player.elementSelected = true;
  }
}

void saveScore() {
  // Load existing scores from the file
  String[] existingScores = loadStrings("highscores.txt");

  // Convert the current score to a String (since Processing's saveStrings() requires a String array)
  String newScore = String.valueOf(score);

  // Check if existingScores is not null. If it's null, initialize an empty array
  if (existingScores == null) {
    existingScores = new String[0];
  }

  // Create a new array to hold existing plus new score
  String[] allScores = new String[existingScores.length + 1];
  System.arraycopy(existingScores, 0, allScores, 0, existingScores.length);
  allScores[existingScores.length] = newScore;

  // Save all scores to the file
  saveStrings("highscores.txt", allScores);
}


void displayLeaderboard() {
    background(173, 216, 230); // Sets the background color
    fill(255);
    stroke(0);
    rect(280, 350, 110, 30); // Draws a rectangle (button)
    fill(0);
    text("Back to Home", 290, 370); // Text for the button

    String[] lines = loadStrings("highscores.txt"); // Loads the high scores from a file
    int[] scores = new int[lines.length]; // Array to store the scores as integers

    // Convert the String scores to integers
    for (int i = 0; i < lines.length; i++) {
        try {
            scores[i] = Integer.parseInt(lines[i].trim());
        } catch (NumberFormatException e) {
            println("Error parsing score: " + lines[i]);
            scores[i] = 0; // Default to 0 in case of parsing error
        }
    }

    // Sort the scores in descending order
    scores = sort(scores);
    reverser(scores);

    fill(0);
    text("Top 5 High Scores", 140, 80); // Title for the leaderboard
    textSize(15);

    // Display the top five scores
    for (int i = 0; i < min(scores.length, 5); i++) {
        text((i + 1) + ". " + scores[i], 70, 110 + 20 * i);
    }
}

// Function to reverse the array
void reverser(int[] array) {
    for (int i = 0; i < array.length / 2; i++) {
        int temp = array[i];
        array[i] = array[array.length - 1 - i];
        array[array.length - 1 - i] = temp;
    }
}
