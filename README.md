# Vitals Monitoring System

Vital Monitoring System Circuit physical implementation. 

The Pulse Sensor: 
The pulse sensor’s signal pin is connected to the analog pin A0 on the Arduino Uno. 
The pulse sensor’s VCC pin to the 5V pin on the Arduino Uno. 
The pulse sensor’s GND (ground pin to the GND pin on the Arduino Uno. 
The pulse sensors documentation specifies that the sensor can operate within the 3.3V to 5V range, using 5V pin on the Arduino Uno simplifies the wiring and setup process, as you can directly connect the pulse sensor's VCC pin to the available 5V power supply pin on the Arduino. 

DS18B20 Temperature Sensor: 
The DS18B20’s data pin (yellow wire) is connected to the digital pin 10 on the Arduino Uno.  
The DS18B20’s VCC (red wire) to the 3.3V pin on the Arduino Uno. 
The DS18B20’s datasheet states that the minimum it can operate at is 3.0V. Using 3.3V is sufficient voltage to operate the DS18B20 temperature sensor.  
The DS18B20’s GND (black wire) to the GND pin on the Arduino Uno. 

A 4.7K Ω resistor is connected between the DS18B20’s data pin (yellow wire) and the 3.3V pin on the Arduino Uno. This ensures that the DS18B20 temperature sensor can be properly read by the Arduino Uno using the OneWire protocol. The resistor between the data line and the power line helps to ensure reliable communication between the sensor and the Arduino Uno. 

ESP32: 
UART Communication: 
The ESP32 communicates with the Arduino Uno using UART communication. 
UART Communication requires two data lines: TX (transmit) and RX (receive). 
The Arduino Uno and the ESP32 are connected point-to-point, they directly communicate with each other without any additional components in between. 

The TX and RX pins: 
The ESP32’s TX (transmit) pin is connected to the Arduino Uno’s RX (receive pin). 
Connecting the ESP32’s TX pin to the Arduino Uno’s RX pin so that the data transmitted by the ESP32 can be received by the Arduino Uno.
The ESP32’s RX (receive) pin is connected to the Arduino Uno’s TX (transmit) pin. 
Connecting the ESP32’s RX pin to the Arduino Uno’s TX pin so that the data transmitted by the Arduino Uno can be received by the ESP32. 
Connecting the TX and RX pins in this manner establishes bidirectional communication between the two devices. Data transmitted by one device's TX pin is received by the other device's RX pin, and vice versa, enabling them to exchange information. 

Arduino Code:
Pulse Sensor Setup 
The pulse sensor is a very basic analog sensor that outputs a voltage signal proportional to the heart rate or pulse rate of the persons I’s attached to. 
The pin to which the pulse sensor is connected to the Arduino Uno is defined as “PulseSensorPin”. The A0 indicates its connected to analog pin 0 on the Arduino Uno. 
An “int” variable named “Signal” is declared to store the analog readings from the pulse sensor.  
The int variable “Threshold” is set to the value “512”.  
Why “512”?  
This value represents the threshold above which a pulse is considered detected by us after adjusting and observing the characteristics of the pulse sensor. 
This setup prepares the Arduino Uno to read analog voltage values from the sensor. 
The variables currentTime and previousTime are two unisigned long variables that allows for a larger range of values. This ensures that the time tracking variables can accommodate long durations without overflowing ensuring compatibility with Arduino functions. 
currentTime is updated with the current time since the Arduino started running. 
previousTime stores the time of the previous pulse detection. 

Temperature Sensor Setup 
The temperature sensor used in this project is the DS18B20, is a digital waterproof temperature sensor. 
For the DS18B20 two libraries are included: 
OneWire.h: 
The OneWire library provides functions for communication with OneWire devices, such as the DS18B20 temperature sensor. 
DallasTemperature.h: 
This library allows interfacing dallas temperature sensors such as the DS18B20. 
The data wire for the temperature sensor is defined with #define ONE_WIRE_BUS 10. The signal is connected to digital pin 10 on the Arduino Uno. 
An instance of the OneWire class named oneWire is created, initialized with the pin defined in #define ONE_WIRE_BUS 10. This instance is used for communication with the DS18B20 sensor.  
Another instance of the DallasTemperature class named tmpSensor is created, passing the oneWire instance to its constructor.  
The constructor of the DallasTemperature class expects a reference to an instance of the OneWire class. By passing &oneWire as an argument to the constructor, we provide the tmpSensor instance with access to the OneWire bus, which is necessary for communication with the DS18B20 temperature sensor. 
This instance is used for interfacing with the DS18B20 sensor specifically.  

UART Communication Setup
The receiveData() function is responsible for receiving data from the ESP32 over UART. 
 If (Serial.available() > 0) 
First checks if there is data available to read from the serial port.  
String message = Serial.readStringUntil('\n'); 
If there is data available, then it reads the incoming message until it encounters a newline character (‘\n’). This allows it to read the entire message sent from the ESP32.  
int delimiter = message.indexOf(":"); 
Next, it finds the position of the colon in the message using the indexOf() function. The colon is used as a delimiter to separate the identifier and the data in the message. 
if (delimiter != -1) 
If a colon is found, it extracts the identifier and data from the message using the  
String identifier = message.substring(0, delimiter); 
int data = message.substring(delimiter + 1).toInt(); 
Then it converts the extracted data from string to integer using the toInt() function 
Finally, it checks the identifier to determine the type of data received and assigns the data accordingly. In the code, if the identifier is “datos”, it assigns the received data ro an integer variable “datos”. Otherwise it ignores the data with unrecognized identifiers. 
sendData() functions: 
These functions are responsible for sending data over UART to the ESP32. 
There are two overloaded versions of the sendData() function: one for sending integer data and another for sending float data. 
The function that sends integer data is for the pulse sensor and the function that sends float data is for the temperature sensor. 
Each function takes two parameters: the identifier of the data and the data itself. 
It constructs a message by concatenating the identifier, colon (‘:’) and the data converted to string using String(data) 
Finally, it sends the constructed message over the serial port using ‘Serial.println()’. 

Setup function
Initialize serial communication with a baud rate of 9600 using the Serial.begin() function. This sets up communication with the ESP32 over UART.  
Start the communication with the DS18B20 temperature sensor using the tmpSensor.begin() function. This prepares the sensor for temperature readings. 

Loop function
Int averageBPM; 
Declares a variable to store the average beats per minute (BPM) calculated from the pulse sensor readings. 
receiveData(); 
call the receiveData() function to check for any incoming data from the ESP32 over UART. This function parses incoming messages and extracts relevant data if available. 
Start time tracking: 
currentTime = millis(); 
Obtains the current time in milliseconds since the Arduino board started running using the millis() function. This time tracking is essential for calculating the duration between pulse detections. 
Start pulse detections: 
Signal = analogRead(PulseSensorPin); 
Reads the analog value from the pulse sensor connected to the PulseSensorPin. The obtained signal strength is stored in the Signal variable.  
If (Signal > Threshold)  
Checks if the signal strength exceeds the predetermined threshold indicating the detection of a pulse. 
Calculate duration between beats: 
If a pulse is detected and it’s not the first beat (previousTime != 0), the duration between the current time and the previous pulse detection time is calculated. 
This duration represents the time elapsed since the last pulse was detected and is used to calculate the BPM. 
Calculate Average BPM: 
The duration between beats is used to calculate the BPM. Since the duration is in milliseconds, BPM is calculated as “60000 / duration” to convert milliseconds to minutes. 
The BPM is calculated test number of times (20 in this case) to obtain a more accurate average BPM. 
The total BPM calculated over the test number of samples is accumulated in the totalBPM variable.  
Temperature Reading: 
The temperature is read from the DS18B20 temperature sensor using the requestTemperatures() and getTempCByIndex(0) functions. 
requestTemperatutres() 
This function initiates a temperature reading from the DS18B20 sensor. When called, it sends a command to the DS18B20 sensor to start temperature conversion.  After the command is sent, the Arduino waits for the sensor to complete the conversion process before retrieving the temperature value.  
getTempCByIndex(0) 
This function retrieves the temperature reading from the DS18B20 sensor in Celsius. The 0 parameter indicated the index of the sensor when multiple DS18B20 sensors are connected in a network. For the projects case, its used to specify the first and only DS18B20 sensor connected to the Arduino. 
Once the temperature conversion initiated by requestTemperatures is complete, getTempCByIndex(0) reads the temperature value stored in the sensor’s memory and returns it as a floating-point value that represents the temperature in degrees Celsisus. 
Calculate Average BPM: 
As part of the pulse detection process, we calculate the BPM for each detected pulse. These BPM values are accumulated over a specified number of samples to obtain a total sum of BPM values. 
After accumulating the total BPM values, we divide the sum by the number of samples to calculate the average BPM.  
The test variable represents the number of samples taken to calculate the average. In this case 20 meaning it averages the BPM values over 20 samples. 
The accumulated total BPM is divided by the number of samples (test) to calculate the average BPM.  
Data Transmission: 
The calculated temperature and average BPM are sent over UART to the ESP32 using the sendData() function. 
Update Previous Time: 
The previousTime variable is updated to the current time to keep track of the time of last pulse detection. 
Delay: 
A delay of 1000 milliseconds (1 second) is added to avoid reading the pulse sensor too frequently. This delay helps control the sampling rate of the sensor. 

ESP 32 Code: 
Libraries: 
HTTPClient.h: This library provides functions to perform HTTP requests. 
ArduinoJson.h: This library allows working with JSON data, useful for constructing and parsing JSON objects. 
WiFi.h: This library enables the ESP32 to connect to a WiFi network. 

Data Variables: 
averageBPM: Integer variable that stores the average beats per minute (BPM) measured by the pulse sensor. 
temperature: Floating Point variable that stores the temperature value read by the temperature sensor. 

Device Information:  
DEVICE_NAME: Defines a name for the device. It can be used to identify the source of data when sent to the server. The device name is set up with the identifier “device_01”. 

Server Information: 
SERVER_IP: Specifies the IP address and port where the server is hosted. This IP must be modified every time that the server is updated. 

Wifi Information: 
WIFI_SSID: Defines the SSID (name) of the WiFi network. 
WIFI_PASSWORD: Specifies the password for the WiFi network. 

Server Endpoint:
MONITOR_ENDPOINT: Server Endpoint accessed by the client. This endpoint will receive the sent data.  

sendToServer(int pulse, float temp): This function constructs a JSON object with pulse and temperature data along with the device name. It then sends this JSON data to the server using an HTTP POST request. 

serializeJson(doc, payload): This function serializes the data in the json object. Serialization is the process of converting an object, (in this case DynamicJsonDocument doc), into a stream of bytes in order to easily save and transmit it. 

String serverURL: Creates a string variable to hold the complete URL for the server, including the endpoint where the data will be sent. 

String(SERVER_IP): Converts the SERVER_IP (server IP address and port) to a string. 

+ MONITOR_ENDPOINT: Appends the MONITOR_ENDPOINT (endpoint where data will be sent) to the server URL.

http.begin(serverURL): Initializes an HTTP client object (http) and specifies the server URL it will communicate with. 

http.addHeader("Content-Type", "application/json"): Adds a header to the HTTP request indicating that the content being sent is in JSON format. 

http.POST(payload): Sends a POST request to the server with the payload (data to be sent) provided as an argument. In this case, payload contains the JSON data with pulse, temperature, and device name. 

Response handling: 
Checks if the HTTP response code is greater than 0, indicating a successful request. 
If successful, retrieves the response from the server, prints the HTTP response code, and prints the response data to the serial monitor. 
If unsuccessful, prints an error message with the corresponding error code using http.errorToString(httpResponseCode). 

http.end(): Closes the HTTP connection, releasing resources associated with the HTTP client object. 

receiveData(): Reads data from the serial port, extracts pulse and temperature data, and updates the corresponding variables (averageBPM and temperature). 

sendData(String identifier, int data): This function sends data associated with a unique identifier. 

void setup(): Initializes serial communication at a baud rate of 9600. 
Attempts to connect to the WiFi network specified by WIFI_SSID and WIFI_PASSWORD. It waits until the connection is established and then prints a message indicating successful connection. 

void loop(): This function Calls receiveData() to read data from the serial port and update averageBPM and temperature. It also Prints the received pulse and temperature values to the serial monitor. Then it Calls sendToServer() to send the data to the server. 
And finally,  it Includes a delay of 5 seconds (delay(5000)) to prevent sending data too frequently and overwhelming the server. 

Init:
Import Statements: 
from flask import Flask: Imports the Flask class for creating the application. 
from flask_sqlalchemy import SQLAlchemy: Imports SQLAlchemy for interacting with the database. 
from app.models import db: Imports the db object from the app.models module, presumably containing SQLAlchemy models. 

Application Setup: 
Creates a Flask application instance named app. 
Configures the database URI (SQLALCHEMY_DATABASE_URI) to connect to a MySQL database named micro on localhost with the username root and password BZ5cSgzCH!. 
Disables modification tracking (SQLALCHEMY_TRACK_MODIFICATIONS) to avoid unnecessary overhead. 
Initializes the SQLAlchemy database with the Flask application using db.init_app(app). 

Importing Application Components: 
Imports other parts of the application that require the initialized app and db. This includes views and the monitor script. 

Main Section: 
Checks if the script is being run directly (__name__ == "__main__"). 
If so, starts the Flask application with app.run(). 

Monitor:
Import Statements: 
from flask import request, jsonify: Imports the necessary modules from Flask to handle HTTP requests and JSON responses. 
from app.models import Device, Monitor: Imports the Device and Monitor models from the app.models module. 
from app import app, db: Imports the Flask application instance (app) and the database instance (db) from the app package. 

monitor Function: 
Decorated with @app.route('/monitor', methods=['POST']), indicating that this function handles POST requests to the /monitor endpoint. 
Retrieves JSON data from the request body using request.get_json(). 
Checks if all required data fields (device_name, pulse, and temp) are present in the received JSON data. If any field is missing, it returns a JSON response with an error message and status code 400 (Bad Request). 
Queries the database to find the device with the given device_name. 
If the device is not found, it returns a JSON response with an error message and status code 404 (Not Found). 
Determines if there are alerts for high pulse rate (pulse_alert) or high temperature (temp_alert) based on predefined thresholds (pulse > 100 and temperature > 37.5). 
Creates a new instance of the Monitor model with the received data and alerts. 
Adds the monitor object to the database session and commits the transaction. 
Returns a JSON response with a success message and status code 201 (Created) after recording the monitor data. 

Models: 
Import Statement: 

from flask_sqlalchemy import SQLAlchemy: Imports SQLAlchemy for defining database models. 

  

Database Initialization: 

db = SQLAlchemy(): Creates a SQLAlchemy object named db which will be used to define the database models. 

  

Model Definitions: 

User Model: 
Defines a table named user with columns: 
user_id: Integer primary key that auto-increments. 
username: String with a maximum length of 255 characters, which must be unique and cannot be null. 
name: String with a maximum length of 255 characters, which cannot be null. 
hash: Text field, which cannot be null. 
Establishes a one-to-many relationship with the Device model. 

Device Model: 
Defines a table named device with columns: 
device_id: Integer primary key that auto-increments. 
device_name: String with a maximum length of 255 characters, which cannot be null. 
user_id: Integer foreign key referencing the user_id column of the User table. 
Establishes a one-to-many relationship with the Monitor model. 

Monitor Model: 
Defines a table named monitor with columns: 
monitor_id: Integer primary key that auto-increments. 
avg_temp: BigInteger field for average temperature. 
avg_pulse: BigInteger field for average pulse. 
timestamp: TIMESTAMP field with a default value of the current timestamp. 
pulse_alert: Enum field with values 'yes' or 'no', defaulting to 'no'. 
temp_alert: Enum field with values 'yes' or 'no', defaulting to 'no'. 
device_id: Integer foreign key referencing the device_id column of the Device table. 

Each model corresponds to a table in the database, with columns defined as class attributes. 
Relationships: 
User has a one-to-one relationship with Device. 
Device has a one-to-many relationship with Monitor.

Views:
Import Statements: 
from flask import render_template: Imports the render_template function from Flask, which is used to render HTML templates. 

Application Setup: 
from app import app: Imports the Flask application instance created in the app package. 

Database Model Import: 
from app.models import db, Monitor: Imports the SQLAlchemy database instance (db) and the Monitor model from the app.models module. 

Route Definition: 
@app.route('/'): Decorator that defines the route for the root URL ('/'). 
def index(): Function that will be executed when a request is made to the root URL. 

Inside the function: 
Queries the database to retrieve the latest monitor record ordered by timestamp in descending order (Monitor.query.order_by(Monitor.timestamp.desc()).first()), storing it in latest_monitor. 
Queries all monitor records ordered by timestamp in descending order (Monitor.query.order_by(Monitor.timestamp.desc()).all()), storing them in all_monitors. 
Renders the HTML template index.html using render_template, passing the latest_monitor and all_monitors variables to the template for display. 

Return Statement: 
Returns the rendered HTML content to the client. 

Database:
user Table: 
Columns: 
user_id (Primary Key, Auto Increment): Unique identifier for each user. 
username: Username of the user. 
name: Name of the user. 
hash: Hashed password or security hash for the user. 
Purpose: Stores basic user information. 

device Table: 
Columns: 
device_id (Primary Key, Auto Increment): Unique identifier for each device. 
device_name: Name or identifier of the device. 
user_id (Foreign Key): Links to user_id in the user table, representing the user who owns the device. 
Purpose: Stores information about devices associated with users. 

monitor Table: 
Columns: 
monitor_id (Primary Key, Auto Increment): Unique identifier for each monitoring entry. 
avg_temp: Average temperature recorded by the device. 
avg_pulse: Average pulse rate recorded by the device. 
timestamp: Timestamp of when the monitoring data was recorded. 
pulse_alert: Indicates if there was a pulse rate alert ('yes' or 'no'). 
temp_alert: Indicates if there was a temperature alert ('yes' or 'no'). 
device_id (Foreign Key): Links to device_id in the device table, representing the device that recorded the monitoring data. 
Purpose: Stores monitoring data related to temperature, pulse rate, and alerts for each device. 

Relationships: 
The user interacts with one device (user to device is a one-to-one relationship). 
Each device can have multiple monitoring entries (device to monitor is a one-to-many relationship). 



 
 

 



 
