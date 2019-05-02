import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import javax.swing.KeyStroke;
Serial MyPort;                                
String KeyString = "";

// buttons
final int X_button = 3;
final int Y_button = 4;
final int A_button = 5;
final int B_button = 6;
final int Select_button = 8;

// joystick
final int SW_pin = 2;
final int x_analog_pin = 0;
final int y_analog_pin = 1;

void setup()
{
  System.out.println("Hi");
  size(700, 500);
  MyPort = new Serial(this, "COM6", 115200);// My Arduino is on COM3. Enter the COM on which your Arduino is on.
  MyPort.bufferUntil('\n');
  delay(1000);
  noLoop(); 

  /// setting up the controller
}
// .

void serialEvent(Serial MyPort)throws Exception {
  KeyString = MyPort.readStringUntil('\n');
  KeyString = KeyString.substring(0, KeyString.indexOf(':'));//The string is split. the whole string leaving the colon is taken
  System.out.println(KeyString);//prints the serial string for debugging purpose
  Robot Arduino = new Robot();// . .. . .// ////// .Constructor of robot class
  switch(KeyString) {
  case "Up" :
      Arduino.keyPress(KeyEvent.VK_PERIOD);//presses up key.
      Arduino.keyRelease(KeyEvent.VK_PERIOD);//releases up key
      break;
    case "Down" :
      Arduino.keyPress(KeyEvent.VK_SLASH);
      Arduino.keyRelease(KeyEvent.VK_SLASH);      
      break;
      //The below code is an extension to the one given in the 'processing' step to add the functionality of simulating right and left key 
      //After Switch case statement
    case "Right" :
      Arduino.keyPress(KeyEvent.VK_COMMA);
      Arduino.keyRelease(KeyEvent.VK_COMMA);
      break;
    case "Left" :
      Arduino.keyPress(KeyEvent.VK_X);
      Arduino.keyRelease(KeyEvent.VK_X);      
      break;
    /*
  case "Shift":x
    Arduino.keyPress(KeyssEvent.VK_SHIFT);
    Arduino.keyRelease(KeyEvent.VK_SHIFT);
    break;

sasaaa
asww
daswwwwwsds
aaasssddsasd...  .//,,/ 
*/  
}
}
//wwaaddssssssdddss
void draw() {//Not really necessary
  /*
  background(0, 0, 0);
  fill(255, 0, 0);
  text("Press any key", 100, 175);
*/
}
