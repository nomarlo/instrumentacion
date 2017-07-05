import processing.serial.*;

Serial port;
float luz = 0;
float temperatura = 0;
float humedad = 0;
float vTemperatura = 0;
float vLuz2 = 0;
float vHumedad = 0;
float vHumedad2 = 0;

int corX [] = new int[5000];
int corY[] = new int[5000];

PFont f;
PImage img;
PImage img2;

float iluminacion;
float porcentajeLlluvia;

void setup(){
  
  size(1280,821);
  port = new Serial(this, "COM8", 9600); 
  port.bufferUntil('\n');
  f = createFont("Arial",28);  
  
   
  img = loadImage("calle.jpg");
  img2 = loadImage("arcoiris.png");
  
  for(int i = 0; i < corX.length; i++){
    corX[i] = i*6;
    corY[i] = int(random(821));
  }

 
}

void draw(){
  //escenario     
   background(img);
   
   //oscuridad/luz
   iluminacion = (255 - ( 77.27 * vLuz2)) ; // 255 /3.3 * vLuz2 (max 3.3)
   tint(0, iluminacion);  // Tint black
   image(img,0,0);
   

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
   stroke (255,204,0);
   strokeWeight(0);//ponerlo a cero
   fill(255, 204, 0,vLuz);
   ellipse(1200, 50, 300, 300);
   
   //humedad
   float vHumedad = map(humedad,0,255,0,100);
   stroke (0,0,0);   
   strokeWeight(4);   
   noFill();
   
   //lluvia
   stroke(51,153,255);
   strokeWeight(3);
   
   porcentajeLlluvia = vHumedad2 / 3.3;
   
   for(int i=0; i< int(corX.length * porcentajeLlluvia) ;i++){
     point(corX[i], corY[i]);
     
     corX[i]+=10;
     corY[i]+=10;
     
     corX[i]%=1280;
     corY[i]%=821;
   }
   
   //draw font
   fill (255,255,255);
   textFont(f,22);
   text ( "Temperatura", 20, 570);
   text ( temperatura + "K", 30, 610);
   text ( vTemperatura + " V", 30, 650);
   text ( "Luz", 880, 725);
   text ( vLuz + "%", 860, 765);
   text ( vLuz2 + " V", 860, 805);
   text ( "Humedad relativa", 990, 725);
   text ( vHumedad + "%", 1030, 765);
   text ( vHumedad2 + " V", 1030, 805);


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