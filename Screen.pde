import org.json.*;
import java.util.HashMap;
import java.util.Map;

class Screen {
  
  int id;
  String url;
  PImage img;
  Map<Character, Integer> transitions;
  
  Screen(JSON json, PApplet parent) {
    this.id = json.getInt("id");
    this.url = json.getString("url");
    this.img = parent.loadImage(url);
    this.transitions = new HashMap<Character, Integer>();
    
    JSON trans = json.getArray("transitions");
    for (int i = 0; i < trans.length(); i++) {
      JSON curObj = trans.getJSON(i);
      this.transitions.put(curObj.getString("key").charAt(0), curObj.getInt("id"));
    }
  }
}
