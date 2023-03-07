/**
 * Mapped to GUI
 */
 import java.awt.event.KeyEvent;
void keyPressed() {
  if (key == '1') {
    cam.rotateY(-PI/2);
    //float[] camPosVec = cam.getLookAt();

    //cam.lookAt(camPosVec[0], camPosVec[1], 1400, 800, 1000);
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
  if (key == '0') {
    // move to the end of data
    cam.lookAt(150, -80, 100);
    cam.setDistance(2800);
  }
  if (key == '9') {
    // move to the middle
    cam.lookAt(150, -80, 1300);
    cam.setDistance(700);
  }
  
  if (keyCode == 37){
    // move left
    // x--
    float[] camPosVec = cam.getLookAt();
    camPosVec[0] -= 120;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }
  if (keyCode == 39){
    // move right
    // x++
    float[] camPosVec = cam.getLookAt();
    camPosVec[0] += 120;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }

  if (keyCode == 38){
    // move up
    // z--
    float[] camPosVec = cam.getLookAt();
    camPosVec[2] -= 120;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }
  if (keyCode == 40){
    // move down
    // z++
    float[] camPosVec = cam.getLookAt();
    camPosVec[2] += 120;
    cam.lookAt(camPosVec[0], camPosVec[1], camPosVec[2]);
  }

}
