  //Arduino Servo programm
  //This programm rotates the Servo on "angle" degress angle after "t" seconds and back
  
  #include <Servo.h>
  
  Servo servoMotor; //define the servo object
  int angle=40; //define the rotatinal angle
  //int t=2; //define the time (minutes) between actuations of the motor
  
  void setup()
  {
    servoMotor.attach(13); //the servo is actuated with digital pin 2
    servoMotor.write(0); ///set the initial angle to zero
    //t=t*60;
  }
  
  void loop()
  {
    servoMotor.write(angle); //turn servo
    delay(500);
    servoMotor.write(0);
    delay(1080000); //1080000 ms = 18 minutes
  }
  

