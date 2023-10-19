Shuriken shuriken1;
Shuriken shuriken2;
Kunai kunai1;
Kunai kunai2;
Sword sword1;
Sword sword2;
int backgroundColor;

void setup(){
  size(800, 600);

  // Initialize shuriken
  shuriken1 = new Shuriken(color(0, 255, 0));
  shuriken2 = new Shuriken(color(0, 0, 255));
  //size(800, 600);
  
  // Initialize kunai using Kunai class
  kunai1 = new Kunai(color(0, 0, 0), 10);
  kunai2 = new Kunai(color(200, 0, 0), 10);
  
  // Initialize swords
  sword1 = new Sword(color(100));
  sword2 = new Sword(color(100));
  backgroundColor = color(255);
  frameRate(60);
}

void draw() {
  backdrop();
  
  // Update shuriken
  shuriken1.update();
  shuriken1.display();

  shuriken2.update();
  shuriken2.display();
  
  // Update kunai position and display
  kunai1.update();
  kunai1.display();
  
  kunai2.update();
  kunai2.display();
  
  sword1.update();
  sword1.display();
    
  sword2.update();
  sword2.display();
}

void backdrop() {
  background(0, 150, 255); 
  // grass
  fill(0, 255, 0);
  float grassHeight = 300; // Adjust the height of the grass
  rect(0, height, 2000, grassHeight);
  float rightCornerX = width - 200; // Adjust the x-coordinate
  float rightCornerY = height - 200; // Adjust the y-coordinate
  
  // Draw the ellipse in the right corner
  fill(0);
  rect(450, 400, 20, 300);
  ellipse(450, 300, 200, 200);
  fill(255, 0, 0);
  ellipse(450, 300, 150, 150); // Radius of 100 is equivalent to a diameter of 200
  fill(0);
  ellipse(450, 300, 75, 75);
  fill(255, 255, 0); 
  ellipse(450, 300, 45, 45);
  fill(0);
  
}
