// Water.pde
class Water extends Particle {
  Water(float x, float y, float z) {
    super(x, y, z);
    // Customize behavior and appearance for water particles
  }

  void update() {
    // Custom update for water: Apply gravity
    velocity.add(0, 0.2, 0); // Adjust the gravity strength as needed
    position.add(velocity);
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(0, 0, 255, 100); // Blue with transparency
    noStroke();
    sphere(10); // Visual representation of the particle
    popMatrix();
  }
}
