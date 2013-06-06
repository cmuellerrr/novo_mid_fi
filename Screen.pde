import org.json.*;

class Screen {
  
  int id;
  String name;
  String url;
  PImage img;
  Map<char, int> transitions;
  
  
  Screen(int id, String name, String url) {
    this.id = id;
    this.name = name;
    this.url = url;
    img = loadImage(url);
    transitions = new HashMap<char, int>();
  }
  
  Screen(JSON json) {
    this.id = json.getInt('id');
    this.name = json.getString('name');
    this.url = json.getString('url');
    img = loadImage(url);
    JSONArray trans = json.getArray('transitions');
    for (int i = 0; i < trans.length(); i++) {
      JSONObject curObj = trans.getJSONObj(i);
      transitions.put(curObj.get('key'), curObj.get('id'));
    }
  }

  void addTransition(char c, int i) {
     transitions.put(c, i);
  }
  
  
}
