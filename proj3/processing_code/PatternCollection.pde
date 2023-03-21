/**
* Pattern Collection class
**/
class PatternCollection{
  ArrayList<Pattern> patterns;
  ArrayList<String> previewURLs;
  HashMap<String, Integer> name_numContributions;
  int collectionSize;
  
  /**
  * Default constructor
  **/
  PatternCollection(){
    this.patterns = new ArrayList<Pattern>();
    this.previewURLs = new ArrayList<String>();
    this.name_numContributions = new HashMap<String, Integer>();
    this.collectionSize = 0;
  }
  
  void addPatternToCollection(Pattern p){
    this.patterns.add(p);
    String url = p.getPreviewURL();
    this.previewURLs.add(url);
    String name = p.getContributorName();
    int numContributions = this.name_numContributions.getOrDefault(name, 0) + 1;
    this.name_numContributions.put(name, numContributions);
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
  
  
  
  
}
