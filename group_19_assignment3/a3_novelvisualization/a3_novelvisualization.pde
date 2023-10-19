PFont customFont;  // Font for the word cloud
String[] uniqueWords;  // Array to store unique words from uniquewords.txt
wordData[] randomWords;  // Array to store the current set of random words

void setup() {
  size(700, 600);  // Set canvas size
  background(255);  // White background
  
  // Load unique words from the text file
  uniqueWords = loadStrings("uniquewords.txt");
  
  // Load a custom OTF font
  customFont = createFont("Bonello-Regular.otf", 20);  // Replace with the actual OTF font file and size
  textFont(customFont);  // Set the font for the word cloud
  
  // Generate the initial set of random unique words
  generateRandomWords(200);  // Adjust the number of words as needed
  displayRandomWords();  // Display the initial set of words
}

// class for word info and font sizing
class wordData {
  String word;
  int size;
  wordData(String word, int size) {
    this.word = word;
    this.size = size;
  }
}


void mousePressed() {
  generateRandomWords(200);  //the amount of words display to screen at one time 
  displayRandomWords();  // display the new set of words
}


// "extra credit" for font size randomization
void generateRandomWords(int numWords) {
    randomWords = new wordData[numWords];
  for (int i = 0; i < numWords; i++) {
    int index = int(random(uniqueWords.length));
    String word = uniqueWords[index];
    int size = int(random(8, 40));  // random font size range
    randomWords[i] = new wordData(word, size);
  }
}

void displayRandomWords() {
  // Clear the canvas
  background(255);
  
  // Display the set of random unique words
  float x = 20;  // Initial x-coordinate
  float y = 50;  // Initial y-coordinate
  
  for (wordData wordInfo : randomWords) {
    // Set a random color for each word
    fill(random(50, 200), 0, 0);  // Adjust the color range as needed
    
    // Set the font size for each word
    textSize(wordInfo.size);  // Use the random font size
    
    // Display the word at the current coordinates
    text(wordInfo.word, x, y);
    
    // Update coordinates for the next word
    x += textWidth(wordInfo.word) + 10;  // Adjust horizontal spacing
    
    // Wrap words to the next line if they go beyond the canvas width
    if (x > width - 140) {
      x = 20;
      y += 30;  // Adjust vertical spacing
    }
    
    // Stop drawing if the canvas is filled
    if (y > height - 20) {
      break;
    }
  }
}
void draw() {
  // No need for continuous drawing in this case
}
