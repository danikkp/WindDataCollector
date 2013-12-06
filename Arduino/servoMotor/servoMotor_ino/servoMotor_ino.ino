  //Arduino Servo programm
  //This programm rotates the Servo on "angle" degress angle after "t" seconds and back
  
  #include <Servo.h>
  
  Servo servoMotor; //define the servo object
  int angle=90; //define the rotatinal angle
  int t=10; //define the time between actuations of the motor
  
  void setup()
  {
    servoMotor.attach(2); //the servo is actuated with digital pin 2
  }
  
  void loop()
  {
    servoMotor.write(angle); //turn servo
    delay(500);
    servoMotor.write(0);
    delay(2000);
  }
