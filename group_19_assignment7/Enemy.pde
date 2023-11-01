class Enemy {
  float x;
  float y;
  float speed;
  float size;
  
  Enemy() {
    x = random(width);
    y = 0;
    speed = random(1, 5);
    size = 20; // Adjust the size as needed
  }
  
  void update() {
    // Update enemy position
    y += speed;
  }
  
  void display() {
    // Display the enemy
    fill(255, 0, 0); // Red color
    ellipse(x, y, size, size);
  }
  
  boolean offscreen() {
    // Check if the enemy is offscreen
    return (y > height);
  }
}
