// Define the pulse sensor pin 

const int PulseSensorPin = A0; 

 

// Variable to store the sensor reading 

int Signal; 

 

// Threshold for detecting a pulse 

int Threshold = 512; 

 

// Variables for time tracking 

unsigned long currentTime; 

unsigned long previousTime; 

 

// Libraries for the temperature sensor 

#include <OneWire.h> 

#include <DallasTemperature.h> 

 

// Data wire 

#define ONE_WIRE_BUS 10 

 

// Setup oneWire instance to communicate with oneWire devices 

OneWire oneWire(ONE_WIRE_BUS); 

 

DallasTemperature tmpSensor(&oneWire); 

 

// Function to receive data from UART 

void receiveData() { 

  if (Serial.available() > 0) { 

    // Read the incoming message until newline character 

    String message = Serial.readStringUntil('\n'); 

    // Find the position of the colon (":") in the message 

    int delimiter = message.indexOf(":"); 

    if (delimiter != -1) { 

      // Extract the identifier and data from the message 

      String identifier = message.substring(0, delimiter); 

      int data = message.substring(delimiter + 1).toInt(); 

 

      // Assign the received data based on the identifier 

      if (identifier == "datos") { 

        int datos = data; 

      } else { 

        // Ignore data with unrecognized identifiers 

      } 

    } 

  } 

} 

 

// Function to send integer data over UART 

void sendData(String identifier, int data) { 

  String message = identifier + ":" + String(data); 

  Serial.println(message); 

} 

 

// Function to send float data over UART 

void sendData(String identifier, float data) { 

  String message = identifier + ":" + String(data); 

  Serial.println(message); 

} 

 

void setup() { 

  Serial.begin(9600); 

 

  // Start the temperature sensor library 

  tmpSensor.begin(); 

} 

 

void loop() { 

  int averageBPM; 

  // Call the function to receive data from UART 

  receiveData(); 

  // Get the current time 

  currentTime = millis(); 

  // Read the analog value from the pulse sensor 

  Signal = analogRead(PulseSensorPin); 

 

  // Check if the signal is above the threshold and a beat is not already detected 

  if (Signal > Threshold) { 

 

    if (previousTime != 0) {  // Check if this is not the first beat 

      // Calculate the duration between beats 

      unsigned long duration = currentTime - previousTime; 

 

      // Variables for calculating average BPM 

      int totalBPM = 0; 

      int test = 20;  // Number of samples for calculating average BPM 

 

      // Calculate total BPM over 'test' number of samples 

      for (int i = 0; i < test; i++) { 

        int BPM = 60000 / duration; 

        totalBPM += BPM; 

      } 

 

      // Request temperature from the sensor 

      tmpSensor.requestTemperatures(); 

       

      // Read temperature in Celsius 

      float tempC = tmpSensor.getTempCByIndex(0); 

 

      // Calculate average BPM 

      averageBPM = totalBPM / test; 

 

      // Send temperature and average BPM over UART 

      sendData("temperature", tempC); 

      sendData("avgBPM", averageBPM); 

    } 

 

    // Update the previous time to the current time 

    previousTime = currentTime; 

  } 

 

  // Add a delay to avoid reading the sensor too frequently 

  delay(1000); 

} 
