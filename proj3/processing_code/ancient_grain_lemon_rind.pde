import java.util.*;
import peasy.*;
import controlP5.*;

ControlP5 cp5;
PeasyCam cam;

float bgColor = 35;
float fillColor = 250;

//screen size and Z depth
int scrX = 1680;
int scrY = 1000;
int scrZ = 50; //peasycam max Z depth

// handle data
Table table;
ArrayList<Pattern> patterns_arrL = new ArrayList<Pattern>();

void setup(){
  size(1680, 1000, P3D);
  smooth(); // anti-aliasing
  
  
  // Set camera
  // cam = new PeasyCam(this, 800);
  // PeasyCam (this, x position, y position, z position, viewing distance)
  cam = new PeasyCam(this, 20, -10, scrZ, 100);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(500); // max viewing distance

  // Set the angle of view - like changing the lens on a camera PI/2 (wide angle); PI/6 normal lens; PI/12 (telephoto)
  float fov = PI/6; // field of view try between PI/2 to PI/10
  float cameraZ = (height/2.0) / tan(PI/4);
  //perspective(field of view in radians; aspect/ratio of width to height; zNear - Z position of nearest clipping, zFar - Z position of farthest clipping)
  //default values are : perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0) where cameraZ is ((height/2.0) / tan(PI*60.0/360.0));
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0); // if using 0.001 instead of cameraZ/10.0 so that all things close to the screen can be seen - get noise
  
  table = loadTable("patterns.csv", "header");
  println("patterns.csv loaded");
  println(table.getRowCount() + " total rows in table");
  
  for (TableRow row : table.rows()) {
    patterns_arrL.add(new Pattern(row));
  }
  println("table converted to Pattern objects");
  println("patterns arraylist size:", patterns_arrL.size());

}

HashMap<Integer, ArrayList<Pattern>> allPoints = new HashMap<Integer, ArrayList<Pattern>>();

void draw(){
  background(bgColor);
  noFill();
  //frameRate(30);
  
  //x-axis
  stroke(255, 0, 0);
  line(0, 0, 0, 1000*1000, 0, 0);
  //neg y-axis
  stroke(0, 255, 0);
  line(0, 0, 0, 0, -1000*1000, 0);
  //z-axis
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 1000*1000);
  
  stroke(fillColor, 75);
  //box(150);
  
  if (allPoints.size() == 5561){
    for (HashMap.Entry<Integer, ArrayList<Pattern>> e : allPoints.entrySet()) {
      int k = e.getKey();
      // XX,YY,ZZZ
      // 10000000 + X*100,000 + Y*1000 + Z
      float x = float(int(k/100000));
      float pos_y = float(int((k - x*100000)/1000));
      float z = float(int((k - x*100000) - pos_y*1000));
      ArrayList<Pattern> l = e.getValue();
      int sw = l.size();
      sw = int(map(sw, 1, 200, 3, 30));
      strokeWeight(sw);
      point(x, -pos_y, z);
    }
  }
  else{
    for (Pattern p: patterns_arrL){
      float x = float(p.num_strings); // cols * 2, [3, 64]
      float y = -1.0 * float(p.num_colors); // colors, [1, 26]
      float z = float(p.rows); // rows, [2, 200]
      DataCoord dc = new DataCoord(x, -y, z);
      int k = dc.getKeyCoord();
      
      int sw = 1;
      ArrayList<Pattern> currPatternList = allPoints.get(k);
      if (currPatternList != null) {
        currPatternList.add(p);
        sw = currPatternList.size();
      } else {
        // No such key exist
        ArrayList<Pattern> newPatternList = new ArrayList<Pattern>();
        newPatternList.add(p);
        allPoints.put(k, newPatternList);
      }
      sw = int(map(sw, 1, 200, 3, 30));
      strokeWeight(sw);
      point(x, y, z);
    }

  }
  strokeWeight(1);
  
  
  //for (Pattern p: patterns_arrL){
  //  float x = float(p.num_strings); // cols * 2, [3, 64]
  //  float y = -1.0 * float(p.num_colors); // colors, [1, 26]
  //  float z = float(p.rows); // rows, [2, 200]
  //  strokeWeight(2);
  //  point(x, y, z);
  //}
  
  //println("max:", maxX, maxY, maxZ);
  //println("min:", minX, minY, minZ);
  //println("hashmap size / totoal number of points:", allPoints.size());
  //noLoop();
}
