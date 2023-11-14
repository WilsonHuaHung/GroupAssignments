// Projectile class
class Projectile {
  float x;
  float y;
  float speedX;
  float speedY;
  float size;
  String element;

  Projectile(float x, float y, float speedX, float speedY, String element) {
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
    this.size = 10; // Adjust the size as needed
    this.element = element;
  }
  
  void update() {
    x += speedX;
    y += speedY;
  }

  void display() {
    if (element.equals("fire")) {
      fill(255, 0, 0); // Red for fire element
    } else if (element.equals("water")) {
      fill(0, 0, 255); // Blue for water element
    } else if (element.equals("earth")) {
      fill(139, 69, 19); // Brown for earth element
    } else if (element.equals("air")) {
      fill(192); // Light grey for air element
    } else {
      fill(255); // Default color
    }

    ellipse(x, y, size, size);
  }

  boolean offscreen() {
    return (y < 0 || y > height);
  }

  boolean hits(FireEnemy enemy) {
    float distance = dist(x, y, enemy.x, enemy.y);
    return distance < size / 2 + enemy.size / 2;
  }

  boolean hits(WaterEnemy enemy) {
    float distance = dist(x, y, enemy.x, enemy.y);
    return distance < size / 2 + enemy.size / 2;
  }
}

// FireProjectile class
class FireProjectile extends Projectile {
  FireProjectile(float startX, float startY) {
    super(startX, startY, 8, -1, "fire");
  }

  // Other methods (update, display, offscreen) go here
}

// WaterProjectile class
class WaterProjectile extends Projectile {
  WaterProjectile(float startX, float startY) {
    super(startX, startY, 5, -1, "water");
  }

  // Other methods (update, display, offscreen) go here
}

// EarthProjectile class
class EarthProjectile extends Projectile {
  EarthProjectile(float startX, float startY) {
    super(startX, startY, 5, -1, "earth");
  }

  // Other methods (update, display, offscreen) go here
}

// AirProjectile class
class AirProjectile extends Projectile {
  AirProjectile(float startX, float startY) {
    super(startX, startY, 10, -1, "air");
  }

  // Other methods (update, display, offscreen) go here
}
