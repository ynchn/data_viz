/**
* Record class
* Given a book's check-out and check-in records and related information from the CSV,
* creates a Record object.
**/
class Record{
  String title;
  String cout;
  String cin;
  int timeOutside;
  String artform;
  
  int coutYear = 0;
  int coutMonth = 0;
  int coutDay = 0;
  int cinYear = 0;
  int cinMonth = 0;
  int cinDay = 0;
  
  /**
  * Record class constructor
  */
  Record(String title, String cout, String cin, int timeOutside, String artform){
    this.title = title;
    this.cout = cout;
    this.cin = cin;
    this.timeOutside = timeOutside;
    this.artform = artform;
  }
  
  int[] getYMD(String rawDate){
    String[] splitDate = split(rawDate, '-');
    int parsedYear = int(splitDate[0]);
    int parsedMonth = int(splitDate[1]);
    // split date 3rd element includes <day, ' ', time>
    int parsedDay = int(split(splitDate[2], ' ')[0]); //split again to get rid of time
    //int parsedDay = int(splitDate[2]);
    int[] parsedYMD = {parsedYear, parsedMonth, parsedDay};
    return parsedYMD;
  }
  
  /**
  * Returns an integer array containing parsed checkout year, month, and day
  */
  int[] getCoutYMD(){
    return getYMD(this.cout);
  }
  
  /**
  * Calculate and assign integer checkout year, month, and day values to the Record object
  */
  void calcCoutYMD(){
    int[] coutYMD = getYMD(this.cout);
    this.coutYear = coutYMD[0];
    this.coutMonth = coutYMD[1];
    this.coutDay = coutYMD[2];
  }
  
  /**
  * getters for checkout dates
  */
  int getCoutYear(){
    return this.coutYear;
  }
  int getCoutMonth(){
    return this.coutMonth;
  }
  int getCoutDay(){
    return this.coutDay;
  }
  
  /**
  * Returns an integer array containing parsed checkin year, month, and day
  */
  int[] getCinYMD(){
    return getYMD(this.cin);
  }
  
  /**
  * Calculate and assign integer checkin year, month, and day values to the Record object
  */
  void calcCinYMD(){
    int[] cinYMD = getYMD(this.cin);
    this.cinYear = cinYMD[0];
    this.cinMonth = cinYMD[1];
    this.cinDay = cinYMD[2];
  }
  
  /**
  * getters for checkin dates
  */
  int getCinYear(){
    return this.cinYear;
  }
  int getCinMonth(){
    return this.cinMonth;
  }
  int getCinDay(){
    return this.cinDay;
  }
  
  /**
  * Return the time this Record spent outside the SPL
  */
  int getTimeOutsideLibrary(){
    return this.timeOutside;
  }
  
  /**
  * Return the artform of this Record
  */
  String getArtform(){
    return this.artform;
  }
  
  /**
  * Return the artform of this Record
  */
  String getTitle(){
    return this.title;
  }

}
