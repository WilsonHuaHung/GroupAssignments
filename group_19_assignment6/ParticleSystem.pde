// ParticleSystem.pde
class ParticleSystem {
  ArrayList<Particle> particles;
  
  ParticleSystem(int numParticles) {
    particles = new ArrayList<Particle>();
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Fire(0, 0, 0)); // Initially, use Fire particles
    }
  }
  
  void addParticles(int numToAdd, float x, float y, float z, String type) {
    for (int i = 0; i < numToAdd; i++) {
      if (type.equals("Fire")) {
        particles.add(new Fire(x, y, z));
      } else if (type.equals("Wind")) {
        particles.add(new Wind(x, y, z));
      } else if (type.equals("Water")) {
        particles.add(new Water(x, y, z));
      }
    }
  }
  
  void run() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      p.display();
    }
  }
}
