import java.util.*;
import java.lang.Math;
import peasy.*;
import controlP5.*;

ControlP5 cp5;
PeasyCam cam;

float bgColor = 45;
float fillColor = 250;

PFont axisLabelFont;


//screen size and Z depth
int scrX = 1680;
int scrY = 1000;
int scrZ = 50; //peasycam max Z depth

// handle data
Table table;
ArrayList<Pattern> patterns_arrL = new ArrayList<Pattern>();
HashMap<Triple, PatternCollection> patternMap = new HashMap<Triple, PatternCollection>();

// color palette
color c0 = #DAB04D;
color c1 = #9EBF5D;
color c2 = #5EC58D;
color c3 = #3EC1C0;
color c4 = #7BB4DC;
color c5 = #C59ED2;
color c6 = #F289A8;

color cyn = #58D3A4;
color highlightColor = cyn;

// GUI control
boolean showName = true;
boolean showPreview = false;


void setup(){
  size(1680, 1000, P3D);
  smooth(4); // anti-aliasing
  
  
  // Set camera
  // cam = new PeasyCam(this, 800);
  // PeasyCam (this, x position, y position, z position, viewing distance)
  cam = new PeasyCam(this, 500, -400, 250, 2500);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000); // max viewing distance

  // Set the angle of view - like changing the lens on a camera PI/2 (wide angle); PI/6 normal lens; PI/12 (telephoto)
  float fov = PI/6; // field of view try between PI/2 to PI/10
  float cameraZ = (height/2.0) / tan(PI/4);
  //perspective(field of view in radians; aspect/ratio of width to height; zNear - Z position of nearest clipping, zFar - Z position of farthest clipping)
  //default values are : perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0) where cameraZ is ((height/2.0) / tan(PI*60.0/360.0));
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0); // if using 0.001 instead of cameraZ/10.0 so that all things close to the screen can be seen - get noise
  
  
  // GUI
  cp5 = new ControlP5(this);
  setGUI();
  
  axisLabelFont = createFont("Georgia", 32, true);
  
  // load data
  table = loadTable("patterns.csv", "header");
  println("patterns.csv loaded");
  println(table.getRowCount() + " total rows in table");
  
  // an arrayList of all patterns in the CSV as Pattern objects
  for (TableRow row : table.rows()) {
    patterns_arrL.add(new Pattern(row));
  }
  println("table contents converted to Pattern objects");
  println("patterns arraylist size:", patterns_arrL.size());
  
  // map Pattern objects to coordinates
  // k: coordinate Triple
  // v: a PatternCollection object positioned at the k
  for (Pattern p: patterns_arrL){
    Triple k = p.getCoordinateTriple();
    PatternCollection c = patternMap.getOrDefault(k, new PatternCollection());
    c.addPatternToCollection(p);
    patternMap.put(k, c);
  }
  
  

}

