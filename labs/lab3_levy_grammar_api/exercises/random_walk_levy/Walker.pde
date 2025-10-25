float SCALE_STEP = 25; 
    
class Walker {
  PVector position;
  PVector prevPosition;
  float freq, amp, cutoff, vibrato;
  float stepsize=0;
  Walker() {
    this.position=new PVector(width/2, height/2);
    this.prevPosition=this.position.copy();    
    this.amp=0; this.vibrato=0;
    this.freq=0;
    this.cutoff=0;
  }
  
  void draw() {        
    /* Ex 1: your code here to draw*/
    //colorMode(RGB);
    //color c = color(255,255,255);
    colorMode(HSB);
    float dist_x = this.prevPosition.x -width/2;
    float dist_y = this.prevPosition.y -height/2;
    float dist = sqrt(pow(dist_x,2) + pow(dist_y,2));
    float max_dist = sqrt(pow(width/2,2) + pow(height/2,2));
    color c = color(int(255* dist/max_dist),255,255);
    stroke(c);
    strokeWeight(31- int(30*this.stepsize));
    line(this.prevPosition.x,this.prevPosition.y, this.position.x,this.position.y);
    /* Ex 3: your code here to draw with colors*/
    colorMode(RGB);
  }
  void computeEffect(){
    /* Ex 4: your code here*/
     this.freq = map(this.position.x+this.position.y, 0 ,width+height,220,420); 
     this.amp = constrain(this.stepsize, 0.1, 1);
  }
  
  void update() {    
    
    PVector step=new PVector(random(-1,1), random(-1,1));
    step.normalize();
    this.stepsize = montecarlo();   /*   - update stepsize */
    step.mult(this.stepsize * SCALE_STEP);
    this.prevPosition = this.position.copy(); /*  - update prevPosition */
    this.position.add(step);
    this.position.x = constrain(this.position.x,0, width); /*    - constrain position inside the screen*/
    this.position.y = constrain(this.position.y,0, height);
      }
}

float montecarlo() {
  float R1 = 0;
  float p = 0;
  float R2 = 0;
  while(true){
    R1 = random(1);
    R2 = random(1);
    if(MONTECARLO_STEPS==2){
      p = random(1);/* Your code here: ex. 1*/ 
    }
    else if(MONTECARLO_STEPS==1){
      /* your code here: ex. 2  */
      p = pow(R1,8); 
    }
    if(p>R2){
    return R1;
    }
  }
}
