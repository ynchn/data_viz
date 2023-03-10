/**
* Mat 259 Project 2 - 3D Visualization
* "Crochet and Macrame Check-out Check-in Records Timeline Weave"
*
* A 3D interactive demo that uses peasycam and controlP5, created in Processing 4.1.2
*
* Date: February 21, 2023
* Author: Yanchen Lu
* Instructor: George Legrady
* 
* Usage:
* - GUI:
*   - Use sliders to adjust demo background color and fill color.
*     Fill color changes the look of the timeline and grid geometry.
*   - Use buttons to select and show "Crochet", "Amigurumi", "Macrame", "Friendship Bracelet" books records.
*     The crochet category has a lot of data, so it may be laggy.
*   - Change Date Directions: By default the data is arranged where each rectangle represents a year, from 2005 to 2023 towards the camera,
*     each line represents a month, from January to December towards the camera, and each dot represents a day, from the first day of the
*     month to the last day from left to right.
*     Turning off the button changes the grid to a winding "snake grid", where the direction of how the positions of the days alternate
*     between months. For example, in January, the first day is on the left most side and the last day is on the right most side; in February,
*     the first day is on the right most side and the last day is the left side.
*     This button affects the look of the weave visualization.
*   - Use buttons to turn on/off the grid geometry, checkin/checkout points, checkin/checkout record aggregation points for each day in the timeline.
*   - Use slider to adjust the stroke weight of lines that connect the aggregation points to checkin/checkout points.
*   - Use buttons to zoom in/zoom out, rotate along the x- or y-axis, CCW or CW.
*     You can rotate along an axis, then zoom in, to position the camera at the middle of the timeline.
* - Keyboard:
*   - Press 1 and 2 to rotate around the y-axis.
*   - Press 3 and 4 to rotate around the x-axis.
*   - Press 9 and 0 to zoom in and zoom out.
*   - Use up/down arrows to move camera through months and years.
*   - Use left/right arrows to move camera through days.
* - Mouse:
*   - Double click to reset view.
*   - Left click to rotate.
*   - Right click to zoom.
*   - Middle wheel to zoom, click to drag and move the visualization.
**/

import java.util.*;
import peasy.*;
import controlP5.*;

ControlP5 cp5;
PeasyCam cam;

//screen size and Z depth
int scrX = 1680;
int scrY = 1000;
int scrZ = 2800; //peasycam Z depth


float bgColor = 30;
float fillColor = 140;

PFont yearLabelFont;


// color palette
color cRed = #D56E78;
color cPurple = #C688B9;
color cBlue = #82AEDE;
color cCyan = #2CCDCF;
color cGreen = #6ADF97;
color cYellow = #CFE261;

color cCurve = color(0, 0, 0);


//boolean showSpindle = true;
boolean geometry = true;
// selectors for which artform is shown
boolean makeWeave = false;
boolean showCrochet = false;
boolean showAmigurumi = false;
boolean showMacrame = false;
boolean showFB = false;

// zigzag or weave pattern
boolean zigzag = true;

// show cout cin records on the geometry
boolean showCoutCin = true;
// show cout cin aggregation
boolean showAgg = true;
float lineWeight = 1;


// handling data
Table table;
int numRows;
ArrayList<Record> record_arrL = new ArrayList<Record>();

Table coutFreqTable;
Table cinFreqTable;
HashMap<String,Integer> coutDict = new HashMap<String,Integer>();
HashMap<String,Integer> cinDict = new HashMap<String,Integer>();


