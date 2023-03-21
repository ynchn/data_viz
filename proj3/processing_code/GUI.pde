void setGUI(){
   cp5.addSlider("bgColor")
  .setLabel("Background Color")
  .setRange(0, 255)
  .setPosition(30, 30)
  .setSize(255, 20);
  
   cp5.addToggle("showName")
  .setLabel("Show Contributor Names")
  .setPosition(30, 70)
  .setSize(30, 20);
  
   cp5.addToggle("showPreview")
  .setLabel("Show Previews")
  .setPosition(30, 110)
  .setSize(30, 20);
  
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
