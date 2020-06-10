import java.lang.*;


ArrayList<PVector> points;    // points which are plotted
float m=1;                    //slope of the line
float b=0;                    //y intercept of the line 
int flag = 0;                  //True for gradient descent and False for least square 

void setup(){
  size(680,680);
  background(255);
  points = new ArrayList<PVector>();
}


void draw(){
  background(255);
  drawPoints();
  try{
    if(flag == 0){
      fill(0);
      textAlign(CENTER);
      textSize(30);
      text("Least Square",width/2,50);
      leastSqure();
      textSize(20);
      text("Press UP: Least Square DOWN:Batch Gradient Descent \n LEFT:Stochastic Gradient Descent RIGHT:Mini-Batch Gradient Descent ",width/2,height-50);
     }
     else if(flag==1){
      fill(0);
      textAlign(CENTER);
      textSize(30);
      text("Batch Gradient Descent",width/2,50);
      gradientDescent();
      textSize(20);
      text("Press UP: Least Square DOWN:Batch Gradient Descent \n LEFT:Stochastic Gradient Descent RIGHT:Mini-Batch Gradient Descent ",width/2,height-50);
     }
    else if(flag==2){
      fill(0);
      textAlign(CENTER);
      textSize(30);
      text("Stochastic Gradient Descent",width/2,50);
      stochasticGradientDescent();
      textSize(20);
      text("Press UP: Least Square DOWN:Batch Gradient Descent \n LEFT:Stochastic Gradient Descent RIGHT:Mini-Batch Gradient Descent ",width/2,height-50);
     }
    else if(flag==3){
      fill(0);
      textAlign(CENTER);
      textSize(30);
      text("Mini-Batch Gradient Descent",width/2,50);
      minigradientDescent();
      textSize(20);
      text("Press UP: Least Square DOWN:Batch Gradient Descent \n LEFT:Stochastic Gradient Descent RIGHT:Mini-Batch Gradient Descent ",width/2,height-50);
     }

  }catch(Exception e){  
      e.printStackTrace();
  }
  drawLine();     // drawing a line
}


//Gradient Descent Method
void gradientDescent() throws Exception{
  float learning_rate = 0.01;
  
  for(PVector point : points){
    float x = point.x;
    float y = point.y;
    float guess = (m*x) + b;
    float error = y - guess;
    m = m + (error*x) * learning_rate;    // m is the slope of the line
    b = b + error * learning_rate;        // y intercept of the line
  }
}


//Mini-Batch Gradient Descent Method
void minigradientDescent() throws Exception{
  float learning_rate = 0.01;
  int batch_size=8;
  for(PVector point : points){
    float x = point.x;
    float y = point.y;
    for(int i=0;i<batch_size;i++){
    float guess = (m*x) + b;
    float error = y - guess;
    m = m + (error*x) * learning_rate;    // m is the slope of the line
    b = b + error * learning_rate;        // y intercept of the line
    }
  }
}


//Stochastic Batch Gradient Descent Method
void stochasticGradientDescent() throws Exception{
  float learning_rate = 0.01;
  int batch_size=1;
  for(PVector point : points){
    float x = point.x;
    float y = point.y;
    for(int i=0;i<batch_size;i++){
    float guess = (m*x) + b;
    float error = y - guess;
    m = m + (error*x) * learning_rate;    // m is the slope of the line
    b = b + error * learning_rate;        // y intercept of the line
    }
  }
}

//Least Square Method
void leastSqure() throws Exception{

  float xmean = 0, ymean = 0;
  for(PVector point: points){
    xmean += point.x/points.size();
    ymean += point.y/points.size();
  }

  float numerator = 0,denominator = 0;
  for(PVector point : points){
    numerator += (point.x-xmean)*(point.y-ymean);
    denominator += (point.x-xmean)*(point.x-xmean);
  }
  m = numerator/denominator;    // m slope of the line
  b = ymean - (m*xmean);        // y intercept of the line
  
}
 
  
// draws a line  
void drawLine(){
  
  //First Point
  float x1 = 0;
  float y1 = (m*x1) + b;
  x1 = map(x1,0,1,0,width);
  y1 = map(y1,0,1,height,0);
  
  //Second Point
  float x2 = 1;
  float y2 = (m*x2) +b;
  x2 = map(x2,0,1,0,width);
  y2 = map(y2,0,1,height,0);
  
  stroke(0,0,255);
  line(x1,y1,x2,y2);
}

// draws Points on the canvas
void drawPoints(){
  for(PVector point:points){
    fill(0,255,0);
    ellipseMode(CENTER);
    float x = map(point.x,0,1,0,width);
    float y = map(point.y,0,1,height,0); 
    ellipse(x,y,20,20);
  }
}


//Mouse Events
void mousePressed(){
  float x = map(mouseX,0,width,0,1);
  float y = map(mouseY,0,height,1,0);
  points.add(new PVector(x,y));
}


//Keyboard Events
void keyPressed(){
  if(keyCode == UP){
    for(int i = points.size()-1;i>=0;i--){
      points.remove(i);
    }
    flag = 0;
  }
  else if(keyCode == DOWN){
    for(int i = points.size()-1;i>=0;i--){
      points.remove(i);
    }
    flag = 1;
  }
  else if(keyCode == LEFT){
    for(int i = points.size()-1;i>=0;i--){
      points.remove(i);
    }
    flag = 2;
  }
  else if(keyCode == RIGHT){
    for(int i = points.size()-1;i>=0;i--){
      points.remove(i);
    }
    flag = 3;
  }
}
