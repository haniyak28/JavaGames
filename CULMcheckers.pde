//this class controls the explosions and sparks classes
class Explode { //controls the explosions that occur after collisions with the powerup circles
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
    this.w += this.sx; //w = w +sx;
    this.h += this.sy;
  }
  boolean disapear() { //once the explosion has reduced/decayed, it gets rid of it
    boolean dis;
    if (this.w <= 0 && this.h <= 0) dis = true;
    else dis = false;
    return dis;
  }
}

class explosions extends Explode { //controls the explosions that occur after collisions with the powerups

  explosions(float x, float y, float sx, float sy) {
    super(x, y, sx, sy); //extensions of the eplode class
  }
  void display() { //displays
    //controls the speed of the growing and decaying of the explosions
    this.GrowDecay();

    if (this.w <=0 && this.h <= 0) { //growing of the explosions
      this.sx = 0.1;
      this.sy = 0.1;
    } else if (this.w >=250 && this.h >= 250) { //decaying of the explosions
      this.sx = -0.1;
      this.sy = -0.1;
    }
    fill(#FF8000);
    stroke(#F9FA0A);
    strokeWeight(8);
    ellipse(this.x, this.y, this.w, this.h); //circular explosion
  }
}

class spark extends Explode { //controls the explosions that occur after collisions with the powerups

  spark(float x, float y, float sx, float sy) {
    super(x, y, sx, sy); //extension of the class explode
  }
  void display() { //displays
    //controls the speed of the growing and decaying of the sparks
    this.GrowDecay();

    if (this.w ==0 && this.h == 0) { //growing of the sparks
      this.sx = 1;
      this.sy = 1;
    } else if (this.w >=50 && this.h >= 50) { //decaying of the sparks
      this.sx = -1;
      this.sy = -1;
    }
    fill(#FF0808);
    stroke(#580909);
    strokeWeight(8);
    rectMode(CENTER);
    rect(this.x, this.y, this.w, this.h); //square explosion
  }
}


void time() { //function to create the timer on the bottom right of the screen
  fill(0);
  textSize(15);
  text(time[2], 402, 480); //minuites
  text(":", 414, 480);
  text(time[1], 420, 480); //seconds
  //text(":", 437, 480);
  //text(time[0], 443, 480); //milliseconds

  time[0] = time[0] + 1;
  if (time[0] == 10) { //should be a 100 but the timer works more accurately with 10 milliseconds
    time[1] = time[1] + 1;
    time[0] = 0;
    if (time[1] == 60) {
      time[2] = time[2] + 1;
      time[1] = 0;
      time[0] = 0;
    }
  }
}

//class that controls the next 3 classes of powerups, black pieces, and white pieces
class Circles {
  float x, y;
  int row, col;
  int radius; //controls the size of the circles

  Circles(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void show() { //displays
    ellipse(this.x, this.y, radius, radius);
  }
}

//class that makes the powerups (small blue circles), displays them, and controls the collisions of the white pieces with them
class powerups extends Circles {

  powerups (float x, float y) {
    super(x, y); //extension of the class circles
    radius = 20;
  }
  void display() { //diplays the small powerup circles
    fill(#69E8D8);
    stroke(#69E8D8);
    this.show();
    //ellipse(this.x, this.y, 20, 20);
  }
  void collisions() { //checks with the collisions with the white pieces and powerups
    //if there is collision, it adds and displays explosions, then changes screen to screen 3 (game over screen)
    for (int i=0; i < wcircles.size(); i++) {
      if (dist(wcircles.get(i).x, wcircles.get(i).y, this.x, this.y) < 30) {
        hits.add(new explosions(250, 250, 1, 1));
        missed.add(new spark(150, 250, 1, 1));
        missed.add(new spark(350, 250, 1, 1));
        if (hits.size()>0) {
          hits.get(0).display();
        }
        if (missed.size()>0) {
          missed.get(0).display();
          missed.get(1).display();
        }
        attackcount--; //to delay the screen change a little
        if (attackcount <=0) {
          hits.clear(); 
          missed.clear();
          screen = 3;
          times = millis();
          attackcount = 2000;
        }  
        break;
      }
    }
  }
}

//class that controls the white pieces that are user's pieces. It displays them and checks for collisions with black pieces to kill them
class myPieces extends Circles {

  myPieces (float x, float y) {
    super(x, y);
    radius = 45;
  }
  void display() { //displays the pieces
    fill(255);
    stroke(255);
    this.show();
    //ellipse(this.x, this.y, 45, 45);
  }
  void collisions() { //checks for collisions with black pieces and removes them from the screen if the white touches them when it is the user's turn to go 
    for (int i=0; i < bcircles.size(); i++) {
      if (dist(bcircles.get(i).x, bcircles.get(i).y, this.x, this.y) < 40) {
        bcircles.get(i).x = 10000;
        bcircles.get(i).y = 10000;
        break;
      }
    }
  }
  /*boolean Done() { //if after their movement, the things end up off scree, to save space, this will help remove them later on to help with storage
   boolean d;
   if (this.x < 0 || this.x > width || this.y < 0 || this.y > height) d = true;
   else d = false;
   return d;
   }*/
}

//this class controls the AI's pieces, the black pieces. It displays them on screen and checks for collisions
class theirPieces extends Circles {

  theirPieces (float x, float y) {
    super(x, y);
    radius = 45;
  }

  void display() { //shows the pieces on screen
    fill(0);
    stroke(0);
    this.show();
    //ellipse(this.x, this.y, 45, 45);
  }
  void colliding() { //checks for collisions, if the black piece goes on the white piece, the whit piece goes off screen (dies) if it is the AI's turn to go
    for (int i=0; i < wcircles.size(); i++) { 
      if (dist(wcircles.get(i).x, wcircles.get(i).y, this.x, this.y) < 40) {
        wcircles.get(i).x = 10000;
        wcircles.get(i).y = 10000;
        break;
      }
    }
  }
  /*boolean Done() { //if after their movement, the things end up off scree, to save space, this will help remove them later on to help with storage
   boolean d;
   if (this.x < 0 || this.x > width || this.y < 0 || this.y > height) d = true;
   else d = false;
   return d;
   }*/
}

//this class controls the buttons (start and play again)
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

float smallestSoFar;
float smallSoFar;
int milliseconds; 
int times;
int screen;
int[][] grid = new int[5][5];
int [] time = new int[3];
int attackcount = 2000;

ArrayList<powerups> power = new ArrayList<powerups>();
ArrayList<myPieces> wcircles = new ArrayList<myPieces>();
ArrayList<theirPieces> bcircles  = new ArrayList<theirPieces>();
ArrayList<button> clicks = new ArrayList<button>();
ArrayList<Float> Distance = new ArrayList<Float>();
ArrayList<Float> distance = new ArrayList<Float>();
ArrayList<explosions> hits = new ArrayList<explosions>();
ArrayList<spark> missed = new ArrayList<spark>();


void setup() {
  size(500, 500);
  screen = 0;

  //initializes the timer's values
  time[0] = 0;
  time[1] = 0;
  time[2] = 0;
  //the variables for the delay in AI's turn to go
  times = 0;
  milliseconds = 4000;

  //setup for where the black and white pieces will apear
  for (int r = 0; r < 5; r++) { //for the white pieces
    int c = 4;
    grid[r][c] = 1;
  }
  for (int r = 0; r < 5; r++) { //or the black pieces
    int c = 0;
    grid[r][c] = 2;
  }
}



void draw() {
  background(0);
  if (screen == 0) { //screen 0 is the starting screen with the name of the game and instructions
    background(0);
    fill(#6BD1BD);
    textSize(55);
    text("Walmart Checkers", 15, 100);
    fill(#EA808E);
    textSize(40);
    text("Instructions", 20, 180);
    textSize(15);
    //instructions
    text("You have to kill the other sides pieces before they kill yours\nClick on the square you want your piece to move to\nThe closest piece to where you click will move to it\nOnce you move your turn, they will move theirs\nMake your white piece go on top of the black piece to kill it\nYou can move only one square distance\nAvoid the blue circles, if you go on one, game over", 20, 210);

    //the start button
    fill(#2EFF52);
    clicks.add(new button(200, 440, 105, 40)); //creates the button
    clicks.get(0).display(); //displays the button on the users screen
    fill(0);
    textSize(30);
    text("START", 205, 470);
  } else if (screen == 1||screen == 2) { //when the game starts
    fill(#A27B2B);
    //the function can be found at the bottom
    //board makes the checkered board for the game
    board(50, 50, 8);

    //adds/displays the black and white pieces
    //usng the 2D array
    for (int r = 0; r < 5; r++) {
      for (int c = 0; c < 5; c++) { 
        /*fill(255);
         textSize(10);
         text("(" + r + "," + c + ")", r*105 +5, c * 100+15);
         textSize(10);
         text(grid[r][c], r * 105+5, c * 100 + 30);*/

        if (grid[r][c] == 1) //places the white pieces on the bottom row
        {
          if (wcircles.size() < 5) {
            wcircles.add(new myPieces((r*100)+50, ((c+1)*100) -50));
          }
          for (int i=0; i < wcircles.size(); i++) wcircles.get(i).display(); //shows the blowups
        }
        if (grid[r][c] == 2) //places the black pieces on the top row
        {
          if (bcircles.size() < 5) {
            bcircles.add(new theirPieces((r*100)+50, ((c+1)*100) -50));
          }
          for (int i=0; i < bcircles.size(); i++) bcircles.get(i).display(); //shows the blowups
        }
      }
    }
    //displays the time
    time(); //timer made by a function (the function has the time running)

    //checks for the collisions of the white pieces and the powerups
    for (int i = 0; i < power.size(); i++) power.get(i).collisions();
  }
  if (screen == 1) {
    //checks for collisions of the black pieces and white pieces (if they are colliding the white piece is killed)
    for (int i = 0; i < bcircles.size(); i++) bcircles.get(i).colliding();
  }
  if (screen ==2) {
    //checks for collisions of the black pieces and white pieces (if they are colliding the black piece is killed)
    for (int i = 0; i < wcircles.size(); i++) wcircles.get(i).collisions();

    for (int i=0; i < hits.size(); i++) { //helps remove the blowup from its array once the blow up decays
      if (hits.get(i).disapear()) {
        hits.clear(); //removing from array list
      }
    }
    for (int i=0; i < missed.size(); i++) { //helps remove the blowup from its array once the blow up decays
      if (missed.get(i).disapear()) {
        missed.clear(); //removing from array list
      }
    }
    //runs the computers/AI's turn but after a delay of some time
    if (millis() - times > milliseconds) {
      Computer(1); //function can be found at the bottom 
      times = millis();
    }
  }
  if (screen ==1 || screen == 2) {
    //adds and displays all the powerups on the screen
    power.add(new powerups(250, 250));
    power.add(new powerups(50, 150));
    power.add(new powerups(50, 350));
    power.add(new powerups(450, 150));
    power.add(new powerups(450, 350));
    for (int j=0; j < power.size(); j++) power.get(j).display();
  }
  if (screen ==3) { //screen 3 is the game over screen if the white piece touches a powrup (which is really a bad thing for them so not so mucha powerup)
    //play again button
    fill(#2EFF52);
    clicks.get(0).display(); //displays the button on the users screen
    fill(0);
    textSize(30);
    text("AGAIN", 205, 470);

    textSize(60);
    fill(#AA3232);
    text("GAME OVER", 80, 250);
  }
}


void mousePressed() {

  if (screen == 0) {
    //if the start button is clicked, it takes us to screen 1 which starts the game immediately
    if (clicks.get(0).pressed()) {
      screen = 1;
    }
  } else if (screen == 1) {

    //Code to find closest piece here
    //uses algorithm to find the distances between where the person clicks and all the white pieces and find which one is the shortest distance and which ever the shortest distance is with, it moves that piece to the place the player clicked 
    //works only if the distance is a specific distance though because players are only allowed to move one box at a time.

    for (int i = 0; i<wcircles.size(); i++) {//finding distnaces and saving them in an array
      if (Distance.size() < 5) {
        Distance.add(dist(wcircles.get(i).x, wcircles.get(i).y, mouseX, mouseY));
      } else if (Distance.size() >= 5) {
        Distance.clear();
        Distance.add(dist(wcircles.get(i).x, wcircles.get(i).y, mouseX, mouseY));
      }
    }

    //algorithm to find the smallest distance
    smallestSoFar = Distance.get(0);
    for (int i=0; i < wcircles.size(); i++) {
      if (Distance.get(i) < smallestSoFar) {
        smallestSoFar = Distance.get(i);
      }
    }
    //checks which piece the smallest distance is with and makes that piece move to the spot the player clicked
    for (int i= 0; i<wcircles.size(); i++) {
      if ((smallestSoFar == dist(wcircles.get(i).x, wcircles.get(i).y, mouseX, mouseY)) && (smallestSoFar != 0) && (smallestSoFar >70) && (smallestSoFar <= 150)) {
        wcircles.get(i).x = mouseX;
        wcircles.get(i).y = mouseY;
        screen = 2;
        break;
      }
    }
  }
  if (screen == 3) {
    //if play again button is clikced 
    if (clicks.get(0).pressed()) {
      //resets things 
      hits.clear();
      missed.clear();
      bcircles.clear();
      wcircles.clear();

      time[0] = 0;
      time[1] = 0;
      time[2] = 0;
      //goes back to screen one (initializing the game)
      screen = 1;
    }
  }
}

//uses recursion to creak the squares that make the checkers grid
void board(float x, float y, int n) {
  stroke(0);
  strokeWeight(1);
  rect(x, y, 100, 100);
  if (n >0) {//Recursive case
    rectMode(CENTER);
    //fill(#A27B2B);
    board(x + 100, y, n-1);
    board(x, y + 100, n-1);
  }
}

//Code to find closest black piece here
//uses algorithm to find the distances between where the AI guesses and all the black pieces and finds which one is the shortest distance and which ever the shortest distance is with, it moves that piece to the coordinates the random generator created (if within the specific distance) 
//works only if the distance is a specific distance though because pieces are only allowed to move one box at a time.
float guessX, guessY; //these are the coordinates it measures the distances with and then moves the closest piece to
void Computer(int x) {
  int Placing = x;
  while (Placing > 0) { //runs loop until one piece is moved

    //the guess is rounded to a 50 so that the piece moves to the middle of the squares on the grid
    guessX = (floor(random(50, 450)/100) * 100)+50;
    guessY = (floor(random(50, 450)/100) * 100)+50;

    if (x == 1)
    {
      //finds the distances and adds them to an array
      for (int i = 0; i<bcircles.size(); i++) {
        if (distance.size() < 5) {
          distance.add(dist(bcircles.get(i).x, bcircles.get(i).y, guessX, guessY)); //change mouse x and mouse y to a guess
        } else if (distance.size() >= 5) {
          distance.clear();
          distance.add(dist(bcircles.get(i).x, bcircles.get(i).y, guessX, guessY)); //change mouse x and mouse y to a guess
        }
      }
      //uses algorithm to find shortest distance 
      smallSoFar = distance.get(0);
      for (int i=0; i < bcircles.size(); i++) {
        if (distance.get(i) < smallSoFar) {
          smallSoFar = distance.get(i);
        }
      }
      //checks which piece the shortest distance is with and moves that piece if distance is within the range
      for (int i= 0; i<bcircles.size(); i++) {
        if (smallSoFar == dist(bcircles.get(i).x, bcircles.get(i).y, guessX, guessY) && (smallSoFar != 0) && (smallSoFar >70) && (smallSoFar <= 150)) {  //change mouse x and mouse y to the guess
          if ((guessX >0) && (guessX <500) && (guessY >0) && (guessY <500))
          {
            bcircles.get(i).x = guessX; //guess point
            bcircles.get(i).y = guessY; //guess point
            screen = 1;
            Placing--;
            break;
          }
        }
      }
    }
  }
}
