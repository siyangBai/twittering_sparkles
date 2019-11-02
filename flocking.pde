PGraphics mygra;
Flock flock;

import processing.sound.*;
SoundFile file;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];
int m;
int n;

void setup() {
  
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "birdssing.mp3");
  file.play();
   
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(file);
  
  size(640, 480);
  flock = new Flock();
  // Add an initial set of boids into the system
  //for (int i = 0; i < 5; i++) {
  // flock.addBoid(new Boid(width/2,height/2,0,1));
   //flock.addBoid(new Boid(0,0));begin position
  //} 
}


void draw() {
  background(50);
  m=millis()/1000-6;
 timeline(m);
 flock.run();
}


// Add a new boid into the System
int presspattern = 0;
int count = 0;
float volumn = 0;
//void mousePressed() {
//  fft.analyze(spectrum);
//  volumn =spectrum[0]*100;
//  count +=1;
//  presspattern = count%5;
//  flock.addBoid(new Boid(mouseX,mouseY,presspattern,volumn));

//    }



void timeline(int m){
  //if (m>7&&m<17){  
  //fft.analyze(spectrum);
  //volumn =spectrum[0]*100;
  ////count +=1;
  ////presspattern = count%5;
  //presspattern =0;
  //flock.addBoid(new Boid(mouseX,mouseY,presspattern,volumn));
  // }
  if (m<9){flock.triger(0);
   }
  if (m>8&&m<22){flock.triger(1);
   }
  if (m>21&&m<24){flock.triger(2);
   }
  if (m>23&&m<26){flock.triger(3);
   }
  if (m>25&&m<38){flock.triger(4);
   } 
  if (m>37&&m<41){flock.triger(0);
   }
  if (m>40&&m<46){flock.triger(1);
   }
  if (m>45&&m<50){flock.triger(2);
   } 
  if (m>49&&m<56){flock.triger(3);
   }
  if (m>55&&m<60){flock.triger(4);
   } 
  if (m>59&&m<63){flock.triger(0);
   }
  if (m>62&&m<68){flock.triger(1);
   } 
  if (m>67&&m<73){flock.triger(2);
   }    
}

//void delete(){

//   for (int i = boids.size()-1; i >= 0; i--) {
//    Boid b = (Boid) boids.get(i);  
//  if (b.lifespann < 0.0) {
//    flock.deleteBoid()
//      }
//   }
//}
 

 
 
 float M=0;
 float N=0;


// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }
  
  void triger(int n) {
  fft.analyze(spectrum);
  volumn =spectrum[0]*100;
  presspattern = n;
if(spectrum[0]*100>0.05
&&millis()%2>0&&millis()%2<2
){flock.addBoid(new Boid(M,N,presspattern,volumn*1.2));}

    }
    
  void run() {
    
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
    for (int i = boids.size()-1; i >= 0; i--) {
      Boid p = boids.get(i);
      //p.run();
      if (p.isDead()) {
        boids.remove(i);
      }
    }
    
    
    //for (Boid b : boids) {
    //  b.run(boids);  // Passing the entire list of boids to each boid individually
    //}
  }
   
  void addBoid(Boid b) {
    boids.add(b);
  }

  
  //void deleteBoid() {
  //  for (int i = boids.size()-1; i >= 0; i--) {
  //    Boid p = Boid.get(i);
  //    p.run();
  //    if (p.isDead()) {
  //      Boid.remove(i);
  //    }
  //  }
  //}
  


}

  


// The Boid class

class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float lifespan;
  float lifespann;
  int birdtype;

    Boid(float x, float y, int t, float v) {
      
    birdtype = t;
    
    acceleration = new PVector(0, 0);
    
    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = 2*v;
    maxspeed = 2;
    maxforce = 0.03;
    //i=i+1;
    lifespan=255;
    lifespann=255;

  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render(boids);
    //delete(boids);
    
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    lifespan-=0.3;
    lifespann-=0.3;

  }
  


  // Is the particle still useful?
  boolean isDead() {
    if (lifespann < 0.0) {
      return true;
    } else {
      return false;
    }
  }
  
  
  

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render(ArrayList<Boid> boids) {
    float theta = velocity.heading2D() + radians(90);
    if (birdtype >3) {  
     M=width*2/3;
     N=height/5;
    // Draw a triangle rotated in the direction of velocity  
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    fill(50,255,255,lifespan);
   // fill(200, 100);
    stroke(50,255,255,lifespan);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
     }
     
    if (birdtype>2&&birdtype<4){
    M=width*6/7;
    N=height/4;
    fill(242,155,118,lifespan/2);
    stroke(242,155,118,lifespan);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
     }
     
    if (birdtype>1&&birdtype<3){
    M=width*3/7;
    N=height*1/4;
          fill(250,246,138,lifespan);
   // fill(200, 100);
    stroke(250,246,138,lifespan);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
     }
    if (birdtype>0&&birdtype<2){    
    M=width*5/7;
    N=height*2/5;
    fill(73,116,239,lifespan);
    stroke(73,116,239,lifespan);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
     }
    if (birdtype<1){
    M=width*4/7;
    N=height*3/4;
    fill(255,255,255,lifespan);
   // fill(200, 100);
    stroke(255,255,255,lifespan);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
     }
 }




  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  
  
  
  
  
}
