// Method to return the index of button HIGH at the time called
int getPressedButton() { 
  for (int i = 0; i < 7; i++) {
    if (digitalRead(buttonPins[i]) == HIGH) {
      return i;
    }
  }
  return -1; // No button press detected
}

void flagCheck() {
  if (!flagAlarm) {
    if (flagHR) { // if HR is abnormal
      if ((systemTimer - timerHR) >= (2*3)) { // if HR abnormal for 3 seconds
        if (!flagAlarm) {
          printData += "HR abnormal for 3s, alarm state entered \n";
          printFlag = true;
        }
        flagAlarm = true; // turn on alarm
      }
    }

    if (flagRR) {
      if ((systemTimer - timerRR) >= (2*3)) {
        if (!flagAlert) {
          printData += "RR abnormal for 3s, alert state entered \n";
          printFlag = true;
          flagAlert = true;
          timerAlert = systemTimer;
        }
      }
    }

    if (flagAlert) {
      if ((systemTimer - timerAlert) >= (2*3)) {
        if (flagRR) {
          if (!flagAlarm) {
            printData += "RR abnormal for 3s while alert state, alarm state entered \n";
            printFlag = true;
            flagAlarm = true;
            flagAlert = false;
          }
        }
        else {
          printData += "RR back to normal at the end of alert state \n";
          printFlag = true;
          flagAlert = false;
        }
      }
    }
  }
  else {
    flagHR = false;
    flagRR = false;
    flagAlert = false;
    flagCrying = false;
  }
}

void ledStateUpdate() {
  
  if (flagCrying) {
    digitalWrite(ledPins[2], digitalRead(ledPins[2]) ^ 1);
  }
  else {
    digitalWrite(ledPins[2], LOW);
  }

  if (flagAlert) {
    digitalWrite(ledPins[3], HIGH);
  }
  else {
    digitalWrite(ledPins[3], LOW);
  }

  if (flagAlarm) {
    digitalWrite(ledPins[0], LOW);
    digitalWrite(ledPins[2], LOW);
    digitalWrite(ledPins[3], LOW);
    digitalWrite(ledPins[4], digitalRead(ledPins[4]) ^ 1);
  }
  else {
    digitalWrite(ledPins[4], LOW);
  }
}