//import
import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.video.*;
import processing.opengl.*;

//instance
Minim minim;
AudioInput in;
Capture capture;
FFT fft;
BeatDetect beat;

void setup() {
  
  //set up general settings
  size(displayWidth, displayHeight,OPENGL);
  
  //set up minim
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 1024);
  
  //set up fft
  fft = new FFT(in.bufferSize(), in.sampleRate());
  
  //set up beat detect
  beat = new BeatDetect();
  beat.detectMode(beat.SOUND_ENERGY);
  
  //set up cameras
  String[] cameras = Capture.list();
  capture = new Capture(this, cameras[0]);
  capture.start();
  frameRate(30);
  
  //set up view options
  smooth();
  noStroke();
  noCursor();
}

void draw() {
  background(0);
  capture.loadPixels();
  int d = 10;
  for(int y = d/2; y<capture.height; y+=d) {
    for(int x = d/2; x<capture.width; x+=d) {
      int pixelColor = capture.pixels[y * capture.width + x];
      int r = (pixelColor >> 16) & 0xff;
      int g = (pixelColor >> 8 ) & 0xff;
      int b = pixelColor & 0xff;
      fill(r,g,b);
      ellipse(x, y, d, d);
    }
  }
  if(capture.available()) {
    capture.read();
  }
}
