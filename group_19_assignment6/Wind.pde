class Wind extends Particle {
  float[] trailX = new float[60]; // Increase trail length
  float[] trailY = new float[60]; // Increase trail length
  int trailIndex = 0;

  Wind(float x, float y, float z) {
    super(x, y, z);
    // Customize behavior and appearance for wind particles
  }

  void applyForce(float x, float y, float z) {
    // Custom force for wind: Apply the force directly
    PVector force = new PVector(x, y, z);
    force.mult(0.05); // Adjust the strength as needed
    acceleration.add(force);
  }

  void update() {
    // Custom update for wind: Create a swirling, string-like motion
    velocity.add(acceleration);

    // Introduce rotation for a swirling effect
    PVector rotation = new PVector(0, 0, 0.02); // Adjust the rotation speed
    velocity.add(rotation);

    position.add(velocity);
    acceleration.mult(0); // Reset acceleration

    // Store the position for the trail effect
    trailX[trailIndex] = position.x;
    trailY[trailIndex] = position.y;
    trailIndex = (trailIndex + 1) % trailX.length;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(192, 192, 192); // Grey
    noStroke();

    // Create a swirling, string-like appearance
    beginShape();
    for (int i = 0; i < trailX.length; i++) {
      float x = trailX[i];
      float y = trailY[i];
      vertex(x, y);
    }
    endShape();

    popMatrix();
  }
}
