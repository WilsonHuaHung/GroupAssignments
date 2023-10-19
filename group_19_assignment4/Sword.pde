class Sword {
  color swordColor;
  float x, y;
  float speedX, speedY;
  float rotationAngle;
  float scaleValue;

  Sword(color swordColor) { 
    this.swordColor = swordColor; 
    this.x = random(width);
    this.y = random(height);
    this.speedX = random(1, 4); // Use the same speedX as in Shuriken
    this.speedY = random(1, 4); // Use the same speedY as in Shuriken
    this.rotationAngle = 0;
    this.scaleValue = random(0.5, 0.8); 
  }

  void update() {
    // update sword position
    x += speedX;
    y += speedY;

    // collisions with screen edges
    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }

    // Update rotation angle to make the sword spin
    rotationAngle += 0.02; // Adjust the rotation speed as needed

    // Update scale value
    scaleValue += random(-0.01, 0.01); // Random scale change
    scaleValue = constrain(scaleValue, 0.5, 2.0); // Limit scale value
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotationAngle); 
    scale(scaleValue);
    noStroke();

    // Original sword shape
    stroke(0); 
    strokeWeight(2);
    fill(swordColor); 
    quad(100, 100, 300, 100, 325, 125, 25, 125);
    fill(0);
    rect(250, 115, 20, 75);
    popMatrix(); 
  }
}

