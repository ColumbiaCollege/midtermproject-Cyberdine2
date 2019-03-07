Target[] Frosty = new Target[10];


//for (int i = 0; i<5; i++) {
// float x;
//  x = random(1,6);

///}
PImage duck;
PImage duck2;
PImage grass;
public int points;
int level =0;
float highBound;
float lowBound;
boolean levelBounce;
int ammo = 15;
int screen =0;

void setup() {
  imageMode(CENTER);
  duck = loadImage("duck4flipped.JPG");
  duck2 = loadImage("duck4.JPG");
  grass = loadImage("grasscut.JPG");
  size(1920, 480);
  levelBounce = false;
  lowBound =1;
  highBound =5;
  for (int i = 0; i<10; i++) {
    Frosty[i] = new Target(lowBound, highBound);
  }
}


void draw() {
  switch(screen) {

  case 0:
    background(#44AFF8); 
    textSize(24);
    text(points, width/8, height/12);
    text(ammo, 7*width/8, height/12);
    for (int i = 0; i<10; i++) {
      Frosty[i].display();
      Frosty[i].move();
      Frosty[i].bounce();
    }

    image(grass, 1000, 500, width+100, height/2);

    //this switches levels every 10 ducks killed
    if (levelBounce == false && points != 0 && (points % 100) == 0) {
      lowBound = lowBound + 1;
      highBound = highBound + 1;
      repopulate();
      level++;
      levelBounce= true;
    }

    break;


  case 1:
    background(0);
    fill(#B70205);
    textSize(48);
    text("GameOver", width/2, height/2);
    break;
  }
}

void mouseReleased() {
  for (int i = 0; i<10; i++) {
    Frosty[i].clicked();
  }
  ammo = ammo -1;
  if (ammo == 0) {
    screen =1;
  }
}

void repopulate() {
  for (int i = 0; i<10; i++) {
    Frosty[i] = new Target(lowBound, highBound);
  }
  level++;
  ammo = 15+(level*2);
}






























public class Spaceship {
  
  PImage[] imageArray;
  float x;
  float y;
  float Vspeed;
  float Hspeed;
  int framecounter;
  int drawframe;
  boolean dead;

  Spaceship(float lowBound, float highBound) {
    imageArray = new PImage[10]; 
    x = random(width);
    y = random(height);
    Hspeed = random(lowBound, highBound);
    Vspeed = random(lowBound, highBound);
    drawframe = 0;
    framecounter = 0;
  }
  
  void display() {

    framecounter++;
    framecounter = framecounter % 6;
    if (framecounter ==0) {
      drawframe++;
      drawframe = drawframe % 10;
    }

    switch(drawframe) {
    case 0: 
      image(imageArray[0], x, y); 
      break;
    case 1: 
      image(imageArray[1], x, y);
      break;
    case 2: 
      image(imageArray[2], x, y);
      break;
    case 3: 
      image(imageArray[3], x, y);
      break;
    case 4: 
      image(imageArray[4], x, y);
      break;
    case 5: 
      image(imageArray[5], x, y);
      break;
    case 6: 
      image(imageArray[6], x, y);
      break;
    case 7: 
      image(imageArray[7], x, y);
      break;
    case 8: 
      image(imageArray[8], x, y);
      break;
    case 9: 
      image(imageArray[9], x, y);
      break;
    }
  }

  void bounce() {

    if (!dead) {
      if (y > height ||  y < 0) {
        Vspeed = -1*Vspeed;
      }
    }

    if (x > width || x < 0) {
      Hspeed = -1*Hspeed;
    }
  }

  void move() {
    x = x + Hspeed;
    y = y + Vspeed;
  }

  void clicked() {
    if (mouseX < x + width/2 && mouseX > x - height/2 && mouseY < y + width/2 && mouseY > y - height/2) {
      Vspeed = 10; 
      Hspeed = 0;
      dead = true;
      points = points +10;
      levelBounce = false;
    }
  }
}










public class Target {
  float x;
  float y;
  float Hspeed;
  float Vspeed;
  float Diameter;
  boolean dead;
 



  Target(float lowBound, float highBound) {
    x = random(width);
    y = random(height);
    Hspeed = random(lowBound, highBound);
    Vspeed = random(lowBound, highBound);
    Diameter = 50;
  }

  void display() {
    fill(#FC0000);
    if (Hspeed > 0) {

      image(duck, x, y, Diameter, Diameter);
    } else {
      image(duck2, x, y, Diameter, Diameter);
    }
  }

  void bounce() {

    if (!dead) {
      if (y > height ||  y < 0) {
        Vspeed = -1*Vspeed;
      }
    }

    if (x > width || x < 0) {
      Hspeed = -1*Hspeed;
    }
  }

  void move() {
    x = x + Hspeed;
    y = y + Vspeed;
  }

  void clicked() {
    if (mouseX < x + Diameter/2 && mouseX > x - Diameter/2 && mouseY < y + Diameter/2 && mouseY > y - Diameter/2) {
      Vspeed = 10; 
      Hspeed = 0;
      dead = true;
      points = points +10;
      levelBounce = false;
    }
  }
}
