class Mover { //controls the movement of the enemies and powerups and any other thing I choose to add
  float x, y, sx, sy;
  Mover(float x, float y) {
    this.x = x;
    this.y = y;
    this.sx = 0; //start initially with zero speed so then we can adjust speed based on specific class
    this.sy = 0;
  }
  void move() { //this is the sub class that actually implements the movements
    this.x += this.sx;
    this.y += this.sy;
  }
  boolean Done() { //if after their movement, the things end up off scree, to save space, this will help remove them later on to help with storage
    boolean d;
    if (this.x < 0 || this.x > width || this.y < 0 || this.y > height) d = true;
    else d = false;
    return d;
  }
}

class Explode { //controls the explosions that occur after collisions with the enemy
  float x, y, w, h, sx, sy;

  Explode(float x, float y, float sx, float sy) {
    this.x = x;
    this.y = y;
    this.w = 0;
    this.h = 0;
    this.sx = sx;
    this.sy = sy;
  }
  void GrowDecay() { //displays
    //controls the speed of the growing and decaying of the explosions
    this.w += this.sx; 
    this.h += this.sy;
  }
  boolean disapear() { //once the explosion has reduced/decayed, it gets rid of it
    boolean dis;
    if (this.w <= 0 && this.h <= 0) dis = true;
    else dis = false;
    return dis;
  }
}

class powerups extends Mover { //powerups class which extends the mover class and uses its variables and classes

