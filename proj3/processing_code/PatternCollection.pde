/**
* Pattern Collection class
**/
class PatternCollection{
  ArrayList<Pattern> patterns;
  ArrayList<String> previewURLs;
  HashMap<String, Integer> name_numContributions;
  HashMap<String, String> name_profileURL;
  int collectionSize;
  
  /**
  * Default constructor
  **/
  PatternCollection(){
    this.patterns = new ArrayList<Pattern>();
    this.previewURLs = new ArrayList<String>();
    this.name_numContributions = new HashMap<String, Integer>();
    this.name_profileURL = new HashMap<String, String>();
    this.collectionSize = 0;
  }
  
  void addPatternToCollection(Pattern p){
    this.patterns.add(p);
    String previewURL = p.getPreviewURL();
    this.previewURLs.add(previewURL);
    String name = p.getContributorName();
    int numContributions = this.name_numContributions.getOrDefault(name, 0) + 1;
    this.name_numContributions.put(name, numContributions);
    this.name_profileURL.put(name, p.getContributorURL());
    this.collectionSize =  patterns.size();
  }
  
  int getSize(){
    return this.collectionSize;
  }
  
  HashMap<String, Integer> getNameNumPairs(){
    return this.name_numContributions;
  }
  
  ArrayList<String> getPreviewList(){
    return this.previewURLs;
  }
  
  String getProfileURL(String contributor_name){
    return this.name_profileURL.getOrDefault(contributor_name, "x");
  }
  
  
  
}
