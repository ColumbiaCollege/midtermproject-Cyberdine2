/*A lot of this game was mostly with the help of Chris and has a fairly simple idea. 
 I started with needing to make moving clickabe pads or "Targets"
 */

Target[] Frosty = new Target[10];
//We named those targets Frosty
Spaceship[] imageArray = new Spaceship[10];
//Then I named some new Targets (clickable pads) i named "Spaceships" and "Frosty". These are all used as objects.
/// and the "Spaceships" are not clickable yet.
PImage duck;
PImage duck2;
//Since this game is based onNintendo Duckhunt we loaded PImages caled "duck1" and "duck2"
//these PImages replaced the filed ellipses i started with with nintendoducks from google.
PImage grass;
public int points;
int level =0;
float highBound;
float lowBound;
boolean levelBounce;
int ammo = 15;
//I needed a way to lose, so chriss recommended some ammo. Since this is involved with many of the games
//I luv and enjoy I thuroughly agreed it needed ammo. Eventually the ships I'd like 
//to get more ammo too.... But for now proof of concpt ships can move and animte
//but will have a ussfull funtion to the game as well
int screen =0;
//This is where we set the screen as a number value for the switch method to function.


void setup() {
  imageMode(CENTER);
  duck = loadImage("duck4flipped.JPG");
  duck2 = loadImage("duck4.JPG");
  grass = loadImage("grasscut.JPG");
  //here we loaded our images that will be used for later and the will be caed duck1, duck2, and grass.



  size(1920, 480);
  levelBounce = false;
  lowBound =1;
  highBound =5;
  for (int i = 0; i<10; i++) {
    //expect objects and they will be as an array
    Frosty[i] = new Target(lowBound, highBound);
    imageArray[i] = new Spaceship(lowBound, highBound);
  }
}


