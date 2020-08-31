/* Seminar pri predmetih GSV & GTV - Predloga za Arduino projekt
Student: Marko Brodarič
*/

// Vkljucimo knjiznice
#include <OneWire.h>
#include <DallasTemperature.h>

// Merilnik DS18B20 je povezan na pin 4
#define ONE_WIRE_BUS 4
OneWire oneWire(ONE_WIRE_BUS);
// Objekt za komunikacijo z merilnikom DS18B20
DallasTemperature sensors(&oneWire);

// Meritev referencne temperature
// Senzor za izvedbo meritve potrebuje 750 ms, 
// zato med izvajanjem meritve vracamo staro vrednost
float refTemperature = 0.0;
unsigned int readTimer = 0;


float linear(float prebranaTemperatura, float Tt1, float Tt2, float Td1, float Td2){
  float kt = (Tt2 - Tt1)/(Td2 - Td1);
  float nt = Tt2 - kt*Td2;
  float Td = (prebranaTemperatura - nt)/kt;
  
  return Td;
}

float readRefTemperature(){
  if (readTimer == 0) 
  {
    sensors.requestTemperatures(); 
    readTimer = millis();
    return refTemperature;
  }

  if (millis() - readTimer > 750)
  {
    readTimer = 0;
    refTemperature = sensors.getTempCByIndex(0);
  }
  return refTemperature;
}

float termoclen(){
  float Tt1 = 62.9;
  float Tt2 = 9.35;
  float Td1 = 60.3;
  float Td2 = 7.94;

  int a = analogRead(A0);
  float temp = a * 0.0032258;
  float termoTemp = (temp/0.005)-250;
  float linT = linear(termoTemp, Tt1, Tt2, Td1, Td2);
  
  return linT; 
}

float termistor(){
  int a = analogRead(A1);
  float Um = a * 0.0032258;
  float A, B, C, Y1, Y2, Y3, G1, G2, G3, L1, L2, L3, TB;
  float T2 = 295.31;
  float T1 = 324.06;
  float T3 = 279.69;
  float R2 = 10098.27;
  float R1 = 3621.86;
  float R3 = 22788.53;
  float I = Um/10000;
  float Ur = 3.3 - Um;
  float R = Ur/I;
  
  L1 = log(R1);
  L2 = log(R2);
  L3 = log(R3);
  Y1 = 1/T1;
  Y2 = 1/T2;
  Y3 = 1/T3;
  G2 = ((Y2-Y1)/(L2-L1));
  G3 = ((Y3-Y1)/(L3-L1));
  C = ((G3-G2)/(L3-L2))*pow((L1 + L2 + L3), -1);
  B = G2 - C*(L1*L1 + L1*L2 + L2*L2);
  A = Y1 - (B+ L1*L1*C)*L1;
  TB = pow((A+B*log(R)+ C*pow(log(R),3)), -1)-273;

  return TB;
}

float uporovni(){
  
  float alpha = 0.00385;
  float delta = 1.500;
  float R0 = 1000;
  float B = -1*alpha*delta*0.0001;
  float A = alpha * (1+ delta/100);
  float U = analogRead(A2);
  float Up = U*3.3/1023;
  float I = Up/R0;
  float Rtd = (3.3-Up)/I;
  float N = A*A-4*B*(1-(Rtd/R0));
  float T_U = (-A + sqrt(N))/(2*B);
  
  return T_U;
}

void setup(void)
{
  Serial.begin(9600);
  
  while (!Serial);  
  sensors.begin();
  sensors.setWaitForConversion(false);

  analogReference(EXTERNAL);
}


void loop(void)
{   
  Serial.print("  referenčni: ");  
  Serial.print(readRefTemperature());
  Serial.print("  termoclen: ");
  Serial.print(termoclen());
  Serial.print("  termistor: ");
  Serial.print(termistor());
  Serial.print("  uporovni: ");
  Serial.println(uporovni());

  delay(200);
}
