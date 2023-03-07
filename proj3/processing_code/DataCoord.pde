/**
* DataCoord class
**/

public final class DataCoord {
  int xCoord;
  int yCoord;
  int zCoord;
  
  // 1XX,YY,ZZZ
  // X*100,000 + Y*1000 + Z
  int keyCoord;
  
  DataCoord(float x, float y, float z){
    this.xCoord = int(x);
    this.yCoord = int(y);
    this.zCoord = int(z);
    
    this.keyCoord = xCoord*100000 + yCoord*1000 + zCoord;
  }
  
  int getKeyCoord(){
    return this.keyCoord;
  }
}
  
  //@Override
  //public boolean equals(Object obj){
  //  if (this == obj) return true;
  //  if (obj == null || getClass() != obj.getClass()) return false;
    
  //  DataCoord dc = (DataCoord) obj;
    
  //  if ((int.compare(dc.xCoord, xCoord) != 0) || (int.compare(dc.yCoord, yCoord) != 0) || (int.compare(dc.zCoord, zCoord) != 0)){
  //    return false;
  //  }
  //  else{
  //    return true;
  //  }
    
  //}
  
  //@Override
  //public int hashCode(){
  //  int 
  //}

  //  @Override
  //  public int hashCode() {
  //    int result;
  //    long temp;
  //    temp = Double.doubleToLongBits(lat);
  //    result = (int) (temp ^ (temp >>> 32));
  //    temp = Double.doubleToLongBits(lon);
  //    result = 31 * result + (int) (temp ^ (temp >>> 32));
  //    return result;
  //  }

//class DataPoint{
//  float xCoord;
//  float yCoord;
//  float zCoord;
  
//  // number of patterns that have the same dimensions and num_colors
//  int numPatterns = 0;
  
//  ArrayList<Pattern> patterns_thisPos = new ArrayList<Pattern>();
  
//  /**
//  * DataPoint class constructor
//  */
//  DataPoint(float x, float y, float z, Pattern p){
//    this.xCoord = x;
//    this.yCoord = y;
//    this.zCoord = z;
    
//    if (patterns_thisPos.isEmpty()){
//      this.numPatterns = 1;
//    }
//    else{
//      this.numPatterns++;
//    }
//    patterns_thisPos.add(p);
//  }
//}