//----------------------------------------------------------
void setup(){
  size(1680, 1000, P3D);
  smooth(); // anti-aliasing
  
  
  // Set camera
  // cam = new PeasyCam(this, 800);
  // PeasyCam (this, x position, y position, z position, viewing distance)
  cam = new PeasyCam(this, 150, -80, 100, scrZ);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(scrZ); // max viewing distance
  //println(cam.getLookAt());
  
  // Set the angle of view - like changing the lens on a camera PI/2 (wide angle); PI/6 normal lens; PI/12 (telephoto)
  float fov = PI/2; // field of view try between PI/2 to PI/10
  float cameraZ = (height/2.0) / tan(PI/6);
  //perspective(field of view in radians; aspect/ratio of width to height; zNear - Z position of nearest clipping, zFar - Z position of farthest clipping)
  //default values are : perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0) where cameraZ is ((height/2.0) / tan(PI*60.0/360.0));
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0); // if using 0.001 instead of cameraZ/10.0 so that all things close to the screen can be seen - get noise
  
  
  // GUI
  cp5 = new ControlP5(this);
  setGUI();
  
  yearLabelFont = createFont("Georgia", 64, true);
  
  
  // Load book data
  //table = loadTable("cleaned_data.csv", "header, csv");
  //table = loadTable("data_nodup_first.csv", "header, csv");
  table = loadTable("data_nodup_last.csv", "header, csv");
  
  numRows = table.getRowCount();

  for(int i = 0; i < numRows; i++){
    String title = table.getString(i,1);
    String cout = table.getString(i,2);
    String cin = table.getString(i,3);
    int timeOutside = table.getInt(i, 5);
    String artform = table.getString(i, 6);
    record_arrL.add(new Record(title, cout, cin, timeOutside, artform));
  }
  
  // Load aggregated checkin/checkout data
  coutFreqTable = loadTable("aggregated_cout.csv", "header, csv");
  for (int i = 0; i < coutFreqTable.getRowCount(); i++){
    coutDict.put(coutFreqTable.getString(i, 0), coutFreqTable.getInt(i, 1));
  }

  cinFreqTable = loadTable("aggregated_cin.csv", "header, csv");
  for (int i = 0; i < cinFreqTable.getRowCount(); i++){
    String[] ymd = split(cinFreqTable.getString(i, 0), '-');
    //println(ymd[0], ymd[1], ymd[2]);
    String joinedKey = String.join("-", ymd[0], ymd[1], ymd[2]);
    cinDict.put(joinedKey, cinFreqTable.getInt(i, 1));
  }
  
  
}


//----------------------------------------------------------
void draw(){
  background(bgColor);
  noFill();
  frameRate(30);
  
  
  for (int i = 0; i < record_arrL.size(); i++){
    makeWeave = false;
    Record currR = record_arrL.get(i);
    
    
    String artform = currR.getArtform();
    if (artform.equals("crochet")){
      if (showCrochet) {
        makeWeave = true;
      }
      cCurve = cPurple;
    }
    if (artform.equals("amigurumi")){
      if (showAmigurumi){
        makeWeave = true;
      }
      cCurve = cBlue;
    }
    if (artform.equals("macrame")){
      if (showMacrame){
        makeWeave = true;
      }
      cCurve = cCyan;
    }
    if (artform.equals("friendship bracelet")){
      if (showFB){
        makeWeave = true;
      }
      cCurve = cGreen;
    }
    
    
    if (!makeWeave) {
      continue;
    }


    // parse checkin and checkout dates for current book
    currR.calcCoutYMD();
    currR.calcCinYMD();
    int coutYear = currR.getCoutYear();
    int coutMonth = currR.getCoutMonth();
    int coutDay = currR.getCoutDay();
    int cinYear = currR.getCinYear();
    int cinMonth = currR.getCinMonth();
    int cinDay = currR.getCinDay();
    

    // Checkout records before 2005 are treated as outliers, not drawn
    if (coutYear < 2005){
      continue;
    }
    
    // Look up aggregated frequency data
    // on the checkout and checkin dates of current book
    String coutDate = split(currR.cout, ' ')[0];
    String cinDate = split(currR.cin, ' ')[0];
    int coutSize = coutDict.get(coutDate);
    int cinSize = cinDict.get(cinDate);

    // Calculate point and curve positions
    // Draw for 1 book
    int cout_x, cout_z, cin_x, cin_z;
    cout_x = (coutDay - 1) * 10;
    cout_z = (coutYear - 2005) * (120 + 20) + coutMonth * 10;
    
    cin_x = (cinDay - 1) * 10;
    cin_z = (cinYear - 2005) * (120 + 20) + cinMonth * 10;

    if (!zigzag){
      cout_x = flipDateCoords(coutYear, coutMonth, coutDay);
      cin_x = flipDateCoords(cinYear, cinMonth, cinDay);
    }

    int t_y = -1 * currR.getTimeOutsideLibrary();
    float t_x = (cin_x - cout_x) / 2.0 + cout_x;
    float t_z = (cin_z - cout_z) / 2.0 + cout_z;
    
    drawCurve(cout_x, cout_z, cin_x, cin_z, t_x, t_y, t_z, showCoutCin);
    if (showAgg){
      drawPoints(cout_x, cout_z, cin_x, cin_z, coutSize, cinSize);
    }
    
  }
  
  drawYearLabels();
  ///**
  ///* show underlying geometry frame
  ///*
  //if (!showSpindle){
  //  // show spindle geometry
  //  pushMatrix();
  //  for (int i = 2005; i <= 2023; i++){
  //    drawYearDisc(i);
  //  }
  //  popMatrix();
  //}
  if (geometry){
    // show flat weave geometry
    for (int i = 2005; i <= 2023; i++){
      drawYearSquare(i);
      translate(0, 0, 20); // influences data point z position
    }
  }
  //*/
  
  // GUI controls
  GUI();
  
  boolean cond1 = (mouseX < 200) && (mouseY < 800);
  boolean cond2 = (mouseY < 100) && (mouseX < 300);
  if (cond1 || cond2){
    cam.setActive(false);
  }
  else{
    cam.setActive(true);
  }

}


    
int flipDateCoords(int year, int month, int day){
  int x = (day - 1) * 10;
  if (month % 2 == 0){
      int rMost = 0;
      if (month >= 8){
        rMost = 300;
      }
      else if (month == 4 || month == 6){
        rMost = 290;
      }
      else{
        if (year % 4 == 0){
          // leap year
          rMost = 280;
        }
        else{
          rMost = 270;
        }
      }
      x = rMost - (day - 1) * 10;
  }
  return x;
}

