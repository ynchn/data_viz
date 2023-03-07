/**
* Spindle Geometry
* This is not used in the final visualization
**/
// wrapper for each year disc
void drawYearDisc(int year){
  translate(0, 0, 80);
  noFill();
  //strokeWeight(0.5);
  //circle(0, 0, 100);
  pushMatrix();
  drawMonthLines(year);
  popMatrix();
}

// draw 12 lines => 1 disc
void drawMonthLines(int year){
  int dayInnerY = 40;
  int febDays = 28;
  if (year % 4 == 0){
    febDays = 29;
  }
  int numDays;
  for (int i = 0; i < 12; i++){
    rotate(PI/6.0);
    int incr = 0;
    
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
      point(0, dayInnerY + incr, 0);
      // ----------
      // text blurry??????
      //if (year == 2005){
      //  String dayString = Integer.toString(j + 1);
      //  //textMode(SHAPE);
      //  textFont(arial);
      //  textSize(5);
      //  text(dayString, 0, dayInnerY + incr, 0);
      //}
      // ----------
      incr += 10;
    }

  }
}
