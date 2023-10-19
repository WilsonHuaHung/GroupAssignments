// Particle.pde
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  Particle(float x, float y, float z) {
    position = new PVector(x, y, z);
    velocity = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0.05, 0);
  }
  
  void applyForce(float x, float y, float z) {
    // Apply external forces to the particle
    PVector force = new PVector(x, y, z);
    acceleration.add(force);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);  // Reset acceleration
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(255, 150);
    noStroke();
    sphere(10);  // Visual representation of the particle
    popMatrix();
  }
}
