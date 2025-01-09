#include <HTTPClient.h>
#include <ArduinoJson.h>
#include <WiFi.h>

int averageBPM;
float temperature;

// DEVICE INFORMATION
#define DEVICE_NAME "device_01"

// SERVER INFORMATION
// CHANGE THE IP TO THE ONE SHOWN THEN THE SERVER IS STARTED
#define SERVER_IP ""

// WIFI INFORMATION
#define WIFI_SSID ""
#define WIFI_PASSWORD ""

// SERVER ENDPOINTS
#define MONITOR_ENDPOINT "/monitor"

// function to send JSON object to server via POST request
void sendToServer(int pulse, float temp) {

  HTTPClient http;

  DynamicJsonDocument doc(256);
  doc["pulse"] = pulse;
  doc["temp"] = temp;
  doc["device_name"] = DEVICE_NAME;

  String payload = "";
  serializeJson(doc, payload);

  String serverURL = String(SERVER_IP) + MONITOR_ENDPOINT;
  http.begin(serverURL);
  http.addHeader("Content-Type", "application/json");
  int httpResponseCode = http.POST(payload);
  if (httpResponseCode > 0) {
    String response = http.getString();
    Serial.println(httpResponseCode);
    Serial.println(response);
  } else {
    Serial.println("Error on sending POST: " + http.errorToString(httpResponseCode));
  }
  http.end();
}


// Receive data from UART. Only processes data with valid identifiers.
void receiveData() {
  if (Serial.available() > 0) {
    String message = Serial.readStringUntil('\n');
    int delimiter = message.indexOf(":");
    if (delimiter != -1) {
      String identifier = message.substring(0, delimiter);
      float data = message.substring(delimiter + 1).toFloat();
      if (identifier == "avgBPM") {
        averageBPM = data;
      } 
      else if(identifier == "temperature" ){
        temperature = data;
      }
      else {
        // Ignore data with invalid IDs
      }
    }
  }
}

// Send data with a unique identifier for each room/location.
void sendData(String identifier, int data) {
  String message = identifier + ":" + String(data);
  Serial.println(message);
}

void setup() {
  Serial.begin(9600);
  Serial.println("Starting...");

  // CONNECT TO WIFI
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");
}

void loop() {
  receiveData();
  //initialize variables
  
  // Print phrase "BPM: "
  Serial.print("BPM: ");

  // Print the value inside of myBPM
  Serial.println(averageBPM);


  Serial.print("Temperature: ");
  
  Serial.println(temperature);


  sendToServer(averageBPM, temperature);
// Delay is not necessary, but good to not flood the server
// 5s delay
delay(5000);
}
