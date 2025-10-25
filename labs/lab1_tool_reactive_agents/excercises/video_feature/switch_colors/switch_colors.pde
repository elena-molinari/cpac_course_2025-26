import processing.video.*;

Capture cam;
int index_cam=0;
void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i, cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[index_cam]);
    cam.start();
    
  }
  
}

void copy2img(Capture camera, PImage img) {
  img.loadPixels();
  for (int i=0; i<camera.width*camera.height; i++) {
    img.pixels[i]=camera.pixels[i];
  }
  img.updatePixels();
}

void changeColors(PImage img){
  img.loadPixels();
  // your code here;
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    // Calculate luminance using weighted average
    float gray = 0.299*r + 0.587*g + 0.114*b;
    
    img.pixels[i] = color(gray);
  }
  img.updatePixels();  
}
void mirrorImage(PImage img){
  img.loadPixels();
  
  int w = img.width;
  int h = img.height;
  
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w / 2; x++) {
      int leftIndex = x + y * w;
      int rightIndex = (w - 1 - x) + y * w;
      
      // Swap pixels
      color temp = img.pixels[leftIndex];
      img.pixels[leftIndex] = img.pixels[rightIndex];
      img.pixels[rightIndex] = temp;
    }
  }
  
  img.updatePixels();
}

void draw() {
  if (! cam.available()) {return;}
  cam.read();
  PImage img=createImage(cam.width,cam.height,RGB);
  copy2img(cam, img);
  changeColors(img);
  mirrorImage(img);
  if(img.width>0){
    image(img, 0, 0);
  }

}
