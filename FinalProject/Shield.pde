class Shield {
    float x;
    float y;
    float size;
    String element;
    boolean active; // Flag to track if the shield is active
    float getRadius() {
      return size / 2; // adjust based on Shield class implementation
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
      if (active) {
        float distance = dist(x, y, enemy.x, enemy.y);
        return distance < getRadius() + enemy.size / 2;
      }
      return false;
    }
    
    boolean hits(WaterEnemy enemy) {
      if (active) {
        float distance = dist(x, y, enemy.x, enemy.y);
        return distance < getRadius() + enemy.size / 2;
      }
      return false;
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
        System.out.println("Shield deactivated");

      }
    
    
    void drawFireShield() {
        fill(255, 0, 0, 100); // Red color with transparency
        ellipse(x, y, size * 2, size * 2);
    }

    void drawWaterShield() {
        fill(0, 0, 255, 100); // Blue color with transparency
        ellipse(x, y, size * 2, size * 2);
    }

    void drawEarthShield() {
        fill(139, 69, 19, 100); // Brown color with transparency
        rectMode(CENTER);
        rect(x, y, size * 2, size * 2);
        rectMode(CORNER); // Reset rectMode to default
    }

    void drawAirShield() {
        fill(192, 100); // Light grey color with transparency
        ellipse(x, y, size * 2, size * 2);
    }
}
