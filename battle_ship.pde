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
    } else if (this.w >=100 && this.h >= 100) { //decaying of the explosions
      this.sx = -1;
      this.sy = -1;
    }
    fill(#FF8000);
    stroke(#F9FA0A);
    strokeWeight(5);
    ellipse(this.x, this.y, this.w, this.h);
  }
}

class crosses extends Explode { //controls the explosions that occur after collisions with the enemy

  crosses(float x, float y, float sx, float sy) {
    super(x, y, sx, sy);
  }
  void display() { //displays
    //controls the speed of the growing and decaying of the sparks
    this.GrowDecay();

    if (this.w >=50 && this.h >= 20) { //decaying of the explosions
      this.sx = -1;
      this.sy = -1;
    } else if (this.w == 0 && this.h == 0) { //decaying of the explosions
      this.sx = 0;
      this.sy = 0;
      this.w = 0;
      this.h = 0;
    }

    fill(#F0B3B4);
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    rect(this.x, this.y, this.w, this.h);
    rect(this.x, this.y, this.h, this.w);
  }
}



ArrayList<explosions> hits = new ArrayList<explosions>();
ArrayList<crosses> missed = new ArrayList<crosses>();
ArrayList<button> clicks = new ArrayList<button>();

//2D array
int[][] grid = new int[6][6];

int myShips = 0; //Number of player ships placed
int IhitShips = 3;
int TheyhitShips = 3;
int screen = 0; //start at 0
int Mylives = 15; //start at 15

/*
My additional elements
1. blowups and crosses
2. if you get one right you get to go again until you get one wrong (same for the AI ships
3. You have lives, if you cannot guess and lose your lives, you loose.
*/

/*
screen
 0- placing player ships
 1- playing the game (your turn to guess)
 2- computer's turn to guess
 3- game over
 4- you win
 */

/*
Grid reference
 0= water
 1= player boat
 2= player2 boat
 3= you sunk boat
 4= you missed boat
 5= computer sunk boat
 6= computer missed boat
 */


void setup() {
  size(600, 600);

  for (int r = 0; r < 6; r++) {
    for (int c = 0; c < 6; c++) {
      grid[r][c] = 0;
    }
  }
}

void draw() {
  background(0);
  textSize(10);
  stroke(255);

  for (int r = 0; r < 6; r++) {
    for (int c = 0; c < 6; c++) { 

      if (grid[r][c] == 0) 
      {
        fill(#4448F2); //water
      } else if (grid[r][c] == 1) 
      {
        fill(#44E5F2); //our boat
      } else if (grid[r][c] == 2) 
      {
        fill(#4448F2); //computer's boat
      }
      //////////////////////////////////////////////////
      /*else if (grid[r][c] == 2) 
       {
       fill(255, 0, 255); //computer's boat
       } */
      /////////////////////////////////////////////////////
      else if (grid[r][c] == 3)
      {
        fill(#44F245); //sunken boat
      } else if (grid[r][c] == 4) 
      {
        fill(#F24447); //missed boat
      } else if (grid[r][c] == 5) //computer sunk boat
      {
        fill(#1E6C21);
      } else if (grid[r][c] == 6) //computer missed boat
      {
        fill(0);
      } 
      
      rectMode(CORNER);
      stroke(255);
      rect(r*100, c*100, 100, 100);
      fill(255);
      textSize(10);
      text("(" + r + "," + c + ")", r*105 +5, c * 100+15);
      ///////////////////////////////////////////////////////////
      /*textSize(10);
       text(grid[r][c], r * 105+5, c * 100 + 30);*/
      ///////////////////////////////////////////////////////////

      if (grid[r][c] == 3)
      {
        for (int i=0; i < hits.size(); i++) hits.get(i).display(); //shows the blowups
        for (int i=0; i < hits.size(); i++) { //helps remove the blowup from its array once the blow up decays
          if (hits.get(i).disapear()) {
            hits.remove(i); //removing from array list
          }
        }
      } else if (grid[r][c] == 4) 
      {
        for (int i=0; i < missed.size(); i++) missed.get(i).display(); //shows the blowups
        for (int i=0; i < missed.size(); i++) { //helps remove the spark from its array once the spark decays
          if (missed.get(i).disapear()) {
            missed.remove(i); //removing from array list
          }
        }
      }

      if (screen == 2) {
        Computer(1);
      }
      if (screen == 1||screen == 2) {
        fill(255);
        textSize(20);
        text("Lives:" + Mylives, 5, 575);

        if (Mylives == 0 || TheyhitShips == 0 || IhitShips == 0) {   // add ||Theirlives
          screen = 3;
        }
      }

      textSize(40);
      fill(#FFFFFF);
      if (screen == 0) text("Place three ships: " + myShips, 120, 300);
      else if (screen == 1) 
      {
        textSize(20);
        fill(#C6C8F5);
        text("Start BattleShip!", 225, 50);
      } else if (screen == 3) {
        grid[r][c] = 0;

        //creating/displaying the play again button
        fill(#72D85E);//green button
        stroke(#ACF295);//green stroke
        clicks.add(new button(200, 375, 200, 60)); //adding the rectangle for the button to the array list
        clicks.get(0).display(); //showing the button on the screen
        fill(0);
        textSize(40);
        text("Play Again", 202, 420); //text for the button

        if (Mylives == 0) {
          textSize(100);
          stroke(#FC0D05);
          fill(#FC0D05);
          text("GAME OVER", 15, 325);
        } 
        if (IhitShips == 0) {
          textSize(100);
          stroke(#1FD826);
          fill(#1FD826);
          text("YOU WIN!!", 50, 325);
        } else if (TheyhitShips == 0) {
          textSize(100);
          stroke(#FC0D05);
          fill(#FC0D05);
          text("GAME OVER", 15, 325);
        }
      }
    }
  }
}


void mousePressed() {

  int row = mouseX/100;
  int col = mouseY/100;

  if (screen == 0) {
    //Assumes no ai ships placed yet
    //Assumes everything is empty
    if (grid[row][col] == 0) {//Clicked water
      grid[row][col] = 1; //Make the empty tile now hold a boat
      myShips++;
      if (myShips == 3) {
        screen = 1; //All ships placed, goto main game
        //place AI ships now
        Computer(3);
      }
    } else if (grid[row][col] == 1) {//clicked player boat
      //Can't stack boats
    }
  } else if (screen == 1) {
    if (grid[row][col] == 0) {//Clicked water
      grid[row][col] = 4;
      missed.add(new crosses(row*100+50, col*100+50, 25, 5));
      screen = 2;
      Mylives--;
    } /*else if (grid[row][col] == 6) {//Clicked water
     grid[row][col] = 7;
     missed.add(new crosses(row*100+50, col*100+50, 25, 5));
     screen = 2;
     Mylives--;
     }*/
    /*else if (grid[row][col] == 1) {//clicked player boat
     //nothing happens because your own boat
     }*/    else if (grid[row][col] == 2) {//clicked enemy boat
      grid[row][col] = 3;
      hits.add(new explosions(row*100+50, col*100+50, 1, 1));
      IhitShips--; 
      //you get to go again
      //score =score + 1;
    } /*else if (grid[row][col] == 3) {//sunk boat
     //do nothing?
     } else if (grid[row][col] == 4) {//missed boat
     //do nothing?
     }*/
  } else if (screen == 3) {

    if (clicks.get(0).pressed()) {
      screen = 0;
      myShips = 0;
      IhitShips = 3;
      TheyhitShips = 3;
      Mylives = 15;
    }
  }
}


void Computer(int x) {
  int Placing = x;
  int guessX, guessY;

  while (Placing > 0) {
    guessX = floor(random(6));
    guessY = floor(random(6));

    if (x == 3) {
      if (grid[guessX][guessY] == 0) {
        grid[guessX][guessY] = 2;
        Placing--;
      }
    } else if (x == 1)
    {
      if (grid[guessX][guessY] == 0) {
        grid[guessX][guessY] = 6; 
        Placing--;
        screen = 1;
        //Theirlives--;
      } /*else if (grid[guessX][guessY] == 4) {
       grid[guessX][guessY] = 7; 
       Placing--;
       screen = 1;
       //Theirlives--;
       }*/
      else if (grid[guessX][guessY] == 1) {
        grid[guessX][guessY] = 5; 
        Placing--;
        TheyhitShips--;
      }
    }
  }
}
