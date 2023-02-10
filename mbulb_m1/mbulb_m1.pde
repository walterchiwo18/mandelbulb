int DIM = 64;
float yRotate = 0;
float xRotate = 0;
float cubeSize = 1;
float space = 300;
float constraints = 0;
float n = 8;
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

void setup() {
  size(displayWidth, displayHeight, P3D);


  for (int i = 0; i < DIM; i++) {
    for (int j = 0; j < DIM; j++) {
      boolean edge = true;
      for (int k = 0; k < DIM; k++) {
        float x = map(i, 0, DIM, -cubeSize, cubeSize);
        float y = map(j, 0, DIM, -cubeSize, cubeSize);
        float z = map(k, 0, DIM, -cubeSize, cubeSize);
        PVector zeta = new PVector(0, 0, 0);
        PVector powerZeta;

        int maxIteration = 10;
        int iteration = 0;



        while (true)
        {
          spherePVector sphereVoxel = cartToSphere(zeta.x, zeta.y, zeta.z);
          powerZeta = powerSphere(sphereVoxel.r, sphereVoxel.theta, sphereVoxel.phi, n);

          zeta.x = powerZeta.x + x;
          zeta.y = powerZeta.y + y;
          zeta.z = powerZeta.z + z;

          iteration++;
          n += 1;


          if (sphereVoxel.r > 2 )
          {
            if (edge)
            {
              edge = false;
            }
            break;
          }

          if (iteration > maxIteration) {

            if (!edge) {
              edge = true;
              mandelbulb.add(new PVector(x*space, y*space, z*space)); //* width, y * width, z * width));
              break;
            }

            break;
          }
        }
      }
    }
  }
}

spherePVector cartToSphere(float x, float y, float z) {

  float r = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
  float theta = atan2(sqrt(pow(x, 2)+ pow(y, 2)), z);
  float phi = atan2(y, x);
  return new spherePVector(r, theta, phi);
}

PVector powerSphere(float r, float theta, float phi, float n) {
  float newX = pow(r, n) * sin(theta * n) * cos(phi * n);
  float newY = pow(r, n) * sin(theta * n) * sin(phi*n);
  float newZ = pow(r, n) * cos(theta * n);

  return new PVector(newX, newY, newZ);
}

class spherePVector {
  float r, theta, phi;
  spherePVector (float r, float theta, float phi) {
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  pushMatrix();
  //rotateY(degrees(yRotate+= .00007));
  rotateX(degrees(xRotate += .00001));
  for (PVector v : mandelbulb) {
    stroke(255);
    strokeWeight(3);
    point(v.x, v.y, v.z);
  }
  popMatrix();
}    