void drawCurve(int cout_x, int cout_z, int cin_x, int cin_z, float t_x, int t_y, float t_z, boolean showCoutCin){
  if (showCoutCin) {
    strokeWeight(4);
    // cout
    stroke(cRed);
    point(cout_x, 0, cout_z);
    // cin
    stroke(cYellow);
    point(cin_x, 0, cin_z);

  }
  
  // curve
  strokeWeight(2);
  stroke(color(cCurve, 95));
  
  noFill();
  beginShape();
  curveVertex(cout_x, 0, cout_z);
  curveVertex(cout_x, 0, cout_z);
  curveVertex(t_x, t_y, t_z);
  curveVertex(cin_x, 0, cin_z);
  curveVertex(cin_x, 0, cin_z);
  endShape();
}

void drawPoints(int cout_x, int cout_z, int cin_x, int cin_z, int coutSize, int cinSize){
  // cout
  if (coutSize > 1000){
    coutSize = 50;
  }
  if (cinSize > 1000){
    cinSize = 50;
  }
  float ptSize = map(coutSize, 1, 1000, 1, 50);
  float ptY = map(coutSize, 1, 1000, 1, 200);
  strokeWeight(ptSize);
  stroke(color(cRed, 85));
  point(cout_x, 20 + ptY, cout_z);

  strokeWeight(min(lineWeight, ptSize));
  line(cout_x, 20 + ptY, cout_z, cout_x, 0, cout_z);
  // cin
  ptSize = map(cinSize, 1, 1000, 1, 50);
  ptY = map(coutSize, 1, 1000, 1, 200);
  strokeWeight(ptSize);
  stroke(color(cYellow, 85));
  point(cin_x, 20 + ptY, cin_z);
  
  strokeWeight(min(lineWeight, ptSize));
  line(cin_x, 20 + ptY, cin_z, cin_x, 0, cin_z);
}

void drawYearLabels(){
  fill(fillColor);
  textFont(yearLabelFont);
  textSize(256);
  
  for (int i = 2005; i <= 2023; i++){
    int text_z = 50 + (i - 2005) * (120+20);
    pushMatrix();
    textAlign(CENTER);
    translate(-75, 0, text_z);
    rotateX(PI* 3/8);
    scale(0.1);
    text(String.valueOf(i), 0, 0, 0);
    popMatrix();
  }
  

}
