/**
* Triple class
* Coordinates (x, y, z) as a Triple Object
**/
class Triple {
  int x;
  int y;
  int z;
  
  public Triple(int x, int y, int z) {
    this.x = x;
    this.y = -y; // flip y, because pos y-axis goes downwards
    this.z = z;
  }
  
  @Override
  public boolean equals(Object obj) {
    if (!(obj instanceof Triple)) {
      return false;
    }
    Triple other = (Triple) obj;
    return this.x == other.x && this.y == other.y && this.z == other.z;
  }
  
  @Override
  public int hashCode() {
    return Objects.hash(this.x, this.y, this.z);
  }
  
  float getXCoord(){
    return float(this.x);
  }
  
  float getYCoord(){
    return float(this.y);
  }
  
  float getZCoord(){
    return float(this.z);
  }
}
