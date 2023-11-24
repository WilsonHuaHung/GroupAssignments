// code inspired by class example of Radio Buttons

class Buttons {
  int x, y;
  int outerRadius, innerRadius;
  color outerColor, innerColor;
  int id;
  Buttons[] buttonGroup;
  boolean isChecked = false;
  
  Buttons(int _x, int _y, int _or, color oc, color ic, int _id, Buttons[] rg) {
    x = _x;
    y = _y;
    outerRadius = _or;
    innerRadius = outerRadius/2;
    outerColor = oc;
    innerColor = ic;
    id = _id;
    buttonGroup = rg;
  }
  
  boolean isPressed(int mx, int my) {
    if (dist(mx, my, x, y) < outerRadius) {
      for (int i = 0; i < buttonGroup.length; i++) {
        if (i != id) {
          buttonGroup[i].isChecked = false;
        } else {
          buttonGroup[i].isChecked = true;
        }
      }
      return true;
    }
    return false;
  }
  
  void display() {
    noStroke();
    fill(outerColor);
    ellipse(x, y, outerRadius*2, outerRadius*2);
    if (isChecked) {
      fill(innerColor);
      ellipse(x, y, innerRadius*2, innerRadius*2);
    }
  }
}
