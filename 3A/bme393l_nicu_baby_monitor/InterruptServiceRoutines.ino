ISR(TIMER1_COMPA_vect){
  TCNT1 = timer1_compare_match;

  flagCheck();

  if (flagAlarm || flagCrying || flagAlert || flagTemp) {
    digitalWrite(ledPins[0], LOW);
  }
  else {
    digitalWrite(ledPins[0], HIGH);
  }

  if (flagTemp) {
    if ((systemTimer - timerTemp) < (2*5)) {
      digitalWrite(ledPins[1], HIGH);
    }
    else {
      digitalWrite(ledPins[1], LOW);
      flagTemp = false;
      printData += "Temperature adjustment complete. \n";
      printFlag = true;
    }
  }
  

  ledStateUpdate();

  systemTimer++;
}

void hardwareISR() { // D2 rising edge detected
  //noInterrupts();
  if ((systemTimer - timerInterrupt) >= 1) {
    int pressedButton = getPressedButton(); // Identify which button was pressed

    switch (pressedButton) {
      case 0: // Pin 3 = HR is HIGH -> flashing red LED until Reset is pressed
        printData += "HR button pressed, ";
        if (!flagHR) {
          timerHR = systemTimer;
          printData += "HR abnormal \n";
        }
        else {
          printData += "HR normal \n";
        }
        flagHR = !flagHR;
        break;

      case 1: // Pin 4 = RR is HIGH
        printData += "RR button pressed, ";
        if (!flagRR) {
          printData += "RR abnormal \n";
          timerRR = systemTimer;
        }
        else {
          printData += "RR normal \n";
        }
        flagRR = !flagRR;
        break;
      case 2: // Pin 5 = Crying is HIGH
        printData += "Baby is crying :( check please! \n";
        if (!flagCrying) {
          timerCrying = systemTimer;
        }
        flagCrying = true;
        break;
      case 3: // Pin 17 = Temp is HIGH
        printData += "Temp button pressed, ";
        flagTemp = true;
        timerTemp = systemTimer;
        if (digitalRead(tempValuePin)) {
          printData += "room too hot. \n";
        }
        else {
          printData += "room too cold. \n";
        }
        printData += "Adjusting temperature for 5s... \n";
        break;

      case 4: // Pin 18 = Checked is HIGH
        printData += "Baby has been checked, baby safe :) \n";
        timerChecked = systemTimer;
        if (flagCrying) {
          printData += "It took ";
          printData += (timerChecked - timerCrying) / 2.0;
          printData += "s to check baby since crying. \n";
        }
        flagCrying = false;
        break;
      case 5: // Pin 19 = Reset is HIGH
        printData += "Reset button pressed \n";
        timerReset = systemTimer;
        flagHR = false;
        flagRR = false;
        flagAlert = false;
        flagAlarm = false;
        break;
      case 6: // Pin 14 = Status is HIGH
        printData += "[STATUS UPDATE]\n";

        printData += "System uptime: ";
        printData += systemTimer /2.0;
        printData += " s\n";

        printData += "Time since last reset: ";
        printData += (systemTimer - timerReset) / 2.0;
        printData += " s\n";
        break;
    }
    printFlag = true;
    timerInterrupt = systemTimer;
  }
  //interrupts();
}