public ScrollableList nl;
public Button profileButton;
public String selected;
public String profileURL = "https://www.braceletbook.com/";

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
   .setLabel("Contributors")
   .setPosition(30, 80)
   .setSize(50, 20)
   .setFont(font)
   .getCaptionLabel().toUpperCase(false);
  
   cp5.addToggle("showPreview")
   .setLabel("Previews")
   .setPosition(30, 140)
   .setSize(50, 20)
   .setFont(font)
   .getCaptionLabel().toUpperCase(false);
  
  nl = cp5.addScrollableList("nameList")
  .setLabel("Contributor: # of Patterns")
  .setPosition(1350, 60)
  .setSize(300, 500)
  .setBarHeight(30)
  .setItemHeight(30);
  
  profileButton = cp5.addButton("goToURL")
  .setPosition(1350, 30)
  .setSize(300, 20)
  .setFont(font);
  profileButton.hide();

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
  PFont pfont = createFont("Georgia", 72, true);
  ControlFont font = new ControlFont(pfont, 14);
   
  nl.setFont(font);
  nl.getCaptionLabel().toUpperCase(false);
  nl.getValueLabel().toUpperCase(false);
  nl.setItems(nameL);
  nl.setLabel("Contributor: # of Patterns");
  nl.setOpen(true);
}

/**
* nameList dropdown menu callback function
**/
void nameList(int n) {
  selected = nl.getItem(n).get("name").toString();
  
  int idx = selected.indexOf(":");
  selected = selected.substring(0, idx);
  
  //String selected = cp5.get(ScrollableList.class, "nameList").getItem(n).get("name").toString();
  println("Selected contributor: " + selected);
  showSingleContributor = true;
  nameL.clear();
  nameL.add(selected);
  
  nl.setOpen(true);
}

/**
* keep the scrollable list open
**/
public void controlEvent(CallbackEvent theEvent) {
  nl.setOpen(true);
}

void goToURL(){
  link(profileURL);
  profileButton.setOn();
}
