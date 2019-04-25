// joystick guide: https://www.brainy-bits.com/arduino-joystick-tutorial/



// buttons
const int X_button = 3;
const int Y_button = 4;
const int A_button = 5;
const int B_button = 6;
const int Select_button = 8;

// joystick
const int SW_pin = 2;
const int x_analog_pin = 0;
const int y_analog_pin = 1;

void setup() {
  // put your setup code here, to run once:
  pinMode(SW_pin, INPUT); //joystick setup
  digitalWrite(SW_pin, HIGH);

  pinMode(X_button, INPUT);
  pinMode(Y_button, INPUT);
  pinMode(A_button, INPUT);
  pinMode(B_button, INPUT);
  pinMode(Select_button, INPUT);

  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  /*
     - All I'm doing here is just reading in the inputs from the buttons and making sure that
     there's no interference if buttons are hit at the same time.
     - Also setting up the joystick here to read input
  */
  // TODO

  joystick();
  // button();
}

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

void button(){
  // Serial.print("X_button: ");
  // Serial.println(digitalRead(X_button));
  if (digitalRead(X_button))
  {
    Serial.println("Up:");
    delay(300);    
  }
  // Serial.print("Y_button: ");
  // Serial.println(digitalRead(Y_button));
  if (digitalRead(Y_button))
  {
    Serial.println("Down:");
    delay(300);
  }
  // Serial.print("A_button: ");
  // Serial.println(digitalRead(A_button));
  if (digitalRead(A_button))
  {
    Serial.println("Left:");
    delay(300);    
  }
  // Serial.print("B_button: ");
  // Serial.println(digitalRead(B_button));
  if (digitalRead(B_button))
  {
    Serial.println("Right:");
    delay(300);
  }
  if (digitalRead(Select_button))
  {
    Serial.println("A:");
    delay(300);
  }
}
