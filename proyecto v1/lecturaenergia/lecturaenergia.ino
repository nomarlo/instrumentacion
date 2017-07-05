void setup(){

  Serial.begin(9600); // iniciar la comuniacion serial

}

void loop(){

  String t = String(map(analogRead(A0), 0, 1023, 0, 255)); 
  
  String l = String(map(analogRead(A3), 0, 1023, 0, 255)); 
  
  String h = String(map(analogRead(A4), 0, 1023, 0, 255)); 
  
  Serial.println(t + '\t' + l + '\t' + h); 
  
  delay(500);//retraso de medio segundo para mantener estables los valores

}


