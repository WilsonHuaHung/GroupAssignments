// Fire.pde
class Fire extends Particle {
  Fire(float x, float y, float z) {
    super(x, y, z);
    // Customize behavior and appearance for fire particles
  }

  void applyForce(float x, float y, float z) {
    // Custom force for fire: It pushes particles upward
    PVector force = new PVector(x, y, z);
    force.mult(0.05); // Adjust the strength as needed
    acceleration.add(force);
  }

  void update() {
    // Custom update for fire: Add randomness to the upward movement
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0); // Reset acceleration
    velocity.add(PVector.random3D()); // Add random movement
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(255, 0, 0, 200); // Red with transparency
    noStroke();
    sphere(10); // Visual representation of the particle
    popMatrix();
  }
}
