String[] lines;     
float[] frequencies;  
color[] colors;         
void setup() {
  size(700, 600);
  background(255);
  lines = loadStrings("wordfrequency.txt");
  
  if (lines != null) {
    frequencies = new float[lines.length];
    // create a new color for each frequency 
    colors = new color[lines.length];
    
    // parse through all of wordfrequency.txt and count how many different words are listed
    float total = 0;
    for (int i = 0; i < lines.length; i++) {
      String[] parts = split(lines[i], ':');
      frequencies[i] = float(trim(parts[1]));
      total += frequencies[i];
    }
    
    // assign colors randomly in red hues
    for (int i = 0; i < lines.length; i++) {
      colors[i] = color(random(255), 0,0);
    }
    
    // Pie chart
    ///initalize starting angle to 0 degress
    float startAngle = 0;
    // iterate through the lines of wordfrequency.txt
    for (int i = 0; i < lines.length; i++) {
      // map = (freqeuncy value, min value for map, total amount of frequencys, min angle, full circle)
      float angle = map(frequencies[i], 0, total, 0, TWO_PI);
      fill(colors[i]);
      // set x/y cord middle of screen as the center of arc, width/height pie chart 
      arc(width/2, height/2, 400, 400, startAngle, startAngle + angle);
      // keep 'angle' value added until circle is full 
      startAngle += angle;
    }
  }
}

void draw() {
  // nothing needed here rn 
}
