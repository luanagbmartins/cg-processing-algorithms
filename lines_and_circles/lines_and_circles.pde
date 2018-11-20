/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 02: 
 * Programa para mostrar uma tela de cor preta e repetir a sequência de ações abaixo até que o usuário pressione ESC:
     1. Determinar aleatoriamente se desenhará uma linha ou uma circunferência;
     2. Escolher aleatoriamente uma cor para os pontos a serem desenhados;
     3. Para o caso da linha, escolher aleatoriamente duas posições (xi, yi) e (xf,yf) 
          na tela e desenhar uma linha entre esses pontos; para o caso da circunferência, 
          escolher um ponto central (xc, yc) e um raio r e desenhar a circunferência.
**/




void setup () {
  fullScreen();
  background(0);
}



 
void draw () {
  int r, g, b, x, y, xf, yf, radius;
  
  if(random(0, 1) > 0.5) {
    r = int(random(0, 254) + 1);
    g = int(random(0, 254) + 1);
    b = int(random(0, 254) + 1);
    x = int(random(0, width));
    y = int(random(0, height));
    xf = int(random(0, width));
    yf = int(random(0, height));
    
    linhaDDA (x, y, xf, yf, r, g, b);  
  
  }
  else {
    r = int(random(0, 254) + 1);
    g = int(random(0, 254) + 1);
    b = int(random(0, 254) + 1);
    x = int(random(0, width));
    y = int(random(0, height));
    radius = int (random(0, height/2));    
    circBrasenham (x, y, radius, r, g, b);
  }
  
  delay(1000);
  
}




void linhaDDA (int xi, int yi, int xf, int yf, int r, int g, int b) {
  int dx = xf - xi, dy = yf - yi, steps, k;
  float incX, incY, x = xi, y = yi;
  
  if (abs(dx) > abs(dy)) steps = abs(dx);
  else steps = abs(dy);
  
  incX = dx / (float) steps;
  incY = dy / (float) steps;
  
  for (k = 0; k < steps; k++) {
    x = x + incX;
    y = y + incY;
    strokeWeight (4);
    stroke(r, g, b);
    point((int)x, (int)y);
  }
}




void circBrasenham (int xc, int yc, int radius, int r, int g, int b) {
   int xi, yi, x2, y3, x4, y4;
   xi = xc; yi = yc - radius;
   x2 = xc;
   y3 = yc + radius;
   x4 = xc; y4 = yc+ radius;
   
   
   do {
     int mh = abs(int((pow(xi+1-xc, 2) + pow(yi-yc, 2) - pow(radius, 2))));
     int md = abs(int((pow(xi+1-xc, 2) + pow(yi+1-yc, 2) - pow(radius, 2))));
     int mv = abs(int((pow(xi-xc, 2) + pow(yi+1-yc, 2) - pow(radius, 2))));
     int di = int (pow(xi+1-xc, 2) + pow(yi+1-yc, 2) - pow(radius, 2));
          
     if (di == 0) {
       strokeWeight (4);
       stroke(r, g, b);
       point(xi+1, yi+1);
       point(x2-1, yi+1);
       point(xi+1, y3-1);
       point(x4-1, y4-1);
       xi++; yi++; x2--; y3--; x4--; y4--; 
     }
     else if (di < 0) {
       if (mh - md <= 0) {
         strokeWeight (4);
         stroke(r, g, b);
         point(xi+1, yi);
         point(x2-1, yi);
         point(xi+1, y3);
         point(x4-1, y4);
         xi++; x2--; x4--;
       }
       else {
         strokeWeight (4);
         stroke(r, g, b);
         point(xi+1, yi+1);
         point(x2-1, yi+1);
         point(xi+1, y3-1);
         point(x4-1, y4-1);
         xi++; yi++; x2--; y3--; x4--; y4--;
       }
     } 
     else if (di > 0) {
       if (md - mv <= 0) {
         strokeWeight (4);
         stroke(r, g, b);
         point(xi+1, yi+1);
         point(x2-1, yi+1);
         point(xi+1, y3-1);
         point(x4-1, y4-1);
         xi++; yi++; x2--; y3--; x4--; y4--;
         
       }
       else {
         strokeWeight (4);
         stroke(r, g, b);
          point(xi, yi+1);
          point(x2, yi+1);
          point(xi, y3-1);
          point(x4, y4-1);
          yi++; y3--; y4--;
       }
     }      
     
   } while (yi <= yc);
}
