/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

import processing.video.*;
import org.json.*;

Capture cam;
Map<char, int> gTransitionMap;
Map<int, Screen> transitionMap;
Screen curScreen;

void setup() {
  size(640, 480);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
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
  if (cam.available() == true) cam.read();
  set(0, 0, cam);
  image(curScreen.img, 0, 0);
}

void setupScreens() {  
  JSON json = JSON.load(dataPath("proto.json"));
  
  //for each global transition
  JSONArray global = json.getArray("global");
  for (int i = 0; i < global.length(); i++) {
     JSONObject obj = global.getJSONObj(i);
     gTransitionMap.put(obj.get('key'), obj.get('id')); 
  }
  
  //for each screen
  JSONArray screens = json.getArray("screens");
  for (int i = 0; i < screens.length(); i++) {
     JSONObject obj = screens.getJSONObj(i);
     transitionMap.put(obj.get('id'), new Screen(obj)); 
  }
  
  //set the starting image
}

void keyPressed() {
  if (gTransitionMap.contains(key)) {
      curScreen = transitionMap.get(gTransitionMap.get(key));
  } else if (curScreen.transitions.contains(key)) {
      curScreen = transitionMap.get(curScreen.transitions.get(key)); 
  }
}
