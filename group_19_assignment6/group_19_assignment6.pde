ParticleSystem particleSystem;
String currentParticleType = "Fire"; // Initially, display Fire particles

void setup() {
  size(800, 600, P3D);
  frameRate(60);
  particleSystem = new ParticleSystem(100); // Number of particles
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  particleSystem.run();
}

void keyPressed() {
  if (key == '1') {
    currentParticleType = "Fire";
  } else if (key == '2') {
    currentParticleType = "Water";
  } else if (key == '3') {
    currentParticleType = "Wind";
  }
}

void mousePressed() {
  float x = mouseX - width / 2;
  float y = mouseY - height / 2;
  particleSystem.addParticles(10, x, y, 0, currentParticleType);
}
