Player player;
ArrayList<Enemy> enemies;
int score;
boolean gameOver;

void setup() {
  size(400, 400);
  player = new Player();
  enemies = new ArrayList<Enemy>();
  score = 0;
  gameOver = false;
}

void draw() {
  background(220);
  
  if (!gameOver) {
    player.update();
    player.display();
    
    // Update and display enemies
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      enemy.update();
      enemy.display();
      
      if (player.hits(enemy)) {
        gameOver = true;
      }
      
      if (enemy.offscreen()) {
        enemies.remove(i);
        score++;
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
    text("Game Over", width/2 - 100, height/2 - 16);
    textSize(20);
    text("Final Score: " + score, width/2 - 50, height/2 + 20);
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    player.move(-1);
  } else if (key == 'd' || key == 'D') {
    player.move(1);
  }
}

void mousePressed() {
  if (gameOver) {
    // Restart the game
    player = new Player();
    enemies.clear();
    score = 0;
    gameOver = false;
  }
}
