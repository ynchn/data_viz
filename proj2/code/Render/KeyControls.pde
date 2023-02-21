/**
* Need to map to GUI
*/
void keyPressed(){
  if (keyCode == '1'){
    cam.rotateY(-PI/2);
    
  }
  if (key == '2'){
    cam.rotateY(PI/2);
  }
  if (key == '3'){
    cam.rotateX(PI/2);
  }
  if (key == '4') {
    cam.rotateX(-PI/2);
  }
  if (key == '0'){
    // move to the end of data
    cam.lookAt(150, -80, 100);
    cam.setDistance(2800);
  }
  if (key == '9'){
    // move to the middle
    cam.lookAt(150, -80, 1300);
    cam.setDistance(800);
  }
}
