
class Animation {
  PImage[] frames;
  int currentFrame;
  int frameRate; // How fast the animation cycles through frames
  int frameDuration; // Duration of each frame in the animation
  float lastFrameTime;

  // Adjusted constructor to match the required signature
  Animation(String[] filenames, int rate, int duration) {
    frames = new PImage[filenames.length];
    for (int i = 0; i < filenames.length; i++) {
      frames[i] = loadImage(filenames[i]);
    }
    currentFrame = 0;
    frameRate = rate;
    frameDuration = duration;
    lastFrameTime = millis();
  }

  void update() {
    if (millis() - lastFrameTime > 1000 / frameRate * frameDuration) {
      currentFrame = (currentFrame + 1) % frames.length;
      lastFrameTime = millis();
    }
  }

  void display(float x, float y) {
    image(frames[currentFrame], x - frames[currentFrame].width / 2, y - frames[currentFrame].height / 2);
  }
}
