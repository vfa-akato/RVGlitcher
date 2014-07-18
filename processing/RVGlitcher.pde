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

// set up Global
PImage img;
int increment=2;
int vvv = 0;

void setup() {
  
  //set up general settings
  //size(displayWidth, displayHeight,OPENGL);
  size(640, 420,OPENGL);
  
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
  vvv++;
  if(vvv%5 != 0) return;
  background(0);
  image(capture,0,0);
  loadPixels();
  for (int x = 0; x < ((width*height)-(increment+2)); x+=increment) {
    quicksort(pixels, x, x+increment);
  }
  updatePixels();
  int d = 10;
  for(int y = d/2; y<height; y+=d) {
    for(int x = d/2; x<width; x+=d) {
      int pixelColor = pixels[y * width + x];
      int r = (pixelColor >> 16) & 0xff;
      int g = (pixelColor >> 8 ) & 0xff;
      int b = pixelColor & 0xff;
      fill(r,g,b);
      ellipse(x, y, d, d);
    }
  }
  glitcher();
  if(capture.available()) {
    capture.read();
  }
}



void glitchIt(int jump) {
  image(capture,0,0);
  loadPixels();
  for (int x = 0; x < ((width*height)-(jump+1)); x+=jump) {
    quicksort(pixels, x, x+jump);
  }
  updatePixels();
}

void glitcher() {
  float x = 2;
  float y = 281;
  int val1 = int((sqrt(x*y))*2);
  glitchIt(val1); 
}

int partition(int x[], int left, int right) {
  int i = left;
  int j = right;
  int temp;
  int pivot = x[(left+right)/2];
  while (i <= j) {
    while (x[i] < pivot) {
      i++;
    }
    while (x[j] > pivot) {
      j--;
    }
    if (i <= j) {
      temp = x[i];
      x[i] = x[j];
      x[j] = temp;
      i++;
      j--;
    }
  }
  return i;
}

void quicksort(int x[], int left, int right) {
  int index = partition(x, left, right);
  if (left < index - 1) {
    quicksort(x, left, index-1);
  }
  if (index < right) {
    quicksort(x, index, right);
  }
}

