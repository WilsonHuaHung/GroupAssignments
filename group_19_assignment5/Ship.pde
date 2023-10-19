class Ship {
  PShape ship;
  float x, y;

  Ship(float startX, float startY) {
    x = startX;
    y = startY;
    ship = createShip();
  }

  void update() {
    // Move the ship from left to right
    x += 2;
    if (x > width + 300) { // Reset the ship's position when it goes off-screen
      x = -300;
    }
  }

  void display() {
    // Set the position of the ship
    translate(x, y, 0);

    // Apply rotation to the ship
    rotateY(frameCount * 0.01); // Rotate the ship around the Y-axis

    // Display the rotating ship
    shape(ship);
  }

  PShape createShip() {
    PShape ship = createShape(GROUP);

    // Create the base of the ship (box) and make it grey
    PShape base = createShape(BOX, 200, 50, 50);
    base.setFill(color(128)); // Grey color for the ship base

    // Create the pole on top of the base (box) and make it grey
    PShape pole = createShape(BOX, 20, 200, 20); // Adjust dimensions
    pole.setFill(color(128)); // Grey color for the pole

    // Position the pole above the base
    pole.translate(0, -125, 0);

    // Create the flag using rectangles and make it grey
    PShape flag = createShape(GROUP);
    flag.setFill(color(128)); // Grey color for the flag

    // Vertical rectangle (flag pole)
    PShape flagPole = createShape(BOX, 20, 240, 20); // Adjust dimensions for a taller pole
    flag.addChild(flagPole);

    // Horizontal rectangle (flag) - Larger flag
    PShape flagShape = createShape(BOX, 300, 60, 20); // Adjust dimensions for a larger flag
    flag.addChild(flagShape);
    flagShape.translate(0, -180, 0); // Position the flag on top of the pole

    // Add the base, pole, and flag to the ship group
    ship.addChild(base);
    ship.addChild(pole);
    ship.addChild(flag);

    return ship;
  }
}
