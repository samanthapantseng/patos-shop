import gifAnimation.*;
PImage[] animation;
Gif loopingE1;
Gif loopingE3;

import ddf.minim.*;
Minim minim;
AudioPlayer mE1, mE2, mE3;

ArrayList<Moco> mocos;
Pato pato;
long instante, instanteRestart;
int n, espera, esperaRestart, escenario;

void setup() {
  fullScreen();  
  colorMode(HSB, 360, 100, 100);
  imageMode(CENTER);
  frameRate(60);
  
  minim = new Minim(this);  
  mE1 = minim.loadFile("mE1.mp3");
  mE2 = minim.loadFile("mE2.mp3");
  mE3 = minim.loadFile("mE3.mp3");
  
  mE1.play();
  mE1.loop();
  
  loopingE1 = new Gif(this, "loopingE1.gif");
  loopingE3 = new Gif(this, "loopingE3.gif");
  
  instante = millis();
  
  n = 0;
  mocos = new ArrayList<Moco>();
  
  pato = new Pato();
  
  escenario = 1;
  esperaRestart = 8000;
}

void draw() {
  background(#FFFBED);
   
  if (escenario == 1)
    escenario1();
  else if (escenario == 2)
    escenario2();
  else if (escenario == 3)
    escenario3();
}

void escenario1() {
  loopingE1.loop();
  image(loopingE1, width/2, height/2, width, height);
}

void escenario2() {  
  if (millis() - instante > espera && n<100) {
    Moco nuevo = new Moco();
    mocos.add(nuevo);
    n ++;
  }
  
  for (int x=0; x < mocos.size(); x++){
    Moco tmp = mocos.get(x);
    tmp.dibujar();
    tmp.mover();    
  }  
  
  pato.dibujar();
}

void escenario3() {  
  loopingE3.loop();
  image(loopingE3, width/2, height/2, width, height);  
  if (millis() - instanteRestart > esperaRestart) {
    escenario = 1;
    mE3.pause();
    mE3.rewind();
    mE1.play();
    mE1.loop();    
  }
}

void keyPressed() {    
  if (key == '1') {
    escenario = 1;
    mE3.pause();
    mE3.rewind();
    mE1.play();
    mE1.loop();
  }  
  
  else if (key == '2' && escenario == 1) {
    escenario = 2;
    pato.reinicio();
    mE1.pause();
    mE1.rewind();
    mE2.play();
    mE2.loop();
  }
  
  else if (key == '3' && escenario == 2) {
    escenario = 3;
    mE2.pause();
    mE2.rewind();
    mE3.play();
    mE3.loop();
    instanteRestart = millis();
  }   

  else if (key == CODED){
    if (keyCode == RIGHT) {
      pato.movD();
    }
    else if (keyCode == LEFT) {
      pato.movI();
    }  
  }
}

void keyReleased() {
  pato.noMov();
}