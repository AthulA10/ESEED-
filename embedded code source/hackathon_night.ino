#include "WiFi.h"
#include "ACS712.h"
#include "ESPAsyncWebServer.h"
#include "AsyncJson.h"
#include "ArduinoJson.h"
#include <EEPROM.h>
#include <SimpleTimer.h>

#include "SPIFFS.h"
#include <ESPAsyncWiFiManager.h>       
DNSServer dns;
#include <AsyncTCP.h>
SimpleTimer timer;
ACS712 sensor(ACS712_05B,34);
static AsyncClient * aClient = NULL;
AsyncWebServer server(80);//webserver 
IPAddress local_IP(192,168,0,184);
IPAddress gateway(192, 168,0,1);
IPAddress subnet(255, 255,0, 0);
IPAddress primaryDNS(8, 8, 8, 8); 
IPAddress secondaryDNS(8, 8, 4, 4);
char buycomplete=0;
char sellcomplete=0;
char temp=0;
int toggleid=0;
double value=0;
bool buy=false;
bool sell=false;
char cmd=0;
int buyunit=0;
int sellunit=0;
int unit=0;

float I=0;
int unitcounterid=0;
void unitcounter();
void setup() {
  ledcSetup(0,100,8);
  ledcAttachPin(32,0);
  ledcWrite(0,128);
 pinMode(4,OUTPUT);//charging relay
  pinMode(5,OUTPUT);//discharging relay
  pinMode(13,OUTPUT);
  pinMode(12,OUTPUT);
  
  digitalWrite(4,HIGH);
  digitalWrite(5,HIGH);
  digitalWrite(13,LOW);
  digitalWrite(12,LOW);
 Serial.begin(9600);
  sensor.calibrate();
  if (!WiFi.config(local_IP, gateway, subnet, primaryDNS, secondaryDNS)) {
                      Serial.println("STA Failed to configure");
                    }
                  // Connect to Wi-Fi network with SSID and password
                  Serial.print("Connecting to ");
                 
                  WiFi.begin("JioFi2_040012","9ss4apic3c");
                 
                  while (WiFi.status() != WL_CONNECTED) {
                                    delay(1000);
                                 Serial.println("Connecting to WiFi..");
                             
                                   }
   
 
 Serial.println("local ip");
 Serial.println(WiFi.localIP());


  server.on(
    "/update",
    HTTP_POST,
    [](AsyncWebServerRequest * request){},
    NULL,
    [](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
    
     Serial.println((const char*)data);
     DynamicJsonBuffer jsonBuffer;
     JsonObject& root = jsonBuffer.parseObject((const char*)data);
     cmd=root["cmd"];
     unit=root["unit"];
     if(cmd==1){ value=0;buyunit=unit;buy=true;sell=false;Serial.println("buyrequest");buycomplete=0;sellcomplete=0;
     timer.enable(unitcounterid);
     timer.enable(toggleid);
     digitalWrite(4,HIGH);
     digitalWrite(5,LOW);
     }
    else if(cmd==2){value=0;sellunit=unit;buy=false;sell=true;Serial.println("sellrequest");buycomplete=0;sellcomplete=0;
     timer.enable(unitcounterid);
     timer.enable(toggleid);
     digitalWrite(4,LOW);
     digitalWrite(5,HIGH);
      }
     else{buy=false;sell=false;
     digitalWrite(4,HIGH);
     digitalWrite(5,HIGH);
     }
     request->send(200,"text/html","success");
     return 0;              

  });

  server.on(
    "/status",
    HTTP_POST,
    [](AsyncWebServerRequest * request){},
    NULL,
    [](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
   
     DynamicJsonBuffer jsonBuffer;
     int gy=abs(I*1000); 
    AsyncResponseStream *response = request->beginResponseStream("application/json"); 
                                                                  JsonObject &auth = jsonBuffer.createObject();
                                                                 
                                                                  auth["current"] =gy;
                                                                  auth["buy"]=buycomplete;
                                                                   auth["sell"]=sellcomplete;
                                                                  auth.printTo(*response);
                                                                  request->send(response);
 if(buycomplete==1){buycomplete=0; digitalWrite(4,HIGH);
    digitalWrite(5,HIGH);
    Serial.println("mission completed");}
 if(sellcomplete==1){sellcomplete=0;
  digitalWrite(4,HIGH);
    digitalWrite(5,HIGH);
    Serial.println("mission completed");}
                                                                  
     Serial.println("status data query");
  
     request->send(200,"text/html","success");
     return 0;              

  });
 
 unitcounterid = timer.setInterval(1000,unitcounter);
 toggleid=timer.setInterval(100,toggle);
 timer.disable(toggleid);
 timer.disable(unitcounterid);
 server.begin();
}

void loop() {

 timer.run();
 
}

void unitcounter(){

   I = sensor.getCurrentDC();
  
  Serial.println(String("I = ") + I + " A");
  value=value+abs(I);
  Serial.print("value ");
  Serial.println(value);
  
  if(value>=unit){
    if(buy==true){buycomplete=1;sellcomplete=0;}
    else if(sell==true){sellcomplete=1;buycomplete=0;}
    I=0;
    timer.disable(toggleid);
    timer.disable(unitcounterid);
   
  }
 
  
}
void toggle(){
  if(cmd==1){
    digitalWrite(12,LOW);
    if(temp==1){temp=0;digitalWrite(13,LOW);}
    else if(temp==0){temp=1;digitalWrite(13,HIGH);}
    
    
  }
  if(cmd==2){
     digitalWrite(13,LOW);
    if(temp==1){temp=0;digitalWrite(12,LOW);}
    else if(temp==0){temp=1;digitalWrite(12,HIGH);}
  }
  
  
  }

