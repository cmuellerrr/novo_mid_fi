/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

import processing.video.*;
import org.json.*;
import java.util.Map;
import java.util.HashMap;


Capture cam;
Map<Character, Integer> globalTransitions;
Map<Integer, Screen> screenMap;
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
    globalTransitions = new HashMap<Character, Integer>();
    screenMap = new HashMap<Integer, Screen>();
    
    JSON json = JSON.load(dataPath("proto.json"));
    
    //for each global transition
    JSON global = json.getArray("global");
    for (int i = 0; i < global.length(); i++) {
      JSON obj = global.getJSON(i);
       globalTransitions.put(obj.getString("key").charAt(0), obj.getInt("id")); 
    }
    
    //for each screen
    JSON screens = json.getArray("screens");
    for (int i = 0; i < screens.length(); i++) {
      JSON obj = screens.getJSON(i);
       screenMap.put(obj.getInt("id"), new Screen(obj, this)); 
    }
    
    //set the starting image
    curScreen = screenMap.get(json.getInt("start"));
}

void keyPressed() {
    if (globalTransitions.containsKey(key)) {
        curScreen = screenMap.get(globalTransitions.get(key));
    } else if (curScreen.transitions.containsKey(key)) {
        curScreen = screenMap.get(curScreen.transitions.get(key)); 
    } 
}

