class Star {
  PVector position;
  float size;
  PVector velocity;

  Star() {
    // Initialize the star's properties
    position = new PVector(random(width), random(height), random(-1000, -100));
    size = random(1, 5); // You can adjust the size range as needed
    velocity = new PVector(0, 0, random(1, 5)); // Adjust speed as needed
  }

  void update() {
    // Update the star's position based on its velocity
    position.add(velocity);

    // If the star goes off-screen, reset its position to a new random location
    if (position.z > 0) {
      position = new PVector(random(width), random(height), random(-1000, -100));
    }
  }

  void display() {
    // Draw the star as a point in 3D space
    pushMatrix();
    translate(position.x, position.y, position.z);
    stroke(255); // You can change the star's color as desired
    strokeWeight(size);
    point(0, 0);
    popMatrix();
  }
}
