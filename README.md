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



 
