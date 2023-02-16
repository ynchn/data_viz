// Flat Weave
// draws a year as a square, each line is a month
void drawYearSquare(int year){
  int febDays = 28;
  if (year % 4 == 0){
    febDays = 29;
  }
  int numDays;
  for (int i = 0; i < 12; i++){
    if (i == 1) {
      //numDays = 28; // Feb
      numDays = febDays;
    }
    else if ((i <= 6 && i % 2 == 0) || (i > 6 && i % 2 == 1)){
      numDays = 31;
    }
    else {
      numDays = 30;
    }
    
    translate(0, 0, 10);
    drawMonthAxis(numDays);
  }
}

// draw days in a month in 1 line
void drawMonthAxis(int days){
    int incr = 0;
    stroke(0);
    strokeWeight(2);
    for (int j = 0; j < days; j++){
      point(incr, 0, 0);
      incr += 10;
    }
}


// each entire year in a single line
void drawYearAxis(int year){
  int febDays = 28;
  if (year % 4 == 0){
    febDays = 29;
  }
  int numDays;
  int incr = 0;
  for (int i = 0; i < 12; i++){
    if (i == 1) {
      //numDays = 28; // Feb
      numDays = febDays;
    }
    else if ((i <= 6 && i % 2 == 0) || (i > 6 && i % 2 == 1)){
      numDays = 31;
    }
    else {
      numDays = 30;
    }
    
    strokeWeight(2);
    for (int j = 0; j < numDays; j++){
      point(incr, 0, 0);
      incr += 10;
    }
  }
  //println(incr); // 3650

}
