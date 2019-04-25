import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import beads.*;
import org.jaudiolibs.beads.*;

import cc.arduino.*;
import org.firmata.*;

/**
  * This sketch demonstrates how to use the BeatDetect object in FREQ_ENERGY mode.<br />
  * You can use <code>isKick</code>, <code>isSnare</code>, </code>isHat</code>, <code>isRange</code>, 
  * and <code>isOnset(int)</code> to track whatever kind of beats you are looking to track, they will report 
  * true or false based on the state of the analysis. To "tick" the analysis you must call <code>detect</code> 
  * with successive buffers of audio. You can do this inside of <code>draw</code>, but you are likely to miss some 
  * audio buffers if you do this. The sketch implements an <code>AudioListener</code> called <code>BeatListener</code> 
  * so that it can call <code>detect</code> on every buffer of audio processed by the system without repeating a buffer 
  * or missing one.
  * <p>
  * This sketch plays an entire song so it may be a little slow to load.
  */

import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import cc.arduino.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
Arduino arduino;

int white1 =  2;    // LED connected to digital pin 12
int white2 =  3;    // LED connected to digital pin 1
int green1 =  4;
int green2 =  5;
int blue1 =  6;
int blue2 =  7;
int red1 = 8;
int red2 = 9;
int yellow1 = 10;
int yellow2 = 11;
int Mblue1 = 12;
int Mblue2 = 13;


float kickSize, snareSize, hatSize;

void setup() {
  size(512, 200, P3D);
  
  minim = new Minim(this);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  song = minim.loadFile("SM.mp3", 2048);
  song.play();
  // a beat detection object that is FREQ_ENERGY mode that 
  // expects buffers the length of song's buffer size
  // and samples captured at songs's sample rate
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  // set the sensitivity to 300 milliseconds
  // After a beat has been detected, the algorithm will wait for 300 milliseconds 
  // before allowing another beat to be reported. You can use this to dampen the 
  // algorithm if it is giving too many false-positives. The default value is 10, 
  // which is essentially no damping. If you try to set the sensitivity to a negative value, 
  // an error will be reported and it will be set to 10 instead. 
  beat.setSensitivity(100);  
  kickSize = snareSize = hatSize = 16;
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song);  
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER);
  
  arduino.pinMode(white1, Arduino.OUTPUT);    
  arduino.pinMode(white2, Arduino.OUTPUT);  
  arduino.pinMode(green1, Arduino.OUTPUT);
  arduino.pinMode(green2, Arduino.OUTPUT);
  arduino.pinMode(blue1, Arduino.OUTPUT);
  arduino.pinMode(blue2, Arduino.OUTPUT);
  arduino.pinMode(red1, Arduino.OUTPUT);
  arduino.pinMode(red2, Arduino.OUTPUT);
  arduino.pinMode(yellow1, Arduino.OUTPUT);
  arduino.pinMode(yellow2, Arduino.OUTPUT);
  arduino.pinMode(Mblue1, Arduino.OUTPUT);
  arduino.pinMode(Mblue2, Arduino.OUTPUT);
 
}

void draw() {
  background(0);
  fill(255);
  if(beat.isKick()) {
      arduino.digitalWrite(white1, Arduino.HIGH);
      arduino.digitalWrite(white2, Arduino.HIGH); 
      arduino.digitalWrite(blue1, Arduino.HIGH); 
      arduino.digitalWrite(blue2, Arduino.HIGH); // set the LED on
      kickSize = 32;
  }
  if(beat.isSnare()) {
      arduino.digitalWrite(green1, Arduino.HIGH);
      arduino.digitalWrite(green2, Arduino.HIGH); 
      arduino.digitalWrite(red1, Arduino.HIGH);
      arduino.digitalWrite(red2, Arduino.HIGH); // set the LED on
      snareSize = 32;
  }
  if(beat.isHat()) {
      arduino.digitalWrite(yellow1, Arduino.HIGH);
      arduino.digitalWrite(yellow2, Arduino.HIGH); 
      arduino.digitalWrite(Mblue1, Arduino.HIGH); 
      arduino.digitalWrite(Mblue2, Arduino.HIGH); // set the LED on
      hatSize = 32;
  }
  arduino.digitalWrite(white1, Arduino.LOW);    // set the LED off
  arduino.digitalWrite(white2, Arduino.LOW);    // set the LED off
  arduino.digitalWrite(green1, Arduino.LOW); 
  arduino.digitalWrite(green2, Arduino.LOW);
  arduino.digitalWrite(blue1, Arduino.LOW);
  arduino.digitalWrite(blue2, Arduino.LOW);
  arduino.digitalWrite(red1, Arduino.LOW);
  arduino.digitalWrite(red2, Arduino.LOW);
  arduino.digitalWrite(yellow1, Arduino.LOW);
  arduino.digitalWrite(yellow2, Arduino.LOW);
  arduino.digitalWrite(Mblue1, Arduino.LOW);
  arduino.digitalWrite(Mblue2, Arduino.LOW);// set the LED off
  textSize(kickSize);
  text("KICK", width/4, height/2);
  textSize(snareSize);
  text("SNARE", width/2, height/2);
  textSize(hatSize);
  text("HAT", 3*width/4, height/2);
  kickSize = constrain(kickSize * 0.95, 16, 32);
  snareSize = constrain(snareSize * 0.95, 16, 32);
  hatSize = constrain(hatSize * 0.95, 16, 32);
}

void stop() {
  // always close Minim audio classes when you are finished with them
  song.close();
  // always stop Minim before exiting
  minim.stop();
  // this closes the sketch
  super.stop();
}
