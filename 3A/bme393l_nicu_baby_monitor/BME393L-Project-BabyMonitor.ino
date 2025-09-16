/// START

// Define timer compare match register value
  int timer1_compare_match;

  volatile bool printFlag = false; // Set true to Serial.println(printData) once
  String printData = ""; // Data to print when [printFlag] is true

// Flags
  volatile bool flagHR = false;
  volatile bool flagRR = false;
  volatile bool flagTemp = false;
  volatile bool flagCrying = false;
  volatile bool flagAlert = false;
  volatile bool flagAlarm = false;

// Timer Variables
  volatile int systemTimer = 0;
  volatile int timerInterrupt;
  volatile int timerHR;
  volatile int timerRR;
  volatile int timerTemp;
  volatile int timerCrying;
  volatile int timerAlert;
  volatile int timerReset;
  volatile int timerChecked;

//Pin definitions
    // Pin 2 = Interrupt Pin

    // Pin 3 = HR (0 for normal, 1 for abnormal)
    // Pin 4 = RR (0 for normal, 1 for abnormal)
    // Pin 5 = Crying signal (0 for silent, 1 for crying)

    // Pin 9 = Green LED (Normal Operation)
    // Pin 10 = Blue LED (Temperature Adjusting) 
    // Pin 11 = White LED (Crying)
    // Pin 12 = Yellow LED (Alert)
    // Pin 13 = Red LED (Alarm)

    // Pin A0 (14) = Status button
    // Pin A2 (16) = Temperature value (0 for low, 1 for high)
    // Pin A3 (17) = Adjusting temperature (0 for normal, 1 for adjusting)
    // Pin A4 (18) = Checked on baby button
    // Pin A5 (19) = Reset / Clear alarm button
  const int interruptPin = 2; 
  const int tempValuePin = 16; 
  const int buttonPins[] = {3, 4, 5, 17, 18, 19, 14};  // Buttons connected to interrupt 
  const int ledPins[] = {9, 10, 11, 12, 13}; // Output LEDs
    

void setup() {
  noInterrupts();
  
  Serial.begin(9600);
 
  // Pin Setup
    // Set interrupt pin D2 as INPUT
      pinMode(interruptPin, INPUT);
    // Set temp value A2 (16) as INPUT
      pinMode(tempValuePin, INPUT);
    // Set buttons as INPUT
      for (int i = 0; i < 7; i++) {
        pinMode(buttonPins[i], INPUT);
      }
    // Set LEDs as OUTPUT
      for (int i = 0; i < 5; i++) {
        pinMode(ledPins[i], OUTPUT);
        if (i == 0) {
          digitalWrite(ledPins[i], HIGH); // Green LED initially ON
        }
        else {
          digitalWrite(ledPins[i], LOW); // Turn other LEDs off at start
        }
      }

  // Hardware Interrupts Setup
    attachInterrupt(digitalPinToInterrupt(2), hardwareISR, RISING); // void hardwareISR() runs on D2 rising edge.

  // Initialize Timer1
  TCCR1A = 0;
  TCCR1B = 0;
 
  // Set timer1_compare_match to the correct compare match register value
  // 256 prescaler & 31246 compare match = 2Hz
  // 62500 / 2 = 31250, -1 because 0 indexing
  // overflow happens after 62499 -> 0 which is OCR1A default value
  timer1_compare_match = 31249; // for ISR to fire at speed of 2Hz, 31249 -> 2^16-1
 
  // Preload timer with compare match value
  TCNT1 = timer1_compare_match;
 
  // Set prescaler to 256
  TCCR1B |= (1 << CS12);

  // Did not enable CTC mode (WGM12 = 1) which clears timer on match.
  // Enable timer interrupt for compare mode, match on OCR1A which is on default 0
  TIMSK1 |= (1 << OCIE1A);
  
  interrupts(); // enable all interrupts
}

void loop() {
  // Prints data stored in [printData] if [printFlag] is true
  if (printFlag) { 
    Serial.print(printData); // Printing [printData] to Serial Monitor
    printData = "";
    printFlag = false; // Resetting print flag, so that the data only prints once
  }
}
