import peasy.*;
import controlP5.*;

ControlP5 cp5;
PeasyCam cam;

float background_color;
float fillColor;

// color palette
color cRed = #D56E78;
color cPurple = #C688B9;
color cBlue = #82AEDE;
color cCyan = #2CCDCF;
color cGreen = #6ADF97;
color cYellow = #CFE261;

boolean showBase = false;
// showSpindle - default true - show spindle geometry
// showSpindle - false - show flat weave geometry
boolean showSpindle = true;
// yearAsLine - default false - show each year as a square, each month in a line
// yearAsLine - true - show each year in a single line
boolean yearAsLine = false;
// makeWeave - selector for which artform is shown
boolean makeWeave = false;

//PFont arial;


Table table;
int numRows, numColumns;
ArrayList<Record> record_arrL = new ArrayList<Record>();
color cCurve = color(0, 0, 0);
//int ptSize = 4;

void setup(){
  size(1680, 1000, P3D);
  cam = new PeasyCam(this, 800);
  // PeasyCam(processing.core.PApplet parent, double lookAtX, double lookAtY, double lookAtZ, double distance)
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(5000);
  //println(cam.getLookAt());
  
  cp5 = new ControlP5(this);
  
  background_color = 100;
  fillColor = 255;
  
  
  //table = loadTable("cleaned_data.csv", "header, csv");
  //table = loadTable("data_nodup_first.csv", "header, csv");
  table = loadTable("data_nodup_last.csv", "header, csv");
  
  numRows = table.getRowCount();
  numColumns = table.getColumnCount();
  //println(numRows, numColumns);
  
  //for(int i = 0; i < 1000; i++){
  for(int i = 0; i < numRows; i++){
    String title = table.getString(i,1);
    String cout = table.getString(i,2);
    String cin = table.getString(i,3);
    int timeOutside = table.getInt(i, 5);
    String artform = table.getString(i, 6);
    record_arrL.add(new Record(title, cout, cin, timeOutside, artform));
  }
  //Record r_0 = record_arrL.get(0); 
  //println(r_0.getCoutYMD());
  //println(record_arrL.size());
  
}

void draw(){
  background(background_color);
  noFill();
  
  for (int i = 0; i < record_arrL.size(); i++){
    Record currR = record_arrL.get(i);
    String artform = currR.getArtform();
    
    if (artform.equals("crochet")){
      cCurve = cPurple;
    }
    if (artform.equals("amigurumi")){
      cCurve = cBlue;
    }
    if (artform.equals("macrame")){
      cCurve = cCyan;
    }
    if (artform.equals("friendship bracelet")){
      cCurve = cGreen;
    }
    //if (artform.equals("friendship bracelet") || artform.equals("macrame") || artform.equals("amigurumi")){
    //if (artform.equals("friendship bracelet") || artform.equals("macrame") || artform.equals("amigurumi") || artform.equals("crochet")){
    if (artform.equals("crochet")){
      makeWeave = true;
    }
    else{
      continue;
    }
    
    if (makeWeave) {
      //int[] coutYMD = currR.getCoutYMD();
      //int[] cinYMD = currR.getCinYMD();
      //if (coutYMD[0] < 2005){
      //  continue;
      //}
      currR.calcCoutYMD();
      currR.calcCinYMD();
      int coutYear = currR.getCoutYear();
      int coutMonth = currR.getCoutMonth();
      int coutDay = currR.getCoutDay();
      int cinYear = currR.getCinYear();
      int cinMonth = currR.getCinMonth();
      int cinDay = currR.getCinDay();
      
  
      // Checkout records before 2005 are treated as outliers
      if (coutYear < 2005){
        continue;
      }
      
      
  
      int cout_x = (coutDay - 1) * 10;
      int cout_z = (coutYear - 2005) * (120 + 20) + coutMonth * 10;
      
      int cin_x = (cinDay - 1) * 10;
      int cin_z = (cinYear - 2005) * (120 + 20) + cinMonth * 10;
      //println(YMD[0], YMD[1], YMD[2], x, z);
      
      int t_y = -1 * currR.getTimeOutsideLibrary();
      float t_x = (cin_x - cout_x) / 2.0 + cout_x;
      float t_z = (cin_z - cout_z) / 2.0 + cout_z;
      
      strokeWeight(4);
      // cout
      stroke(cRed);
      point(cout_x, 0, cout_z);
      // cin
      stroke(cYellow);
      point(cin_x, 0, cin_z);
      // mid point & height - time spent outside SPL
      //stroke(cCyan);
      //point(t_x, t_y, t_z);
      // curve
      strokeWeight(2);
      stroke(color(cCurve, 75));
      //line(cout_x, 0, cout_z, cin_x, 0, cin_z);
      noFill();
      beginShape();
      curveVertex(cout_x, 0, cout_z);
      curveVertex(cout_x, 0, cout_z);
      curveVertex(t_x, t_y, t_z);
      curveVertex(cin_x, 0, cin_z);
      curveVertex(cin_x, 0, cin_z);
      endShape();
      
    }
    
  }
 
  
  if (showBase) {
    strokeWeight(3);
    point(0, 0, 0);
    strokeWeight(0.5);
    circle(0, 0, 100);
  }
  
  /**
  /* show underlying geometry frame
  /*
  //if (!showSpindle){
  //  // show spindle geometry
  //  pushMatrix();
  //  for (int i = 2005; i <= 2023; i++){
  //    drawYearDisc(i);
  //  }
  //  popMatrix();
  //}
  //else {
  //  // show flat weave geometry
  //  for (int i = 2005; i <= 2023; i++){
  //    if (yearAsLine) {
  //      translate(0, 0, 10);
  //      drawYearAxis(i);
  //    }
  //    else{
  //      drawYearSquare(i);
  //      translate(0, 0, 20); // influences data point z position 
  //    }
      
  //  }
  //}
  */


}
