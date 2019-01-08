/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 03:
   Este trabalho tem por objetivo exercitar a implementação de um método de desenho e preenchimento de polígonos. 
   Escreva uma função que receba como entrada a descrição de um polígono com n pontos e m linhas e informações sobre 
   as cores a serem utilizadas para o desenho do polígono. A função deve desenhar as linhas de contorno do polígono 
   usando o algoritmo de desenho de linha que você projetou inicialmente e realizar o preenchimento dessa figura por 
   meio do método analítico de linha de varredura, também a ser implementado integralmente por você.
   As entradas da função devem ser:
     – uma matriz P de dimensão n x 2 contendo as coordenadas (X, Y) de cada um dos npontos;
     – uma matriz L de dimensão mx 2 indicando, para cada linha, o índice dos seus pontos extremos;
     – a cor da linha do polígono;
     – se o polígono será preenchido ou não; 
     – a cor de preenchimento do interior do polígono.
   Em seguida, modifique seu programa para demonstrar o uso dessa função no desenho e no preenchimento de vários 
   polígonos gerados aleatoriamente e usando cores para as linhas e para o preenchimento escolhidas ao acaso.
 *
**/

void setup () {
  fullScreen();
  background(50); 
}
 
void draw () {  
  // Geração de quantidades de vértices que o poligono terá
  int vertices = int(random(3, 10));
  
  // Geração de pontos
  int[][] points = new int[vertices][2];  
  for (int i = 0; i < vertices; i++) {
    points[i][0] = int(random(0, width));
    points[i][1] = int(random(0, height));       
  }
  
  // Geração das linhas
  int[][] lines = new int[vertices][2];  
  for (int i = 0; i < vertices; i++) {
    lines[i][0] = i;
    lines[i][1] = (i+1) % vertices;
  }
  
  // Geração das cores 
  int red, green, blue;
  red = int(random(0, 255));
  green = int(random(0, 255));
  blue = int(random(0, 255));  
  color cor_linha = color(red, green, blue);
  color cor_preenchimento = color(red, green, blue);
  
  // Escolha se o poligono será preenchido ou não
  boolean preenchimento;
  if (random(0, 1) > 0.5) preenchimento = true;
  else preenchimento = false;
  
  drawPolygon(vertices, points, lines, cor_linha, preenchimento, cor_preenchimento);
  delay(2000);
  
}

void DDALine (int xi, int yi, int xf, int yf, color cor) {
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
    stroke(cor);
    point(int(x), int(y));
  }
}

void drawPolygon(int v, int[][] P, int[][] L, color cor_linha, boolean preenche, color cor_preenchimento) {
  int ymin = height, ymax = 0;
  for(int i = 0; i < v; i++) {
    if(P[i][1] < ymin) ymin = P[i][1];
    if(P[i][1] > ymax) ymax = P[i][1];
    DDALine(P[L[i][0]][0], P[L[i][0]][1], P[L[i][1]][0], P[L[i][1]][1], cor_linha);
  }  
  
  if(preenche) {
    //Criar tabela de pontos. Y cresce pra baixo.
    float[][] matrixPoints = new float[v][5];
    for(int i = 0; i < v; i++) {
      if(P[L[i][0]][1] > P[L[i][1]][1]) {
        matrixPoints[i][0] = float(P[L[i][0]][1]); //ymin
        matrixPoints[i][1] = float(P[L[i][1]][1]); //ymax
        matrixPoints[i][2] = float(P[L[i][1]][0]); //xmin
        matrixPoints[i][3] = float(P[L[i][0]][0] - P[L[i][1]][0]) / float(P[L[i][0]][1] - P[L[i][1]][1]); // 1/m
        matrixPoints[i][4] = float(P[L[i][1]][0]); //xmax
      }
      else {
        matrixPoints[i][0] = float(P[L[i][1]][1]); //ymin
        matrixPoints[i][1] = float(P[L[i][0]][1]); //ymax
        matrixPoints[i][2] = float(P[L[i][0]][0]); //xmin
        matrixPoints[i][3] = float(P[L[i][0]][0] - P[L[i][1]][0]) / float(P[L[i][0]][1] - P[L[i][1]][1]); // 1/m
        matrixPoints[i][4] = float(P[L[i][0]][0]); //xmax
      }
    }
    
    // Linha de varredura
    for(int ytemp = ymin; ytemp <= ymax; ytemp++) {
      FloatList intersec = new FloatList(); 
      
      for(int i = 0; i < v; i++) {        
        // Para eliminar os lados do poligono os quais a linha de varredura não intercepta
        if(ytemp > matrixPoints[i][0] || ytemp < matrixPoints[i][1]) continue;
        else {
          // Intersecção da linha de varredura
          float x = (matrixPoints[i][3]*(float(ytemp)-matrixPoints[i][1])) + matrixPoints[i][2];
          intersec.append(x);
          
          // Considerar duas intersecções
          // !TODO
        }
      }
      
      // Ordena os valores de x
      intersec.sort(); 
      // Desenha as linhas 
      for(int i = 0; i < intersec.size()-1; i++) {
        DDALine(int(intersec.get(i)), ytemp, int(intersec.get(i+1)), ytemp, cor_preenchimento);
      }
    }
    
  }
}
