class Projectile {
  float x;
  float y;
  float speedX;
  float speedY;
  float size; // Adjust the size of the projectile
  String element;
  float playerX; // Added parameter for player's x position

  Projectile(float playerX, float startY, float speedX, float speedY, String element) {
    this.x = playerX; // Set initial x position to player's x position
    this.y = startY;
    this.speedX = speedX;
    this.speedY = speedY;
    this.size = 20; // Adjust the size as needed
    this.element = element;
    this.playerX = playerX;
  }

  void update() {
    x += speedX;
    y += speedY;
  }

  void display() {
    if (element.equals("fire")) {
    } else if (element.equals("water")) {
      fill(0, 0, 255); // Blue for water element
    } else if (element.equals("earth")) {
      fill(139, 69, 19); // Brown for earth element
    } else if (element.equals("air")) {
    } else {
      fill(255); // Default color
    }
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

class FireProjectile extends Projectile {
  FireProjectile(float playerX, float startY) {
    super(playerX, startY, 0, -8, "fire");
  }
  
  void display() {
    // Customize the drawing for the fire projectile
    float halfSize = size / 2;
    float quarterSize = size / 4;

    // Draw a custom shape (e.g., a flame)
    fill(255, 0, 0); // Red color for fire element
    beginShape();
    vertex(x, y - halfSize); // Top point
    bezierVertex(x - quarterSize, y - size, x - quarterSize / 2, y - size, x, y - quarterSize); // Left top flame
    bezierVertex(x + quarterSize / 2, y - size, x + quarterSize, y - size, x, y - halfSize); // Right top flame
    vertex(x - quarterSize, y + halfSize); // Bottom-left point
    vertex(x, y + quarterSize); // Middle-bottom point
    vertex(x + quarterSize, y + halfSize); // Bottom-right point
    bezierVertex(x + quarterSize / 2, y, x + quarterSize / 2, y, x, y + quarterSize); // Right bottom flame
    bezierVertex(x - quarterSize / 2, y, x - quarterSize / 2, y, x, y + quarterSize); // Left bottom flame
    endShape(CLOSE);
  }
}

class WaterProjectile extends Projectile {
  WaterProjectile(float playerX, float startY) {
    super(playerX, startY, 0, -3, "water");
  }

  void display() {
    // Customize the drawing for the water projectile
    float halfSize = size / 2;
    float quarterSize = size / 4;

    // Draw a modified bloopy and doopy shape for water
    fill(0, 0, 255); // Blue color for water element
    beginShape();
    vertex(x - quarterSize, y - halfSize); // Top-left point
    bezierVertex(x - quarterSize, y - halfSize, x, y - quarterSize, x + quarterSize, y - halfSize); // Top curve
    bezierVertex(x + quarterSize, y - halfSize, x, y + quarterSize, x - quarterSize, y - halfSize); // Bottom curve
    endShape();
  }
}

class EarthProjectile extends Projectile {
  EarthProjectile(float playerX, float startY) {
    super(playerX, startY, 0, -2, "earth");
    size = 50;  // Adjust the size as needed

  }


  void display() {
    // Customize the drawing for the earth projectile
    float halfSize = size / 2;
    float quarterSize = size / 4;

    // Draw a rocky shape for earth
    fill(139, 69, 19); // Brown color for earth element
    beginShape();
    vertex(x, y - halfSize); // Top point
    vertex(x - quarterSize, y - quarterSize); // Top-left point
    vertex(x, y + quarterSize); // Middle-bottom point
    vertex(x + quarterSize, y - quarterSize); // Top-right point
    endShape(CLOSE);
  }
}

class AirProjectile extends Projectile {
  AirProjectile(float playerX, float startY) {
    super(playerX, startY, 0, -15, "air");
  }
  
  void display() {
    // Customize the drawing for the fire projectile
    float halfSize = size / 2;
    float quarterSize = size / 4;
  
    // Draw a custom shape (e.g., a flame)
    fill(255); // Red color for fire element
    beginShape();
    vertex(x, y - halfSize); // Top point
    vertex(x - quarterSize, y + halfSize); // Bottom-left point
    vertex(x, y + quarterSize); // Middle-bottom point
    vertex(x + quarterSize, y + halfSize); // Bottom-right point
    endShape(CLOSE);
  }

}
