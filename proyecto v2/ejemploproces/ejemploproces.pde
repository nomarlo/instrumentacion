import processing.serial.*;

Serial port;
float luz = 0;
float temperatura = 0;
float humedad = 0;
float vTemperatura = 0;
float vLuz2 = 0;
float vHumedad = 0;
float vHumedad2 = 0;

PFont f;


void setup(){
  
  size(1280,821);
  port = new Serial(this, "COM3", 9600); 
  port.bufferUntil('\n');
  f = createFont("Arial",28);

}

void draw(){
  //escenario
   //background(211,211,211);
   PImage img;
   img = loadImage("fon.jpg");
    background(img);
   fill (227,227,227);
   smooth();
  
  //termometro
   stroke (255,0,0);
   strokeWeight(2);
   rect (50, 50, 20, 480);  
  
   fill(255, 0, 0);
   float vTermometro = map(temperatura,293,313,-1,-480);
   rect(57, 525 , 6, vTermometro);
  
   //luz
   float vLuz = map(luz,0,255,0,100);
   stroke (255,255,255);
   strokeWeight(4);
   fill(255, 204, 0,vLuz);
   ellipse(550, 200, 300, 300);
   
   //humedad
   float vHumedad = map(humedad,0,255,0,100);
   stroke (0,0,0);
   strokeWeight(4);   
   noFill();
   /**ellipse(980, 200, 300, 300);   
   line(820,200,840,200);
   line(1120,200,1140,200);
   line(865,85,885,105);
   line(1075,295,1095,315);
   line(1095,85,1075,105);
   line(885,295,865,315);
   line(980,40,980,60);   
   fill (255,255,255);
   textFont(f,20);   
   text ( "49.5",960 , 50);
   text ( "16.5",790 , 205);
   text ( "82.5",1135 , 205);
   text ( "33",852 , 90);
   text ( "99",1075 , 325);
   text ( "0",855 , 325);
   text ( "66",1090 , 95);**/
   
   //draw font
   fill (255,255,255);
   textFont(f,35);
   text ( "Temperatura", 20, 570);
   text ( temperatura + "K", 30, 610);
   text ( vTemperatura + " V", 30, 650);
   text ( "Luz", 520, 395);
   text ( vLuz + "%", 480, 435);
   text ( vLuz2 + " V", 480, 475);
   text ( "Humedad relativa", 850, 390);
   text ( vHumedad + "%", 890, 435);
   text ( vHumedad2 + " V", 890, 475);


}

void serialEvent (Serial port){
  
  try{
    
    temperatura = float(port.readStringUntil('\t')) * (3.3 / 255.0 ) ;
    vTemperatura = temperatura;
    temperatura  = (temperatura * 6.06) + 293;
    
    luz = float(port.readStringUntil('\t')) ;
    vLuz2 = luz * (3.3 / 255.0);
    
    humedad = float(port.readStringUntil('\n')) ;
    vHumedad2 = humedad * (3.3 / 255.0);

  }
  catch(Exception e){
        println("Error parsing:");
        e.printStackTrace();
   }

  System.out.println("temperatura: "+temperatura);
  
  System.out.println("luz: "+luz);
  
  System.out.println("humedad: "+ humedad);


}