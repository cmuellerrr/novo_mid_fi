/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

import processing.video.*;
import org.json.*;

Capture cam;
PImage[] images;
int pointer;

void setup() {
  size(640, 480);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, cameras[0]);
    
    // Start capturing the images from the camera
    cam.start();
  }
  
  setupScreens();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  set(0, 0, cam);
  image(images[pointer], 0, 0);
}

void setupScreens() {
  images = new PImage[4];
  
  for (int i = 0; i < 4; i++) {
     images[i] = loadImage("proto_"+ (i+1) + ".png");
  }
  pointer = 0;
  
  //JSON json = JSON.load(dataPath("data.json"));
}

void keyPressed() {
  try{
    int k = key-48;
    if (k > 0 && k <= 4) pointer = k-1;        
  } catch (Exception e) {
   
  }
}
