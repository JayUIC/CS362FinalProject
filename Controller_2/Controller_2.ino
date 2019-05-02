// Button input pins
const int UpButton = 11;
const int DownButton = 9;
const int LeftButton = 10;
const int RightButton = 12;


// Joystick axis/input setup
/*
const int SW_pin = 2;
const int x_analog_pin = 0;
const int y_analog_pin = 1;
*/
void setup(){
   Serial.begin(115200);
   
   pinMode(UpButton, INPUT);
   pinMode(DownButton, INPUT);
   pinMode(LeftButton, INPUT);
   pinMode(RightButton, INPUT);
  /*
  pinMode(SW_pin, INPUT);
  digitalWrite(SW_pin, HIGH);
  */
} 
void loop(){
  // joystick();
  
 if(digitalRead(UpButton) == HIGH){
  Serial.println("Up:");//It doesn't matter what you print. Just have a colon at the end to make it easier to parse the string.
  delay(300);
   }
 if(digitalRead(DownButton) == HIGH){
  Serial.println("Down:");
  delay(300);
   }
 if(digitalRead(LeftButton) == HIGH){
  Serial.println("Left:");
  delay(300);
   }
if(digitalRead(RightButton) == HIGH){
  Serial.println("Right:");
  delay(300);
   }

 
   
}
/*
void joystick() {
  Serial.print("Switch:  ");
  Serial.print(digitalRead(SW_pin));
  Serial.print("\n");
  Serial.print("X-axis: ");
  Serial.print(analogRead(x_analog_pin));
  Serial.print("\n");
  Serial.print("Y-axis: ");
  Serial.println(analogRead(y_analog_pin));
  Serial.print("\n\n");
  delay(500);
}
*/
