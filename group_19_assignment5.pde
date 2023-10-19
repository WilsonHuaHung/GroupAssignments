// test 
PImage space;
Ship ship;
Star[] stars = new Star[200]; // Adjust the number of stars as needed

void setup() {
  size(1200, 673, P3D);
  space = loadImage("space.jpg"); // Replace with your space background image
  ship = new Ship(-300, height * 3 / 4);

  // Create the Star objects
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  background(space); // Use the space image as the background

  // Update and display the stars
  for (Star star : stars) {
    star.update();
    star.display();
  }

  // Update and display the ship
  ship.update();
  ship.display();
}
