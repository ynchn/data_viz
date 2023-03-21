/**
* Pattern class
**/
class Pattern{
  int id;
  String pattern_url;
  String preview_url;
  String preview_url2;
  String preview_url3;
  int cols;
  int rows;
  int num_strings;
  int num_colors;
  String contributor_name;
  String contributor_url;
  
  Triple coord_t;
  
  /**
  * Pattern class constructor
  */
  Pattern(TableRow row){
    this.id = row.getInt("id");
    this.pattern_url = row.getString("pattern_url");
    this.preview_url = row.getString("preview_url");
    this.preview_url2 = row.getString("preview_url2");
    this.preview_url3 = row.getString("preview_url3");
    this.cols = row.getInt("cols");
    this.rows = row.getInt("rows");
    this.num_strings = row.getInt("num_strings"); 
    this.num_colors = row.getInt("num_colors");
    this.contributor_name = row.getString("contributor_name");
    this.contributor_url =row.getString("contributor_url");
    
    this.coord_t = new Triple(this.num_strings, this.num_colors, this.rows);
  }

  Triple getCoordinateTriple(){
    return this.coord_t;
  }
  
  String getContributorName(){
    return this.contributor_name;
  }
  
  String getContributorURL(){
    return this.contributor_url;
  }
  
  String getPreviewURL(){
    return this.preview_url3;
  }
  

}
