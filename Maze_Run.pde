//variable to control time
int [] time = new int[3];

//variables to control blue square location
float x, y;

//variable to control which screen the game is on
int screen;

//variables to contol scores/highscores
float highscore;
float [] score = new float[2];
float DisplayScore;
//used for score array
int j = 1;

//variables to control red balls locations and speeds
float ball1x, ball1y, ball2x, ball2y;
float speed1x, speed2x;

//variables used for maze walls and powerup circles (collision detection)
ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();
ArrayList<Powerups> circles = new ArrayList<Powerups>();

void setup() {
  size(670, 500); //size of window

  time[0] = 0; //milliseconds
  time[1] = 0; //seconds
  time[2] = 0; //minutes

  //starting location of the blue square
  x = 613; 
  y = 443;

  screen = 0;

  //initial score setup
  score[0] = -2000000000;
  DisplayScore = 0;

  //starting locations of the 2 red balls
  ball1x = 20; //ball 1 is ball on top
  ball1y = 60;
  ball2x = 20; //ball 2 is ball on bottom
  ball2y = 470;
  //speeds of the two red balls
  speed1x = 3.5; //speed of ball on top
  speed2x = 2.5; //speed of ball on bottom

  //maze walls
  rectangles.add(new Rectangle(565, 320, 40, 180));//vertical bottom right
  rectangles.add(new Rectangle(458, 214, 40, 220));//vertical 2nd last bottom right
  rectangles.add(new Rectangle(458, 214, 212, 40));//horizontal bottom right
  rectangles.add(new Rectangle(352, 108, 252, 40));//horizontal top right
  rectangles.add(new Rectangle(352, 108, 40, 326));//vertical 3rd last right
  rectangles.add(new Rectangle(66, 394, 326, 40));//horizontal bottom
  rectangles.add(new Rectangle(66, 328, 40, 66));//vertical bottom left
  rectangles.add(new Rectangle(0, 328, 66, 40));//horizontal bottom left 
  rectangles.add(new Rectangle(0, 108, 286, 40));//horizontal top left
  rectangles.add(new Rectangle(246, 108, 40, 220));//vertical top left
  rectangles.add(new Rectangle(140, 108, 40, 154));//vertical top left left

  circles.add(new Powerups(30, 390, 20, 20)); //circle on the bottom left corner
  circles.add(new Powerups(215, 170, 20, 20)); //circle in the alley beside the exit gate
  circles.add(new Powerups(635, 290, 20, 20)); //circle on the bottom right
  circles.add(new Powerups(35, 35, 20, 20)); //circle at the top left corner
  circles.add(new Powerups(30, 290, 20, 20)); //circle just before the exit gate just above the one on the bottom left corner
  circles.add(new Powerups(635, 135, 20, 20)); //circle in top right corner
}

