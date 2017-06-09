ArrayList<Cir> circles = new ArrayList<Cir>();
Pcir player;
float zoom = 10;
boolean keyup,keyleft,keyright,keyspace,keydown;
int gSize = 500;

void setup(){
  size(900,600);
  player = new Pcir(30); //tamaño de la bola
  for(int i = 0;i < 700;i++){
    circles.add(new Cir()); //circulos de fondo
  }
}
void draw(){
  drawGrid();
    for (int i = 0; i < circles.size(); i++)
  {
    Cir c1 = circles.get(i);
    if(c1.drw()){
      circles.remove(i);
    }
  }
  //zoom-=.011;
  player.calc();
  player.dr();

}
void drawGrid(){
  fill(255,255,255); 
  rect(1*zoom,1*zoom,width,height); //rectangulo base
  stroke(200,200,200); 
  for(float i = 0 - player.x;i < gSize - player.x;i+=10){
   line(i*zoom,1-player.y*zoom,i*zoom,height);
  }
  for(float i = 0 - player.y;i < gSize - player.y;i+=10){
    line(1-player.x*zoom,i*zoom,width,i*zoom);
  }
}

void keyPressed()
{
  if (keyCode == UP)   keyup = true;
  if (keyCode == LEFT) keyleft = true;
  if (keyCode == RIGHT)keyright = true;
  if (keyCode == DOWN) keydown = true;
  if (key == ' ')      keyspace = true;
}
void keyReleased()
{
  if (keyCode == UP)   keyup = false;
  if (keyCode == LEFT) keyleft = false;
  if (keyCode == RIGHT)keyright = false;
  if (keyCode == DOWN) keydown = false;
  if (key == ' ')      keyspace = false;
}

int gridCollx(){
  
  if(zoom*(0-player.x) > (width/2-player.mass/2)){
     return 1;
  }
  if(zoom*(gSize-player.x) < (width/2+player.mass/1.5)){ 
     return 2;
  }
  return 0;
}

int gridColly(){
  if(zoom*(0-player.y) > (height/2-player.mass/2)){
    return 1;
  }
  if(zoom*(gSize-player.y) < (height/2+player.mass/1.5)){
    return 2;
  }
  return 0;
}

class Pcir{
  float mass = 20;
  float x = 0;
  float y = 0;
  float tmpx = 0;
  float tmpy = 0;
  Pcir(int m){
     mass = m;
  }
  void mouseMov(){
    if(gridCollx() !=1 && gridCollx() !=2){
     x = x + (0.4*(mouseX - width/2)/40)/zoom/mass*250.4; 
    }
    if(gridCollx() == 1 && mouseX > width/2){
      x = x + (0.4*(mouseX - width/2)/40)/zoom*0.4;
    }
    if(gridCollx() == 2 && mouseX < width/2){
      x = x + (0.4*(mouseX - width/2)/40)/zoom*0.4;
    }
    
     if(gridColly() !=1 && gridColly() !=2){
     y = y + (0.4*(mouseY - height/2)/40)/zoom*0.8;
    }
    if(gridColly() == 1 && mouseY > height/2){
      y = y + (0.4*(mouseY - height/2)/40)/zoom*0.8;
    }
    if(gridColly() == 2 && mouseY < height/2){
      y = y + (0.4*(mouseY - height/2)/40)/zoom*0.8;
    }
     y = y + (0.4*(mouseY - height/2)/40)/zoom*0.4;
  }
  void calc(){
    if(keyup){
      if(gridColly() != 1){
        y--; 
      }
    }
    if(keydown){
      if(gridColly() != 2){
        y++; 
      }
    }
    if(keyleft){
      if(gridCollx() !=1){
        x--; 
      }
    }
    if(keyright){
      if(gridCollx() < 2){
        x++;
      } 
    }
    mouseMov();
  }
  void dr(){
    fill(200,200,200);
    ellipse(width/2,height/2,mass,mass);
  }
}
class Cir{
  float mass = 2;
  float x;
  float y;
  color col;
  Cir(){
    x = random(gSize/1.2);
    y = random(gSize/1.2);
    col = color(random(255),random(255),random(255));
  }
  boolean drw(){
   float ll = dist(zoom*(x - player.x),zoom*(y - player.y),(0 - player.x)/zoom + width/2,(0-player.y)/zoom + height/2);
   if(ll < player.mass/2.1){
     println(ll);
     player.mass+=mass;
     zoom -= mass/500;
     return true;
   }
    fill(col);
    
     ellipse(zoom*(x - player.x),zoom*(y - player.y),mass*zoom,mass*zoom);
     
     return false;
  }
}