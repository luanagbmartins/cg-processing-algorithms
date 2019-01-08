/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 02: 
 * Programa para mostrar uma tela de cor preta e repetir a sequência de ações abaixo 
   até que o usuário pressione ESC:
     1. Determinar aleatoriamente se desenhará uma linha ou uma circunferência;
     2. Escolher aleatoriamente uma cor para os pontos a serem desenhados;
     3. Para o caso da linha, escolher aleatoriamente duas posições (xi, yi) e (xf,yf) 
          na tela e desenhar uma linha entre esses pontos; para o caso da circunferência, 
          escolher um ponto central (xc, yc) e um raio r e desenhar a circunferência.
**/

void setup () {
  fullScreen();
  background(50);
}
 
void draw () {
  int red, green, blue, x, y, xf, yf, radius;

  red = int(random(0, 254) + 1);
  green = int(random(0, 254) + 1);
  blue = int(random(0, 254) + 1);
  color lineColor = color(red, green, blue);
  
  if(random(0, 1) > 0.5) {    
    x = int(random(0, width));
    y = int(random(0, height));
    xf = int(random(0, width));
    yf = int(random(0, height));
    
    linhaDDA (x, y, xf, yf, lineColor);  
  
  } else {
    x = int(random(0, width));
    y = int(random(0, height));
    radius = int (random(0, height/2));    
    circBrasenham (x, y, radius, lineColor);
  }
  
  delay(1000);
}

void linhaDDA (int xi, int yi, int xf, int yf, color lineColor) {
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
    stroke(lineColor);
    point((int)x, (int)y);
  }
}

void circBrasenham (int xc, int yc, int radius, color lineColor) {
   int x1, y1, x2, y3, x4, y4;
   x1 = xc; y1 = yc - radius;
   x2 = xc;
   y3 = yc + radius;
   x4 = xc; y4 = yc+ radius;

   strokeWeight (4);
   stroke(lineColor);
   do {
     int mh = abs(int((pow(x1+1-xc, 2) + pow(y1-yc, 2) - pow(radius, 2))));
     int md = abs(int((pow(x1+1-xc, 2) + pow(y1+1-yc, 2) - pow(radius, 2))));
     int mv = abs(int((pow(x1-xc, 2) + pow(y1+1-yc, 2) - pow(radius, 2))));
     int di = int (pow(x1+1-xc, 2) + pow(y1+1-yc, 2) - pow(radius, 2));

     if (di == 0) {       
       point(x1+1, y1+1);
       point(x2-1, y1+1);
       point(x1+1, y3-1);
       point(x4-1, y4-1);
       x1++; y1++; x2--; y3--; x4--; y4--; 
     } else if (di < 0) {
       if (mh - md <= 0) {
         point(x1+1, y1);
         point(x2-1, y1);
         point(x1+1, y3);
         point(x4-1, y4);
         x1++; x2--; x4--;
       } else {
         point(x1+1, y1+1);
         point(x2-1, y1+1);
         point(x1+1, y3-1);
         point(x4-1, y4-1);
         x1++; y1++; x2--; y3--; x4--; y4--;
       }
     } else if (di > 0) {
       if (md - mv <= 0) {
         point(x1+1, y1+1);
         point(x2-1, y1+1);
         point(x1+1, y3-1);
         point(x4-1, y4-1);
         x1++; y1++; x2--; y3--; x4--; y4--;
       } else {
          point(x1, y1+1);
          point(x2, y1+1);
          point(x1, y3-1);
          point(x4, y4-1);
          y1++; y3--; y4--;
       }
     }      
   } while (y1 <= yc);
}
