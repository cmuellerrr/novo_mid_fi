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

  void addTransition(char c, int i) {
     transitions.put(c, i);
  }
  
  
}
