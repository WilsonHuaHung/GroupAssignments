class Kunai {
  color kunaiColor;
  float x, y;
  float speedX, speedY;
  float rotationAngle;
  float scaleValue;
  float kunaiSize;

  Kunai(color kunaiColor, float kunaiSize) {
    this.kunaiColor = kunaiColor;
    this.kunaiSize = kunaiSize;
    this.x = random(width);
    this.y = random(height);
    this.speedX = random(1, 3);
    this.speedY = random(1, 3);
    this.rotationAngle = 0;
    this.scaleValue = random(5, 10); // Random initial scale
  }

  void update() {
    // Update kunai position
    x += speedX;
    y += speedY;

    // Check for collisions with screen edges
    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }

    // Update rotation angle to make the kunai spin
    rotationAngle += 0.05; 

    // Update scale value
    scaleValue += random(-0.01, 0.01); // Random scale change
    scaleValue = constrain(scaleValue, 0.5, 2.0); // Limit scale value
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotationAngle);
    scale(scaleValue);
  
    // Handle
    fill(kunaiColor);
    rectMode(CENTER);
    rect(0, 0, kunaiSize * 0.15, kunaiSize * 2.5);
  
    // Ellipse at the bottom of the handle
    ellipse(0, kunaiSize * 1.25, kunaiSize * 0.3, kunaiSize * 0.3);
  
    // Blade
    float bladeLength = kunaiSize * 2.5;
    float bladeWidth = kunaiSize * 0.25;
    fill(kunaiColor);
    triangle(0, -bladeLength, -bladeWidth, 0, bladeWidth, 0);
  
    popMatrix();
  }
}
