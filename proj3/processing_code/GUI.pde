ScrollableList nl;

void setGUI(){
   PFont pfont = createFont("Georgia", 72, true);
   ControlFont font = new ControlFont(pfont, 14);

   cp5.addSlider("bgColor")
   .setLabel("Background Color")
   .setRange(0, 255)
   .setPosition(30, 30)
   .setSize(255, 20)
   .setFont(font)
   .getCaptionLabel().toUpperCase(false);
  
   cp5.addToggle("showName")
   .setLabel("Show Contributors")
   .setPosition(30, 100)
   .setSize(50, 20)
   .setFont(font)
   .getCaptionLabel().toUpperCase(false);
  
   cp5.addToggle("showPreview")
   .setLabel("Show Previews")
   .setPosition(30, 160)
   .setSize(50, 20)
   .setFont(font)
   .getCaptionLabel().toUpperCase(false);
  
  nl = cp5.addScrollableList("nameList")
  .setLabel("Contributor: # of Patterns")
  .setPosition(1350, 30)
  .setSize(300, 500)
  .setBarHeight(30)
  .setItemHeight(30);

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

void setNameListGUI(){
  //cp5.addScrollableList("nameList")
  //.setLabel("Contributor List")
  //.setPosition(1400, 30)
  //.setSize(250, 400)
  //.setBarHeight(30)
  //.setItemHeight(30)
  PFont pfont = createFont("Georgia", 72, true);
  ControlFont font = new ControlFont(pfont, 14);
   
  nl.setFont(font);
  nl.getCaptionLabel().toUpperCase(false);
  nl.getValueLabel().toUpperCase(false);
  nl.setItems(nameL);
}