void draw() {
  switch(screen) {

  case 0:
    background(#44AFF8); 
    textSize(24); //sets test to24
    text(points, width/8, height/12); // Divides tottal width by 8 and total height by 12 and prints.
    text(ammo, 7*width/8, height/12); //same for this
    for (int i = 0; i<10; i++) {
      Frosty[i].display(); //these are how my methods are called on for my objects
      Frosty[i].move();    //and what they will do
      Frosty[i].bounce();      

      imageArray[i].display();
      imageArray[i].move();
      imageArray[i].bounce(); ///down to here
    }

    image(grass, 1000, 500, width+100, height/2);

    //this switches levels every 10 ducks killed *this was chriss's too 10 ducks way toprogress lol :)
    if (levelBounce == false && points != 0 && (points % 100) == 0) {
      lowBound = lowBound + 1;
      highBound = highBound + 1;
      repopulate();
      level++;
      levelBounce= true;
      //This will print as a text value later, my levels are progressing a litte strangly when i try.
      //goes 0, 3, 6 for now not 1,2,3
    }

    break;


  case 1:
    //end game case for switch method, this is the gameover case and this is what changes the screens to game over..
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
    //This is how the objects that are technicly all the "targets" are clicked and hopefully "Spaceships"
  }
  ammo = ammo -1;
  if (ammo == 0) {
    screen =1;
    //no matter what when the mouse is pressed and released this wil reduce the number value which is ammo set above
  }
}

void repopulate() {
  for (int i = 0; i<10; i++) {
    Frosty[i] = new Target(lowBound, highBound); //spwns new ducks on next level
  }
  level++;
  ammo = 15+(level*2); //gives 15 more ammo on next level
}

public class Spaceship {
  //back to some objects again. here are what wi be expecte for my Spaceship
  PImage[] imageArray;
  //This  shoud work like a flipbook of severa progressive renderings of a Spaceship
  //to animate "Nightmare Before Christmas" style renderings with Rhino3d and Vray
  //to make #D modes into flat 2d images for 2d processing.
  float x;
  float y;
  //my x an y floats for a randomized position
  float Vspeed;
  float Hspeed;
  //the horizonta speed and vertical speed floats
  int framecounter;
  int drawframe;
  boolean dead;
  //how we know a duck has ciesed to excist anymore, this should work the same for ships?
  float highbound;
  float lowbound;

  Spaceship(float lowBound, float highBound) {
    imageArray = new PImage[10]; 
    //this is where a ship gets spawned in a random position
    x = random(width);
    y = random(height);
    Hspeed = random(lowBound, highBound); //this is how horizontal speed is random
    Vspeed = random(lowBound, highBound); //this is how verticl speed is randomized
    drawframe = 0;
    framecounter = 0;
    lowbound =1;
    highbound =5;




//Iamges where in series every 6 degrees equaling 60 renders, those where divided again
//by 6 giving use 10 images to work with  modulo that clls the next in the array evey 10 frames
//drawn.
    imageArray[0] = loadImage("1.jpg");
    imageArray[1] = loadImage("2.jpg");
    imageArray[2] = loadImage("3.jpg");
    imageArray[3] = loadImage("4.jpg");
    imageArray[4] = loadImage("5.jpg");
    imageArray[5] = loadImage("6.jpg");
    imageArray[6] = loadImage("7.jpg");
    imageArray[7] = loadImage("8.jpg");
    imageArray[8] = loadImage("9.jpg");
    imageArray[9] = loadImage("10.jpg");
  }

  void display() {
    //This is how Chris showed me a modulo and explained with several equations to try 
    //then understand how to solve. which is how a number divides into another and the
    //result is the remainder of numbers that could not be divied anymore so we did this with
    //my framecount so we could maintain 60fps and my flipbook of renderings
    //could use %10 of the speed of tottal frames drawn
    framecounter++;
    framecounter = framecounter % 6;
    if (framecounter ==0) {
      drawframe++;
      drawframe = drawframe % 10;
    }

    switch(drawframe) {

      //this is my array of renderings of a spinning model UFO
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

    if (!dead) { //if my ducks are not dead this is how they wrap or bounce in the box by multiplying by a negitive
      //these re my vertical movements.
      if (y > height ||  y < 0) {
        Vspeed = -1*Vspeed;
      }
    }

    if (x > width || x < 0) {
      Hspeed = -1*Hspeed; //same multiplication for horizontal movement
    }
  }

  void move() {
    x = x + Hspeed;
    y = y + Vspeed;
    //this is how my vertical movement and vertical movements are made random speeds
    //as Hspeed nd Vspeed are rndomized below
  }

  void clicked() {
    if (mouseX < x + width/2 && mouseX > x - height/2 && mouseY < y + width/2 && mouseY > y - height/2) {
      Vspeed = 10; 
      //this is where a duck dies. When my Terget objects are clicked
      //this is for when my pads or duckas are clcked within x and y position /2
      Hspeed = 0;
      dead = true;
      //this sets them to dead 
      points = points +10;
      //and this means they're worth 10 points
      levelBounce = false;
    }
  }
}



public class Target {
  //here are all these targs I keep rambling about and are litterlly the ones called Targets
  //since these were the initial examples of wht  target willl be and how they work.
  //Following up i also found touchpad options in processing website, may also be implemented
  //in more ways than one... maybe combinations of touches to get ship or others random
  //objects? XD more cool stuff to do always = more fun, i'm not that creative but
  //we'll see where this goes i hope. For future expansions
  float x;
  float y;
  float Hspeed;
  float Vspeed;
  float Diameter;
  boolean dead;




  Target(float lowBound, float highBound) {
    //this is how the clickble pads are spawned into a ranom height and width
    x = random(width);
    y = random(height);
    //These are targets they work how the ships will and partially do later, but all
    //clickable objects works sme except ships are animated more.
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

    if (!dead) { //once again "if not dead" bounce off edge of screen
      if (y > height ||  y < 0) {
        Vspeed = -1*Vspeed;
      }
    }

    if (x > width || x < 0) { //bounce bounce bounce!!!
      Hspeed = -1*Hspeed;
    }
  }

  void move() {
    x = x + Hspeed;
    y = y + Vspeed; //random x and y speeds plus movement. x and y are doing thing we want them used here
  }

  void clicked() {
    //clicking in the targes (which is actually mouse released)
    if (mouseX < x + Diameter/2 && mouseX > x - Diameter/2 && mouseY < y + Diameter/2 && mouseY > y - Diameter/2) {
      Vspeed = 10; 
      Hspeed = 0;
      dead = true;
      //make one dead duck
      points = points +10;
      //worth 10 points like most all good things worth hitting
      levelBounce = false;
    }
  }
}
