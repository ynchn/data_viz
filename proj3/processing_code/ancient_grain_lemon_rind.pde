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
//int scrX = 1680;
//int scrY = 1000;
//int scrZ = 50; //peasycam max Z depth

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
ArrayList<String> nameL = new ArrayList<String>();
boolean showSingleContributor = false;

// mouse press control
boolean selectHighlight = false;
Triple selectedCoord;


// ----------------------------------------------------------------------------------------------------
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
  
  if (!showName){
    profileButton.hide();
    nameL.clear();
  }
  
  if (showSingleContributor && selectHighlight){
    // draw points of only the selected contributor
    for (HashMap.Entry<Triple, PatternCollection> e : patternMap.entrySet()) {
      // check current collection if it's a point containing selected contributor
      PatternCollection currCollection = e.getValue();
      boolean drawCurrPoint = currCollection.getNameNumPairs().containsKey(selected);
      if (!drawCurrPoint){
        continue;
      }
      if (showName){
        profileURL = currCollection.getProfileURL(selected);
        profileButton.setLabel("Go to " + selected + "'s Profile");
        profileButton.getCaptionLabel().toUpperCase(false);
        profileButton.show();
      }
      // size correspond to the number of patterns the contributor upload at current point
      int sw = int(map(currCollection.getNameNumPairs().get(selected), 1, 200, 3, 30));
      strokeWeight(sw);
      
      // get coordinates
      Triple k = e.getKey();
      float x = map(k.getXCoord(), 3, 64, 1, 1000);
      float y = map(k.getYCoord(), -26, -1, -1000, -1);
      float z = map(k.getZCoord(), 2, 200, 1, 1000);
      
      // ---------- highlight point ----------
      float mouseCoordDistance = sq(mouseX - screenX(x, y, z)) + sq(mouseY - screenY(x, y, z));
      if (mouseCoordDistance < 30){
        // draw highlighted point when mouse position is close to a point
        stroke(cyn, 229);
        point(x, y, z);
  
        prepFont();
        if (showName){
          nameL = showNameAtPoint(x, y, z, currCollection, showSingleContributor);
        }
  
        if (showPreview){
          showPreviewAtPoint(currCollection);
        }
      }
      else{
        // calculate point color
        int sc = lerpColorAtTriple(x, y, z);
        stroke(color(sc, 192));
        // draw point
        point(x, y, z);
      }
    }
  }
  else{
  
    if (!selectHighlight){
      
      for (HashMap.Entry<Triple, PatternCollection> e : patternMap.entrySet()) {
        Triple k = e.getKey();
        float x = map(k.getXCoord(), 3, 64, 1, 1000);
        float y = map(k.getYCoord(), -26, -1, -1000, -1);
        float z = map(k.getZCoord(), 2, 200, 1, 1000);
        
        // calculate point size
        PatternCollection currCollection = e.getValue();
        int sw = int(map(currCollection.getSize(), 1, 200, 3, 30));
        strokeWeight(sw);
        
        // ---------- highlight point ----------
        float mouseCoordDistance = sq(mouseX - screenX(x, y, z)) + sq(mouseY - screenY(x, y, z));
        if (mouseCoordDistance < 30){
          // select/highlight one point by pressing right mouse button
          if (mousePressed && (mouseButton == LEFT)) {
            if (!selectHighlight){
              selectHighlight = true;
            }
            selectedCoord = k;
            //break;
          }
          
          // draw highlighted point when mouse position is close to a point
          // point gets highlighted regardless if it's selected
          stroke(cyn, 229);
          point(x, y, z);
          
          //prepFont();
    
          if (showName){
            nameL = showNameAtPoint(x, y, z, currCollection, showSingleContributor);
          }
    
          if (showPreview){
            showPreviewAtPoint(currCollection);
          }
        }
        else{
          // calculate point color
          int sc = lerpColorAtTriple(x, y, z);
          stroke(color(sc, 192));
          // draw point
          point(x, y, z);
        }
        // -------------------------------------
        
      }// end normal loop
    
    }
    else{
      // selected highlight point at coordinate `selectedCoord`
      for (HashMap.Entry<Triple, PatternCollection> e : patternMap.entrySet()) {
        Triple k = e.getKey();
        
        float x = map(k.getXCoord(), 3, 64, 1, 1000);
        float y = map(k.getYCoord(), -26, -1, -1000, -1);
        float z = map(k.getZCoord(), 2, 200, 1, 1000);
        
        // calculate point size
        PatternCollection currCollection = e.getValue();
        int sw = int(map(currCollection.getSize(), 1, 200, 3, 30));
        strokeWeight(sw);
        // ---------- selected/highlighted point ----------
        if (selectedCoord == k){
          stroke(cyn, 229);
          point(x, y, z);
          
          //prepFont();
    
          if (showName){
            nameL = showNameAtPoint(x, y, z, currCollection, showSingleContributor);
          }
    
          if (showPreview){
            showPreviewAtPoint(currCollection);
          }
        // ------------------------------------------------
        }
        else{
          // calculate point color
          int sc = lerpColorAtTriple(x, y, z);
          stroke(color(sc, 192));
          // draw point
          point(x, y, z);
        }
        
  
        
  
      }// end normal loop
      
    }
  
  }
  setNameListGUI();
  
  strokeWeight(1);
  
  drawAxisLabels(0);
  drawAxisLabels(1);
  drawAxisLabels(2);
  
  // GUI controls
  GUI();
  boolean cond1 = (mouseX < 200) && (mouseY < 200);
  boolean cond2 = (mouseY < 100) && (mouseX < 300);
  boolean cond3 = (mouseX > 1400) && (mouseY < 500);
  if (cond1 || cond2 || cond3){
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

void prepFont(){
  fill(color(cyn));
  textMode(SHAPE);
  textFont(axisLabelFont);
  if (cam.getDistance() < 100){
    textSize(16);
  }
  else{
    textSize(12);
  }
}

ArrayList<String> showNameAtPoint(float x, float y, float z, PatternCollection currCollection, boolean showSingleContributor){
  ArrayList<String> nameL = new ArrayList<String>();
  HashMap<String, Integer> name_num = currCollection.getNameNumPairs();
  for (String name : name_num.keySet()){

    if (showSingleContributor && (!name.equals(selected))){
      continue;
    }
    
    int num = name_num.get(name);
    String concat = name + ": " + num;
    nameL.add(concat);

    if (showSingleContributor){
      text(num, x, y, z);
    }
    
  }
  return nameL;
}

void showPreviewAtPoint(PatternCollection currCollection){
  ArrayList<String> previews = currCollection.getPreviewList();
  float img_y = -1000;
  for (String url : previews){
    PImage img = loadImage(url);
    if (img != null){
    
      // calculate new width based on original aspect ratio
      //int newHeight = 50;
      //int newWidth = (int) ((float) img.width / img.height * newHeight);
      
      int newWidth = 500; // fixed width
  
      // calculate the new height while keeping the aspect ratio
      int newHeight = (int) (img.height * ((float) newWidth / img.width));
  
      img.resize(newWidth, newHeight);
      
      image(img, 1200, img_y);
      
      img_y += newHeight + 10;
    }
  }
}
