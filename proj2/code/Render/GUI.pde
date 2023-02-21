void setGUI() {
  float leftX = 30;
  float rightX = 150;
  
  
  //PFont pfont = createFont("Serif", 32, true);
  //ControlFont cp5_font = new ControlFont(pfont, 16);
  
  cp5.addSlider("bgColor")
  .setLabel("Background Color")
  .setRange(0, 255)
  .setColorActive(cRed)
  .setColorForeground(color(#572D31))
  .setColorBackground(color(bgColor))
  .setPosition(leftX, 30)
  .setSize(255, 20);

  cp5.addSlider("fillColor") // this slider controls the var grey
  .setLabel("Fill Color")
  .setRange(0, 255)
  .setColorActive(cRed)
  .setColorForeground(color(#572D31))
  .setColorBackground(color(fillColor))
  .setPosition(leftX, 60)
  .setSize(255, 20);
  
  cp5.addToggle("showCrochet")
  .setLabel("Crochet")
  .setColorActive(cPurple)
  .setColorForeground(cPurple)
  .setColorBackground(color(#473143))
  .setPosition(leftX, 120)
  .setSize(60, 20);
  
  cp5.addToggle("showAmigurumi")
  .setLabel("Amigurumi")
  .setColorActive(cBlue)
  .setColorForeground(cBlue)
  .setColorBackground(color(#384A5E))
  .setPosition(leftX, 160)
  .setSize(60, 20);
  
  cp5.addToggle("showMacrame")
  .setLabel("Macrame")
  .setColorActive(cCyan)
  .setColorForeground(cCyan)
  .setColorBackground(color(#114E4F))
  .setPosition(leftX, 200)
  .setSize(60, 20);
  
  cp5.addToggle("showFB")
  .setLabel("Friendship Bracelet")
  .setColorActive(cGreen)
  .setColorForeground(cGreen)
  .setColorBackground(color(#2D5E40))
  .setPosition(leftX, 240)
  .setSize(60, 20);
  
  
  cp5.addToggle("geometry")
  .setLabel("Show Geometry")
  .setColorActive(color(fillColor))
  .setColorForeground(color((fillColor + bgColor)/2))
  .setColorBackground(color((fillColor + bgColor)/2))
  .setPosition(leftX, 310)
  .setSize(30, 20);
  
  cp5.addToggle("showCoutCin")
  .setLabel("Show Checkin/Checkout Points")
  .setColorActive(cYellow)
  .setColorForeground(color(#5B632B))
  .setColorBackground(color(#5B632B))
  .setPosition(leftX, 350)
  .setSize(30, 20);
  
  cp5.addToggle("showAgg")
  .setLabel("Show Checkin/Checkout Aggregation")
  .setColorActive(cYellow)
  .setColorForeground(color(#5B632B))
  .setColorBackground(color(#5B632B))
  .setPosition(leftX, 390)
  .setSize(30, 20);
  
  
  cp5.addSlider("lineWeight")
  .setLabel("Show Connection")
  .setRange(0, 2)
  .setColorActive(cRed)
  .setColorForeground(color(#572D31))
  .setColorBackground(color(bgColor))
  .setPosition(leftX, 430)
  .setSize(50, 20);
  
  
   cp5.addBang("zoomIn")
  .setLabel("Zoom In")
  .setColorActive(color(#E6A05E))
  .setColorForeground(color(#66472A))
  .setPosition(leftX, 490);
  
  cp5.addBang("zoomOut")
  .setLabel("Zoom Out")
  .setColorActive(color(#E6A05E))
  .setColorForeground(color(#66472A))
  .setPosition(leftX + 50, 490);


  cp5.addTextlabel("rotate Y")
  .setText("Rotate along the y-axis")
  .setPosition(leftX, 550);
  
  cp5.addBang("rotY")
  .setLabel("CW")
  .setPosition(leftX, 570);

  cp5.addBang("rotYneg")
  .setLabel("CCW")
  .setPosition(leftX + 50, 570);


  cp5.addTextlabel("rotate X")
  .setText("Rotate along the x-axis")
  .setPosition(leftX, 620);
  
  cp5.addBang("rotXneg")
  .setLabel("CW")
  .setPosition(leftX, 640);

  cp5.addBang("rotX")
  .setLabel("CCW")
  .setPosition(leftX + 50, 640);
  
  
  cp5.addTextlabel("arrow keys")
  .setText("Use arrow keys to navigate the calender\nUp/Down - move through years & months\nLeft/Right - move through days")
  .setPosition(leftX, 700);
  
  cp5.addTextlabel("key control")
  .setText("Additional key control:\n1 - rotateY CW\n2 - rotateY CCW\n3 - rotateX CCW\n4 - rotateX CW\n9 - Zoom In\n0 - Zoom Out")
  .setPosition(leftX, 740);


  
  
  
  // draw this after we disable depth in GUI()
  cp5.setAutoDraw(false);
}

void GUI(){
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();  // need to call this for P3D - check docs
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}


void rotY(){
  cam.rotateY(PI/2);
}
void rotYneg(){
  cam.rotateY(-PI/2);
}
void rotX(){
  cam.rotateX(PI/2);
}
void rotXneg(){
  cam.rotateX(-PI/2);
}

void zoomIn(){
  cam.lookAt(150, -80, 1140);
  cam.setDistance(700);
}
void zoomOut(){
  cam.lookAt(150, -80, 100);
  cam.setDistance(2800);
}
