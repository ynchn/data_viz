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
  
  String getPreviewURL(){
    return this.preview_url3;
  }
  
  
  ///**
  //* Returns an integer array containing parsed checkout year, month, and day
  //*/
  //int[] getCoutYMD(){
  //  return getYMD(this.cout);
  //}
  
  ///**
  //* Calculate and assign integer checkout year, month, and day values to the Record object
  //*/
  //void calcCoutYMD(){
  //  int[] coutYMD = getYMD(this.cout);
  //  this.coutYear = coutYMD[0];
  //  this.coutMonth = coutYMD[1];
  //  this.coutDay = coutYMD[2];
  //}
  
  ///**
  //* getters for checkout dates
  //*/
  //int getCoutYear(){
  //  return this.coutYear;
  //}
  //int getCoutMonth(){
  //  return this.coutMonth;
  //}
  //int getCoutDay(){
  //  return this.coutDay;
  //}
  
  ///**
  //* Returns an integer array containing parsed checkin year, month, and day
  //*/
  //int[] getCinYMD(){
  //  return getYMD(this.cin);
  //}
  
  ///**
  //* Calculate and assign integer checkin year, month, and day values to the Record object
  //*/
  //void calcCinYMD(){
  //  int[] cinYMD = getYMD(this.cin);
  //  this.cinYear = cinYMD[0];
  //  this.cinMonth = cinYMD[1];
  //  this.cinDay = cinYMD[2];
  //}
  
  ///**
  //* getters for checkin dates
  //*/
  //int getCinYear(){
  //  return this.cinYear;
  //}
  //int getCinMonth(){
  //  return this.cinMonth;
  //}
  //int getCinDay(){
  //  return this.cinDay;
  //}
  
  ///**
  //* Return the time this Record spent outside the SPL
  //*/
  //int getTimeOutsideLibrary(){
  //  return this.timeOutside;
  //}
  
  ///**
  //* Return the artform of this Record
  //*/
  //String getArtform(){
  //  return this.artform;
  //}
  
  ///**
  //* Return the artform of this Record
  //*/
  //String getTitle(){
  //  return this.title;
  //}

}