  powerups(float x, float y) {
    super(x, y); //this is also part of the extension
    this.sx = 4;
    this.sy = 2.5;
  }
  void display() { //this displays the balls and make them move
    fill(#ACF295);
    stroke(#ACF295);
    ellipse(this.x, this.y, 20, 20);
    this.move();
    if (this.x < 100) { //this makes them go side to side
      this.sx = 2.5;
    } else if (this.x>400) {
      this.sx = -2.5;
    }
  }
  void collisions() { //if the lazers collide with them, this implements things then
    for (int i=0; i < lasers.size(); i++) {
      if (dist(lasers.get(i).x, lasers.get(i).y, this.x, this.y) < 10) {
        lasers.get(i).y = 1000; // so the the lazer gets sent off screen and then the done bolean statement will get rid of it
        Loss = Loss - 1;
        Powerup.remove(this); //removes the powerups from the screen
        spark.add(new Sparks(this.x, this.y, 3, 3)); //adds sparks
      }
    }
  }
}

class button { //this class is for all and any more buttons that will be added
  float x, y, w, h;
  button(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void display() { //displays the rectangle for the button
    rectMode(CORNER);
    rect(this.x, this.y, this.w, this.h);
  }
  boolean pressed() { //if the button is pressed code is in this class
    boolean clicked;

    if (mouseX > this.x && mouseX < this.x + this.y && mouseY > this.y && mouseY < this.y + this.h) clicked = true; //makes sure the mouse is on top of the button
    else clicked = false;

    return clicked; //returns a true or false
  }
}

class enemies extends Mover { //this is the class that controls the actual enemies and extends on mover so that the enemies move
  float radius;

  enemies(float x, float y) {
    super(x, y); //part of the mover extension
    this.sx = 0; //kept this as zero because we dont want the enemies to be moving left and right, just down, on the axis
    this.sy = 4;
    this.radius = random(15, 50); //this lets the enemies come in various sizes to make it more interesting
  }
  void display() { //displays/shows the enemies on screen and moves them
    fill(#FFFFFF);
    stroke(#FFFFFF);
    ellipse(this.x, this.y, this.radius, this.radius);
    this.move(); //calls the moveing code from mover class
  }
  void collisions() { //if the lazer collides with an ENEMY, some other things happen
    for (int i=0; i < lasers.size(); i++) {
      if (dist(lasers.get(i).x, lasers.get(i).y, this.x, this.y) < this.radius/2) {
        lasers.get(i).y = 1000;
        DisplayScore = DisplayScore + 1; //gives them points
        enemy.remove(this);
        blowup.add(new explosions(this.x, this.y, 1, 1)); //adds blowups
      }
    }
  }
}

class Laser extends Mover { //controls the lazers

  Laser(float x, float y) {
    super(x, y);
    this.sy = -4;
  }
  void display() { //displays
    this.move(); //moves the lazers but in the opposite direction of the powerups and enemies
    stroke(#FF0303);
    strokeWeight(3);
    line(this.x, this.y, this.x, this.y + this.sy);
  }
}

class explosions extends Explode { //controls the explosions that occur after collisions with the enemy

  explosions(float x, float y, float sx, float sy) {
    super(x, y, sx, sy);
  }
  void display() { //displays
    //controls the speed of the growing and decaying of the explosions
    this.GrowDecay();

    if (this.w <=0 && this.h <= 0) { //growing of the explosions
      this.sx = 1;
      this.sy = 1;
    } else if (this.w >=40 && this.h >= 40) { //decaying of the explosions
      this.sx = -1;
      this.sy = -1;
    }
    fill(#FF8000);
    stroke(#F9FA0A);
    strokeWeight(5);
    ellipse(this.x, this.y, this.w, this.h);
  }
}

class Sparks extends Explode { //controls the explosions that occur after collisions with the enemy

  Sparks(float x, float y, float sx, float sy) {
    super(x, y, sx, sy);
  }
  void display() { //displays
    //controls the speed of the growing and decaying of the sparks
    this.GrowDecay();

    if (this.w <=0 && this.h <= 0) { //growing of the explosions
      this.sx = 3;
      this.sy = 3;
    } else if (this.w >=40 && this.h >= 40) { //decaying of the explosions
      this.sx = -3;
      this.sy = -3;
    }

    fill(#B04DF7);
    stroke(#4D7FF7);
    strokeWeight(5);
    ellipse(this.x, this.y, this.w, this.h);
  }
}

float ShooterX, ShooterY, ShooterW, ShooterH;

float highscore;
float [] score = new float[2];
//used for score array
int j = 1;

int DisplayScore; //enemies hit (score)
int AttackCount;
int PowerCount;
int Loss; //missed enemied
int screen; //controls the screens of the game

ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<enemies> enemy = new ArrayList<enemies>();
ArrayList<explosions> blowup = new ArrayList<explosions>();
ArrayList<button> clicks = new ArrayList<button>();
ArrayList<powerups> Powerup = new ArrayList<powerups>();
ArrayList<Sparks> spark = new ArrayList<Sparks>();

void setup() {
  size(500, 600);
  ShooterY = 550;
  ShooterW = 30;
  ShooterH = 30;

  enemy.add(new enemies(250, 5));

  AttackCount = 50; //intervals of how long before another enemy comes down
  PowerCount = 450; //intervals of how long between the powerups coming down

  screen = 0; //start off at the beginning screen

  //initial score setup
  score[0] = -2000000000;
}

void draw () {
  background(0);
  if (screen == 0) { //screen 0 is the starting screen with the name of the game and instructions
    background(0);
    fill(#6BD1BD);
    textSize(65);
    text("Enemy Shooter", 15, 200);
    fill(#EA808E);
    textSize(40);
    text("Instructions", 20, 280);
    textSize(15);
    //instructions
    text("There will be incoming enemies\nClick on the screen to shoot lasers\nTry and destroy the enemies\nHit the green powerups to reduce your missed enemies\nIf you miss 10 enemies, the game will be over", 20, 310);

    //the start button
    fill(#2EFF52);
    //rect(200, 440, 105, 40);
    clicks.add(new button(200, 440, 105, 40)); //creates the button
    clicks.get(0).display(); //displays the button on the users screen
    fill(0);
    textSize(30);
    text("START", 205, 470);
  }
  if (screen == 1) {
    background(0);
    for (int i=0; i < lasers.size(); i++) lasers.get(i).display(); //shows and moves the lazers that are in the array list
    for (int i=0; i < lasers.size(); i++) { //runs the removing code if lazer goes off screen
      if (lasers.get(i).Done()) {
        lasers.remove(i); //removing
      }
    }

    for (int i = 0; i < enemy.size(); i++) enemy.get(i).display(); //displays the enemies in the enemy array list
    for (int i=0; i < enemy.size(); i++) { //runs the removal code but also counts the missed enemies 
      if (enemy.get(i).Done()) {
        enemy.remove(i); //removing
        Loss = Loss + 1; //counting missed enemies
      }
    }
    if (Loss == 10) { //if they miss 10 enemies, the game will end and they will go onto the other screen
      screen = 2;
    }
    for (int i = 0; i < enemy.size(); i++) enemy.get(i).collisions(); //looks for the collisions with lazers
    this.AttackCount--; //controls the variable so that the enemies come down slowly and not all at one time
    if (this.AttackCount <= 0) {
      this.AttackCount = int(random(30, 100)); //after the first one, it will pick random distances/intervals
      enemy.add(new enemies(random(10, 490), 5)); //adds another enemy to come down
    }

    for (int i = 0; i < Powerup.size(); i++) Powerup.get(i).display(); //displays the powerups on the user screen
    for (int i=0; i < Powerup.size(); i++) { //runs the removal code for the powerups if they go off screen
      if (Powerup.get(i).Done()) {
        Powerup.remove(i); //removing
      }
    }
    for (int i = 0; i < Powerup.size(); i++) Powerup.get(i).collisions();
    this.PowerCount--;
    if (this.PowerCount <= 0) {
      this.PowerCount = 450; //controls the variable so that the powerups leave a long gap between eachother 
      Powerup.add(new powerups(random(10, 490), 5)); //adding new powerup
    }

    for (int i=0; i < blowup.size(); i++) blowup.get(i).display(); //shows the blowups
    for (int i=0; i < blowup.size(); i++) { //helps remove the blowup from its array once the blow up decays
      if (blowup.get(i).disapear()) {
        blowup.remove(i); //removing from array list
      }
    }

    for (int i=0; i < spark.size(); i++) spark.get(i).display(); //shows the blowups
    for (int i=0; i < spark.size(); i++) { //helps remove the spark from its array once the spark decays
      if (spark.get(i).disapear()) {
        spark.remove(i); //removing from array list
      }
    }

    //code to control the shooter with mouse
    fill(#91F7F5);
    rectMode(CENTER);
    rect(mouseX, ShooterY - 20, ShooterW - 10, ShooterH + 10);
    ellipseMode(CENTER);
    ellipse(mouseX, ShooterY, ShooterW, ShooterH);
    //displaying the score and missed enemies on the top left corner for the user to see and know
    fill(255);
    textSize(20);
    text("Enemies Hit: " + DisplayScore, 20, 50);
    text("Enemies Missed: " + Loss, 20, 100);
  }
  if (screen == 2)
  {
    background(#EA3247); //red
    score[j] = DisplayScore;

    fill(0);
    textSize(65);
    text("GAME OVER\nYou Lose", 50, 130); 
    textSize(35);
    //displays the score from curent round of game
    text("Your score is: " + score[j], 50, 300);

    //highscore code 
    if (score[j] >= score[j-1])
    {
      if (score[j]>=highscore)
      {
        highscore = score[j];
        text("HighScore: " + highscore, 50, 350);
      } else if (score[j] < highscore) {
        //highscore = highscore;
        text("HighScore: " + highscore, 50, 350);
      }
    } else if (score[j] < score[j-1])
    {
      if (score[j-1]>=highscore)
      {
        highscore = score[j-1];
        text("HighScore: " + highscore, 50, 350);
      } else if (score[j-1] < highscore) {
        //highscore = highscore;
        text("HighScore: " + highscore, 50, 350);
      }
    }
    //creating/displaying the play again button
    fill(#72D85E);//green button
    stroke(#ACF295);//green stroke
    clicks.add(new button(170, 445, 150, 50)); //adding the rectangle for the button to the array list
    clicks.get(1).display(); //showing the button on the screen
    fill(0);
    textSize(18);
    text("Play Again", 205, 465); //text for the button
  }
}

void mousePressed() {
  if (screen == 0) {
    //if the start button is clicked
    if (clicks.get(0).pressed()) {
      screen = 1;
    }
  }
  if (screen == 1) {
    lasers.add(new Laser(mouseX, ShooterY));
  }
  if (screen == 2) {
    if (clicks.get(1).pressed()) {
      Loss= 0;
      DisplayScore = 0;
      screen = 1;
    }
  }
}
