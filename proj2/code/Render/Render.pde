import peasy.*;
import controlP5.*;

ControlP5 cp5;
PeasyCam cam;

//screen size and Z depth
int scrX = 1680;
int scrY = 1000;
int scrZ = 2800; //peasycam Z depth


float background_color = 100;
float fillColor = 0;

PFont yearLabelFont;

// color palette
color cRed = #D56E78;
color cPurple = #C688B9;
color cBlue = #82AEDE;
color cCyan = #2CCDCF;
color cGreen = #6ADF97;
color cYellow = #CFE261;


// showSpindle - default true - show spindle geometry
// showSpindle - false - show flat weave geometry
boolean showSpindle = true;
// makeWeave - selector for which artform is shown
boolean makeWeave = false;

// handling data
Table table;
int numRows, numColumns;
ArrayList<Record> record_arrL = new ArrayList<Record>();
color cCurve = color(0, 0, 0);


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
  
  
  // Load data
  //table = loadTable("cleaned_data.csv", "header, csv");
  //table = loadTable("data_nodup_first.csv", "header, csv");
  table = loadTable("data_nodup_last.csv", "header, csv");
  
  numRows = table.getRowCount();
  numColumns = table.getColumnCount();

  for(int i = 0; i < numRows; i++){
    String title = table.getString(i,1);
    String cout = table.getString(i,2);
    String cin = table.getString(i,3);
    int timeOutside = table.getInt(i, 5);
    String artform = table.getString(i, 6);
    record_arrL.add(new Record(title, cout, cin, timeOutside, artform));
  }
  
}


//----------------------------------------------------------
void draw(){
  background(background_color);
  noFill();
  frameRate(30);
  
  
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
    if (artform.equals("macrame")){
      makeWeave = true;
    }
    else{
      continue;
    }
    
    // Calculate point and curve positions
    // Draw curve of 1 book
    if (makeWeave) {

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

  
      int cout_x = (coutDay - 1) * 10;
      int cout_z = (coutYear - 2005) * (120 + 20) + coutMonth * 10;
      
      int cin_x = (cinDay - 1) * 10;
      int cin_z = (cinYear - 2005) * (120 + 20) + cinMonth * 10;
      //println(YMD[0], YMD[1], YMD[2], x, z);
      
      int t_y = -1 * currR.getTimeOutsideLibrary();
      float t_x = (cin_x - cout_x) / 2.0 + cout_x;
      float t_z = (cin_z - cout_z) / 2.0 + cout_z;
      
      drawCurve(cout_x, cout_z, cin_x, cin_z, t_x, t_y, t_z);
      
    }
    
    drawYearLabels();
    
    
    // GUI controls
    GUI();
    if ((mouseX < 180) && (mouseY < 180)){
      cam.setActive(false);
    }
    else{
      cam.setActive(true);
    }
    
  }
 
  
  
  ///**
  ///* show underlying geometry frame
  ///*
  if (!showSpindle){
    // show spindle geometry
    pushMatrix();
    for (int i = 2005; i <= 2023; i++){
      drawYearDisc(i);
    }
    popMatrix();
  }
  else {
    // show flat weave geometry
    for (int i = 2005; i <= 2023; i++){
      drawYearSquare(i);
      translate(0, 0, 20); // influences data point z position
    }
  }
  //*/

}

void drawCurve(int cout_x, int cout_z, int cin_x, int cin_z, float t_x, int t_y, float t_z){
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
