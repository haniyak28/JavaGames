//the password is 5628 (just here for you to know the right password Ms. Yau)

//insert correct password here while replacing 0000 please, then run the program
int password = 0000;
// run the program after inserting the password for the program to open ad for you to answer the questions











void setup() {
//here are the two conditions. Please answer! Once you have answered, run the program again and see your result down below.
//the answer must remain in between the quotation marks. Thank you!

//Are you currently employed and a recent high school graduate, graduated in between January 2019 to May 2020?
String condition1 = "type answer here (use only yes or no)";

//or are you employed, over 18 and have at least 120 hours of volunteer experience?
String condition2 = "type answer here (use only yes or no)";













fullScreen();
  background(#030101);
  text("close", 30, 40); //the word close at the top left of the screens
  stroke(#FFFFFF);

//if either one of them is yes or if both conditions are yes then they are eligible for the grant and they will see it down below
if ((condition1.equals("yes")) || (condition2.equals("yes"))) {
  println("Congratulations, You are eligible for the new IT business grant!");
  exit();
}
//if both conditions are no then they are not eligible for the grant and they will see it down below
else if ((condition1.equals("no")) && (condition2.equals("no"))) {
  println("We are sorry to say, but you are not eligible for the new IT business grant.");
  exit();
}
//This is the same as the previous if statement with "yes" but with a capital "Y" just incase they type their answer with a capital
else if ((condition1.equals("Yes")) || (condition2.equals("Yes"))) {
  println("Congratulations, You are eligible for the new IT business grant!");
  exit();
}
//This is the same as the previous if statement with "no" but with a capital "N" just incase they type their answer with a capital
else if ((condition1.equals("No")) && (condition2.equals("No"))) {
  println("We are sorry to say, but you are not eligible for the new IT business grant.");
  exit();
}
}

void draw() {  
  // this first if statement is to run the screen saver if the password is incorrect
  if ((password < 5628) || (password > 5628)) { 
//varibles to get random colours
float R = random(255);
float G = random(255); 
float B = random(255); 

//variables to get the shapes to pop up at random locations
float x = random(width-1);
float y = random(height-1);    

//so that the shapes do not keep popping up really fast
delay(1000); 

//the command to move the shape to random locations everytime
translate(x, y); 

//my polygon shape
beginShape(TRIANGLE_STRIP);
    fill(R, G, B);
vertex(80, 125);
vertex(90, 70);
    fill(B, R, G);
vertex(100, 125);
vertex(110, 70);
    fill(B, G, R);
vertex(120, 125);
vertex(130, 70);
    fill(R, G, B);
vertex(140, 125);
endShape();
}
// this second if statement is to run the welcome screen with the kiosk if the password is correct
else if (password == 5628) {
  
//variables to change the location of the kiosk
  float h = 300; 
  float w = 200;
  stroke(#FFFFFF);
  fill(#0DACFF);
  
//the top light blue shape that has the screen on it
beginShape();
vertex(w-25, h-25);
vertex(w-10, h+400);
vertex(w+210, h+400);
vertex(w+225, h-25);
endShape(); 
  
//the screen of the kiosk
   fill(#0C5A83); 
rect(w, h, 200, 250); 

//the curved top of the kiosk
fill(#0DACFF);
arc(w+100,h-25,250,90,-PI,0);
arc(w+100,h-25,250,50,-PI,0);

//the black bolts around the screen
fill(#000203);
circle(w-15, h-16, 10);
circle(w+215, h-16, 10);
circle(w-5, h+280, 10);
circle(w+205, h+280, 10);

line(w-10, h+290, w+210, h+290);

//the body of the kiosk that is attatched to the base of the kiosk
fill(#BF67FF);
beginShape(TRIANGLE_STRIP);
vertex(w-10, h+400);
vertex(w+210, h+400);
vertex(w+15, h+750);
vertex(w+185, h+750);
endShape();

//the base of the kiosk (the very bottom)
fill(#6C10AF);
rect(w-25, h+760, 250, 25);

//the curved top of the base
stroke(#6C10AF);
arc(w+100,h+760,245,80,-PI,0);
arc(w+100,h+760,245,40,-PI,0);

//the little card or money slot on the body of the kiosk
stroke(#000000);
fill(#0E5D09);
ellipse(w+25, h+320, 50, 15);
fill(#000000);
rect(w, h+318, 50, 2);

//the key board and keys on the kiosk
fill(#8CF585);
rect(w+70, h+300, 65, 80);
fill(#000000);
rect(w+72, h+302, 18, 18);  
rect(w+93.5, h+302, 18, 18);
rect(w+115, h+302, 18, 18);
rect(w+72, h+322, 18, 18);  
rect(w+93.5, h+322, 18, 18);
rect(w+115, h+322, 18, 18);
rect(w+72, h+342, 18, 18);  
rect(w+93.5, h+342, 18, 18);
rect(w+115, h+342, 18, 18);
rect(w+72, h+362, 18, 18);  
rect(w+93.5, h+362, 18, 18);
rect(w+115, h+362, 18, 18);

//the elipse beside the keyboard
fill(#7A9378);
ellipse(w+175, h+340, 50, 65);

//the text that sqys "the kiosk"
textSize(60);
fill(255);
text("The Kiosk", w-40, h+850);

//the text that says "welcome"
textSize(300);
text("Welcome!", w+400, h+550);

//the rectangle button for the continue text
fill(#FC6363);
rect(w+800, h+700, 500, 100);

//the text that says "continue"
stroke(0);
fill(0);
textSize(60);
text("Continue", w+915, h+770);

//The text below the continue button that guides the viewers about what to do next
fill(225);
stroke(225);
textSize(40);
text("Please answer the two conditions in the program", w+560, h+900);
text("with either yes or no after clicking continue.", w+580, h+960);
}
}

//this is to get the close text to cause the screen to actually close and exit
void mousePressed() {
  // check horizontal position
  if (mouseX >= 20 && mouseX < 70) {
    // check vertical position
    if (mouseY >= 20 && mouseY < 50) {
      // close programm
      exit();
    }
  }
}

//this is to get the continue button to return back to the program and close and exit the screen
void mouseClicked() {
  if (mouseX >= 800 && mouseX < 1500){
  if (mouseY >= 900 && mouseY < 1200) {
  exit();
}
}
}
  


  
