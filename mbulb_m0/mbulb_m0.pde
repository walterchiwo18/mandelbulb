import peasy.*;

int DIM = 32;
PeasyCam cam;

void setup() {
  size(500, 500, P3D);
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  //translate(width/2, height/2);
  for (int i = 0; i < DIM; i++) {
    for (int j = 0; j < DIM; j++) {
      for (int k = 0; k < DIM; k++) {
        float x = map(i, 0, DIM, -100, 100);
        float y = map(j, 0, DIM, -100, 100);
        float z = map(k, 0, DIM, -100, 100);

        float r = sqrt(x*x + y*y + z*z);
        float theta = atan2(sqrt(x*x + y*y), z);
        float phi = atan2(x, y);



        stroke(255);
        point(x, y, z);
      }
    }
  }
}
