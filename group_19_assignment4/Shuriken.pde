class Shuriken {
  color starColor;
  float x, y;
  float speedX, speedY;
  float rotationAngle;
  float scaleValue;

  Shuriken(color starColor) {
    this.starColor = starColor;
    this.x = random(width);
    this.y = random(height);
    this.speedX = random(1, 3);
    this.speedY = random(1, 3);
    this.rotationAngle = 0;
    this.scaleValue = random(0.5, 2.0); // Random initial scale
  }

  void update() {
    // Update shuriken position
    x += speedX;
    y += speedY;

    // Check for collisions with screen edges
    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }

    // Update rotation angle to make the shuriken spin
    rotationAngle += 0.05; // Adjust the rotation speed as needed

    // Update scale value
    scaleValue += random(-0.01, 0.01); // Random scale change
    scaleValue = constrain(scaleValue, 0.5, 2.0); // Limit scale value
  }

  void display() {
    // Draw the shuriken with rotation, scaling, and color
    pushMatrix();
    translate(x, y);
    rotate(rotationAngle); // Apply rotation
    scale(scaleValue); // Apply scaling
  
    noStroke();
  
    float angleIncrement = TWO_PI / 6; // Six blades for a shuriken
    float outerRadius = 40;
    float innerRadius = 10; // Smaller inner radius
  
    // Draw the black blades
    fill(0); // Black color for blades
    beginShape();
    for (float angle = 0; angle < TWO_PI; angle += angleIncrement) {
      float x1 = cos(angle) * outerRadius;
      float y1 = sin(angle) * outerRadius;
      vertex(x1, y1);
  
      float x2 = cos(angle + angleIncrement / 2) * innerRadius;
      float y2 = sin(angle + angleIncrement / 2) * innerRadius;
      vertex(x2, y2);
    }
    endShape(CLOSE);
  
    // Draw the gray outline for blades
    stroke(150); // Gray outline color
    strokeWeight(2);
    noFill();
    beginShape();
    for (float angle = 0; angle < TWO_PI; angle += angleIncrement) {
      float x1 = cos(angle) * outerRadius;
      float y1 = sin(angle) * outerRadius;
      vertex(x1, y1);
  
      float x2 = cos(angle + angleIncrement / 2) * innerRadius;
      float y2 = sin(angle + angleIncrement / 2) * innerRadius;
      vertex(x2, y2);
    }
    endShape(CLOSE);
  
    // Draw the smaller white circle in the center
    fill(255); // White color
    ellipse(0, 0, innerRadius * 2, innerRadius * 2);
  
    popMatrix(); // Restore transformation
  }
}
