class Powerup {
  float x;
  float y;
  float speedX;
  float speedY;
  float size;
  float rotation; 

  Powerup() {
    x = random(width);
    y = 0;
    speedX = random(-2, 2);
    speedY = random(2, 4);
    size = 20;
    rotation = 0; // Initialize rotation angle
  }

  void update() {
    x += speedX;
    y += speedY;
    rotation += 0.05; // Increment rotation angle
  }

  void display() {
    fill(0, 230, 0);
    pushMatrix(); 
    translate(x, y); 
    rotate(rotation); // Rotate the triangle
    triangle(-size / 2, size / 2, 0, -size / 2, size / 2, size / 2); // Draw a triangle
    popMatrix(); 
  }

  boolean offscreen() {
    return (y > height);
  }
}