void draw() {
  background(#FFFFFF);
  if (screen == 0) { //screen 0 is the starting screen with the name of the game and instructions
    background(0);
    fill(#F50A29);
    textSize(65);
    text("MAZE RUN", 80, 130);
    fill(#EA808E);
    textSize(40);
    text("Instructions", 80, 200);
    textSize(15);
    //instructions
    text("Click the blue box to start\nDrag your mouse to move the box and get to the yellow door\nDo not touch the walls of the maze or else you lose points!\nBe aware of the red shapes, if you get touched by them, you start over!\nCollect the blue powerups to gain points!", 80, 230);

    //the start button
    fill(#2EFF52);
    rect(200, 350, 105, 40);
    fill(0);
    textSize(30);
    text("START", 205, 380);
  }
  if (screen == 1) { //screen 1 shows the game screen but need to click blue box to start the game
    //red balls
    fill(#FF2200);
    ellipse(ball1x, ball1y, 65, 65);
    ellipse(ball2x, ball2y, 50, 50);

    textSize(25);
    fill(#FF0026);
    text("Click Blue Square to Begin", 180, 100);

    //score
    textSize(12);
    fill(0);
    text("score:" + DisplayScore, 3, 13);

    //blue square
    fill(#91F7F5);
    rect(x, y, 50, 50);

    //maze walls
    for (int i = 0; i < rectangles.size(); i++) { //the for loop creates all the rectangles from the array list
      Rectangle rectangle = rectangles.get(i); //gets each rectangle from the list
      fill(0); //colours the maze walls black
      rectMode(CORNER);
      rect(rectangle.x, rectangle.y, rectangle.rectWidth, rectangle.rectHeight); //creates/draws the rectangles
    }
    //spaces between the walls 66
    //wall width 40

    //the door/exit --- reach it to complete maze
    fill(#FFF700);
    rect(3, 151, 132, 60);
  }
  if (screen == 2) //if you reach this screen (screen 2), the game has already started 
  {
    //displays the score
    textSize(12);
    fill(0);
    text("score:" + DisplayScore, 3, 13);

    //displays the time
    fill(0);
    time(); //timeer made by a function (the function has the time running)

    //blue square
    fill(#91F7F5);
    rectMode(CENTER);
    rect(mouseX, mouseY, 50, 50); //with this, the blue box will follow the cursor/mouse

    //the moving red balls
    fill(#FF2200);
    ellipse(ball1x, ball1y, 65, 65);
    ellipse(ball2x, ball2y, 50, 50);
    //speeds of the moving red balls
    ball1x = ball1x + speed1x;
    ball2x = ball2x + speed2x;

    //makes the red balls bounce off the edges of the window or maze walls
    //ball at the top
    if (ball1x <0) {
      speed1x = 3.5;
    } else if (ball1x>670) {
      speed1x = -3.5;
    }
    //ball at the bottom
    if (ball2x <0) {
      speed2x = 2.5;
    } else if (ball2x>564) {
      speed2x = -2.5;
    }

    //checking collision with red ball at the top
    if ((((mouseX-25) + 50) > (ball1x-31)) && ((mouseX-25)< (ball1x+31)) && (((mouseY-25) + 50) > (ball1y-31)) && ((mouseY-25) < (ball1y+31))) {
      DisplayScore = 0;
      screen = 1;
    }
    //checking collision with red ball at the bottom
    if ((((mouseX-25) + 50) > (ball2x-20)) && ((mouseX-25)< (ball2x+20)) && (((mouseY-25) + 50) > (ball2y-20)) && ((mouseY-25) < (ball2y+20))) {
      DisplayScore = 0;
      screen = 1;
    }

    //maze walls (collision detection with the walls)
    for (int i = 0; i < rectangles.size(); i++) { //the for loop gets each rectangle and checks if we are colliding with each
      Rectangle rectangle = rectangles.get(i); //gets each rectangle/wall from the array list

      //checking collision for each rectangle maze wall
      if ((((mouseX-25) + 50) > rectangle.x) && ((mouseX-25)< rectangle.x + rectangle.rectWidth) && (((mouseY-25) + 50) > rectangle.y) && ((mouseY-25) < rectangle.y + rectangle.rectHeight)) {
        DisplayScore = DisplayScore - 0.5;
      }
      //checking collision with the edges of the window
      if ((((mouseX-25) + 50) > 670)||((mouseX-25)< 0)||(((mouseY-25)+50)>500)||((mouseY-25)<0)) {
        DisplayScore = DisplayScore - 0.5;
      }

      //makes the rectangles/maze walls
      fill(0);
      rectMode(CORNER);
      rect(rectangle.x, rectangle.y, rectangle.rectWidth, rectangle.rectHeight);
    }

    //powerup circles and checking collisions with them
    for (int i = 0; i < circles.size(); i++) {
      Powerups circle = circles.get(i);

      //checking collision for each powerup
      if ((((mouseX-25) + 50) > circle.x1) && ((mouseX-25)< circle.x1 + circle.circWidth) && (((mouseY-25) + 50) > circle.y1) && ((mouseY-25) < circle.y1 + circle.circHeight)) {
        DisplayScore = DisplayScore + 100;
        circles.remove(i);
      }
      //drawing each circle
      fill(#0AFF0C);
      ellipse(circle.x1, circle.y1, circle.circWidth, circle.circHeight);
    }

    //the door/exit
    fill(#FFF700);
    rect(3, 151, 132, 60);
    //checking collision with the exit door so that they can move to the next screen
    if (((mouseX) > 3) && ((mouseX)< 135) && ((mouseY) > 151) && ((mouseY) < 211)) {
      screen = 3;
    }
  }
  if (screen == 3) //once on screen 3, its congratulates you and gives you your score, time, and high score
  {
    if (DisplayScore > 0) {
      background(#72FA82); //green
    } else if (DisplayScore <= 0) {
      background(#FF1F0A); //red
    }

    score[j] = DisplayScore;

    fill(0);
    textSize(65);
    text("You Made It!\nCongrats!", 120, 130); 
    textSize(35);
    //displays the score from curent round of game
    text("Your score is: " + score[j], 120, 300);
    //displays the time when they completed the current round of game
    text("Your time was: " + time[2] + " : " + time[1], 120, 350);

    //displaying the high score between all the rounds of games they have played

    //score[0] = -200000000000000000
    //score[1] = 296   highscore = 296
    //score[2] = -56   highscore = 296
    //score[3] = 96

    if (score[j] >= score[j-1])
    {
      if (score[j]>=highscore)
      {
        highscore = score[j];
        text("HighScore: " + highscore, 120, 400);
      } else if (score[j] < highscore) {
        highscore = highscore;
        text("HighScore: " + highscore, 120, 400);
      }
    } else if (score[j] < score[j-1])
    {
      if (score[j-1]>=highscore)
      {
        highscore = score[j-1];
        text("HighScore: " + highscore, 120, 400);
      } else if (score[j-1] < highscore) {
        highscore = highscore;
        text("HighScore: " + highscore, 120, 400);
      }
    }

    //creating/displaying the play again button
    fill(#FF120A);
    rect(200, 450, 135, 40);
    fill(0);
    textSize(25);
    text("Play Again", 205, 480);
  }
}

//when clicked
void mousePressed() {
  if (screen == 0)
  { //if the start button is clicked
    if (mouseX > 200 && mouseX < 305 && mouseY > 350 && mouseY < 390) {
      screen = 1;
    }
  }
  if (screen == 1) {
    //if the blue square is clicked 
    if (mouseX > 613 && mouseX < 663 && mouseY > 443 && mouseY < 493) {
      screen = 2;
    }
  }
  if (screen == 3)
  { //if the play again button is clicked
    if (mouseX > 200 && mouseX < 335 && mouseY > 450 && mouseY < 490) {
      screen = 1;
      //reset the score
      DisplayScore = 0;
      //reset the time
      time[0] = 0;
      time[1] = 0;
      time[2] = 0;

      j++;
      score = expand(score, score.length + 1);

      //extra
      /*println("score array length: " + score.length);
       println("j value: " + j);*/
      //extra

      //adds the powerups back in (resets the power ups)
      circles.add(new Powerups(30, 390, 20, 20));
      circles.add(new Powerups(215, 170, 20, 20));
      circles.add(new Powerups(635, 290, 20, 20));
      circles.add(new Powerups(35, 35, 20, 20));
      circles.add(new Powerups(30, 290, 20, 20));
      circles.add(new Powerups(635, 135, 20, 20));
    }
  }
}


class Rectangle { //class for maze wall creations and maze wall collisions
  float x;
  float y;
  float rectWidth;
  float rectHeight;

  public Rectangle(float x, float y, float rectWidth, float rectHeight) {
    this.x = x;
    this.y = y;
    this.rectWidth = rectWidth;
    this.rectHeight = rectHeight;
  }
}


class Powerups { //class for the circle powerups creations and and circle powerups collisions
  float x1;
  float y1;
  float circWidth;
  float circHeight;

  Powerups(float x1, float y1, float circWidth, float circHeight) {
    this.x1 = x1;
    this.y1 = y1;
    this.circWidth = circWidth;
    this.circHeight = circHeight;
  }
}

void time() { //function to create the timer
  text(time[2], 602, 20); //minutes
  text(":", 614, 20);
  text(time[1], 620, 20); //seconds
  text(":", 635, 20);
  text(time[0], 643, 20); //milliseconds

  time[0] = time[0] + 1;
  if (time[0] == 60) { //should be a 100 and not 60 but the timer works more accurately with 60 milliseconds
    time[1] = time[1] + 1;
    time[0] = 0;
    if (time[1] == 60) {
      time[2] = time[2] + 1;
      time[1] = 0;
      time[0] = 0;
    }
  }
}
