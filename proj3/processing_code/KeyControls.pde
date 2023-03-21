/**
 * TODO: map to GUI
 */
import java.awt.event.KeyEvent;
boolean isLooping = true;

void keyPressed() {
  if (key == '1') {
    cam.rotateY(-PI/2);
  }
  if (key == '2') {
    cam.rotateY(PI/2);
  }
  if (key == '3') {
    cam.rotateX(PI/2);
  }
  if (key == '4') {
    cam.rotateX(-PI/2);
  }
  
  if (keyCode == 37){
    // move left
    // x--
    float[] camPosVec = cam.getLookAt();
    camPosVec[0] -= 50;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }
  if (keyCode == 39){
    // move right
    // x++
    float[] camPosVec = cam.getLookAt();
    camPosVec[0] += 50;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }

  if (keyCode == 38){
    // move up
    // y--
    float[] camPosVec = cam.getLookAt();
    camPosVec[1] -= 50;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }
  if (keyCode == 40){
    // move down
    // y++
    float[] camPosVec = cam.getLookAt();
    camPosVec[1] += 50;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }
    if (keyCode == 87){
    // W
    // z--
    float[] camPosVec = cam.getLookAt();
    camPosVec[2] -= 50;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }
  if (keyCode == 83){
    // S
    // z++
    float[] camPosVec = cam.getLookAt();
    camPosVec[2] += 50;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }
  
}

void mousePressed() {
  if (mousePressed && (mouseButton == RIGHT)) {
    selectHighlight = false;
    showSingleContributor = false;
    selected = "";
    nameL.clear();
    profileButton.hide();
  }
}
