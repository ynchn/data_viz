void setGUI() {
  float cp5_X = 30;
  float interval = 40;
  int idx = 1;
  
  
  //PFont pfont = createFont("Georgia", 16, true);
  //ControlFont font = new ControlFont(pfont, 12);
  
  cp5.addSlider("background_color")
  .setRange(0, 255)
  .setPosition(cp5_X, interval*idx)
  .setSize(100, 20);
  idx++;
  
  cp5.addSlider("fillColor") // this slider controls the var grey
  .setRange(0, 255)
  .setPosition(cp5_X, interval*idx)
  .setSize(100, 20);
  idx++;
  
  cp5.addBang("randColor")
  .setPosition(cp5_X, interval*idx);
  idx++;
  
  cp5.addTextlabel("label")
  .setText("Press space to show/hide box")
  //.setFont(font)
  .setColorValue(240)
  .setPosition(cp5_X, interval*idx);
  idx++;
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