// ----------------------------------------------------------------------------------------------------
void draw(){
  background(bgColor);
  noFill();
  //frameRate(30);
  
  //x-axis
  stroke(c6);
  line(0, 0, 0, 1000, 0, 0);
  //neg y-axis
  stroke(c3);
  line(0, 0, 0, 0, -1000, 0);
  //z-axis
  stroke(c0);
  line(0, 0, 0, 0, 0, 1000);
  
  
  for (HashMap.Entry<Triple, PatternCollection> e : patternMap.entrySet()) {
    Triple k = e.getKey();
    float x = map(k.getXCoord(), 3, 64, 1, 1000);
    float y = map(k.getYCoord(), -26, -1, -1000, -1);
    float z = map(k.getZCoord(), 2, 200, 1, 1000);
    
    // calculate stroke color
    int sc = lerpColorAtTriple(x, y, z);
    stroke(color(sc, 75));
  
    // ----------
    PatternCollection currCollection = e.getValue();
    //int sw = currCollection.getSize();
    int sw = int(map(currCollection.getSize(), 1, 200, 3, 30));
    strokeWeight(sw);
    point(x, y, z);
    
    // ---------- selected point ----------
    //double mouseCoordDistance = Math.sqrt(sq(mouseX - screenX(x, y, z)) + sq(mouseY - screenY(x, y, z)));
    //if (mouseCoordDistance < sw){ // how do I only select 1 point?
    float mouseCoordDistance = sq(mouseX - screenX(x, y, z)) + sq(mouseY - screenY(x, y, z));
    if (mouseCoordDistance < 30){ //
      //println("sw: " + sw + " mouse distance: " + mouseCoordDistance);
      fill(color(cyn));
      textMode(SHAPE);
      textFont(axisLabelFont);
      textSize(64);
      if (cam.getDistance() < 250){
        textSize(24);
      }
      else{
        textSize(32);
      }
      
      //pushMatrix();
      //float[] rotations = cam.getRotations();
      //rotateX(rotations[0]);
      //rotateY(rotations[1]);
      //rotateZ(rotations[2]);
      if (showName){
      float pos = y;
        HashMap<String, Integer> name_num = currCollection.getNameNumPairs();
        for (String name : name_num.keySet()){
          int num = name_num.get(name);
          String concat = name + ": " + num;
          text(concat, x, pos, z);
          pos += 40;
        }
      }
      //popMatrix();

      strokeWeight(sw);
      stroke(cyn, 95);
      point(x, y, z);
      if (showPreview){
        ArrayList<String> previews = currCollection.getPreviewList();
        float img_y = -1000;
        //pushMatrix();
        //translate(0, 0, 250);
        for (String url : previews){
          PImage img = loadImage(url);
          if (img != null){
          
            // calculate new width based on original aspect ratio
            //int newHeight = 50;
            //int newWidth = (int) ((float) img.width / img.height * newHeight);
            
            int newWidth = 500;  // your desired width
  
            // calculate the new height while keeping the aspect ratio
            int newHeight = (int) (img.height * ((float) newWidth / img.width));
  
            img.resize(newWidth, newHeight);
            
            image(img, 1200, img_y);
            
            img_y += newHeight + 10;
          }
        }
        //popMatrix();
      }


    }
    // ----------
    
  }

  strokeWeight(1);
  
  drawAxisLabels(0);
  drawAxisLabels(1);
  drawAxisLabels(2);
  
  // GUI controls
  GUI();
  boolean cond1 = (mouseX < 200) && (mouseY < 200);
  boolean cond2 = (mouseY < 100) && (mouseX < 300);
  if (cond1 || cond2){
    cam.setActive(false);
  }
  else{
    cam.setActive(true);
  }
}

// ----------------------------------------------------------------------------------------------------
int lerpColorAtTriple(float x, float y, float z){
  // pt -> x-axis
  float to_x = sqrt(sq(y) + sq(z));
  // pt -> y-axis
  float to_y = sqrt(sq(x)+ sq(z));
  // pt -> z-axis
  float to_z = sqrt(sq(x) + sq(y));
  float amt1 = to_x / (to_x + to_y);
  color lerpXY = lerpColor(c6, c3, amt1);
  float amt2 = to_z / (z + to_z);
  color lerpXYZ = lerpColor(c0, lerpXY, amt2);
  return lerpXYZ;
}


void drawAxisLabels(int axis){
  // x: axis == 0
  if (axis == 0){
    fill(c6);
    textFont(axisLabelFont);
    textSize(128);
    
    pushMatrix();
    textAlign(CENTER);
    translate(1075, 0, 0);
    scale(0.3);
    //text("number of strings", 0, 0, 0);
    text("strings", 0, 0, 0);
    popMatrix();
  }
  // y: axis == 1
  if (axis == 1){
    fill(c3);
    textFont(axisLabelFont);
    textSize(128);
    
    pushMatrix();
    textAlign(CENTER);
    translate(0, -1075, 0);
    rotateZ(-PI * 0.5);
    scale(0.3);
    //text("number of colors", 0, 0, 0);
    text("colors", 0, 0, 0);
    popMatrix();
  }
  // z: axis == 2
  if (axis == 2){
    fill(c0);
    textFont(axisLabelFont);
    textSize(128);
    
    pushMatrix();
    textAlign(CENTER);
    translate(0, 0, 1075);
    rotateY(PI * 0.5);
    scale(0.3);
    //text("number of rows", 0, 0, 0);
    text("length", 0, 0, 0);
    popMatrix();
  }
}
