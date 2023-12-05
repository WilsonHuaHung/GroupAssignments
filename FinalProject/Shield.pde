class Shield {
    float x;
    float y;
    float size;
    String element;
    boolean active; // Flag to track if the shield is active
    float getRadius() {
      return size / 2; // You may need to adjust this based on your Shield class implementation
    }
    
    Shield(float x, float y, float size, String element) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.element = element;
        this.active = true; // Initialize the shield as active
    }

    void update(float playerX, float playerY) {
      // Update shield position based on the player's position
      this.x = playerX;
      this.y = playerY;
    }

    boolean hits(FireEnemy enemy) {
        float distance = dist(x, y, enemy.x, enemy.y);
        return distance < getRadius() + enemy.size / 2;
    }

    boolean hits(WaterEnemy enemy) {
        float distance = dist(x, y, enemy.x, enemy.y);
        return distance < getRadius() + enemy.size / 2;
    }
    
    
    void display() {
       if (active) {
           if (element.equals("fire")) {
              drawFireShield();
          } else if (element.equals("water")) {
              drawWaterShield();
          } else if (element.equals("earth")) {
              drawEarthShield();
          } else if (element.equals("air")) {
              drawAirShield();
          }
        }
    }

    void deactivate() {
      active = false;
      }
    
    
    void drawFireShield() {
        // Your implementation for the fire shield animation
        fill(255, 0, 0, 100); // Red color with transparency
        ellipse(x, y, size * 2, size * 2);
    }

    void drawWaterShield() {
        // Your implementation for the water shield animation
        fill(0, 0, 255, 100); // Blue color with transparency
        ellipse(x, y, size * 2, size * 2);
    }

    void drawEarthShield() {
        // Your implementation for the earth shield animation
        fill(139, 69, 19, 100); // Brown color with transparency
        rectMode(CENTER);
        rect(x, y, size * 2, size * 2);
        rectMode(CORNER); // Reset rectMode to default
    }

    void drawAirShield() {
        // Your implementation for the air shield animation
        fill(192, 100); // Light grey color with transparency
        ellipse(x, y, size * 2, size * 2);
    }
}
