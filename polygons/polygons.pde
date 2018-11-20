/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 03
 *
**/




void setup () {
  fullScreen();
  background(0); 
}



 
void draw () {  
  // Geração de quantidades de vértices que o poligono terá
  int vertices;
  vertices = int(random(3, 10));
  
  // Geração de pontos
  int[][] pontos = new int[vertices][2];  
  for (int i = 0; i < vertices; i++) {
    pontos[i][0] = int(random(0, width));
    pontos[i][1] = int(random(0, height));       
  }
  
  // Geração das linhas
  int[][] linhas = new int[vertices][2];  
  for (int i = 0; i < vertices; i++) {
    linhas[i][0] = i;
    linhas[i][1] = (i+1) % vertices;
  }
  
  // Geração das cores 
  int r, g, b;
  r = int(random(0, 255));
  g = int(random(0, 255));
  b = int(random(0, 255));  
  color cor_linha = color(r, g, b);
  color cor_preenchimento = color(r, g, b);
  
  // Escolha se o poligono será preenchido ou não
  boolean preenchimento;
  if (random(0, 1) > 0.5) preenchimento = true;
  else preenchimento = false;
  
  desenhaPoligono(vertices, pontos, linhas, cor_linha, preenchimento, cor_preenchimento);
  
  delay(3000);
  
}




void linhaDDA (int xi, int yi, int xf, int yf, color cor) {
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
    point((int)x, (int)y);
  }
}





void desenhaPoligono(int v, int[][] P, int[][] L, color cor_linha, boolean preenche, color cor_preenchimento) {
  int ymin = height, ymax = 0;
  for(int i = 0; i < v; i++) {
    if(P[i][1] < ymin) ymin = P[i][1];
    if(P[i][1] > ymax) ymax = P[i][1];
    linhaDDA(P[L[i][0]][0], P[L[i][0]][1], P[L[i][1]][0], P[L[i][1]][1], cor_linha);
  }  
  
  if(preenche) {
    //Criar tabela de pontos. Y cresce pra baixo!!
    float[][] tabelaPontos = new float[v][5];
    for(int i = 0; i < v; i++) {
      if(P[L[i][0]][1] > P[L[i][1]][1]) {
        tabelaPontos[i][0] = float(P[L[i][0]][1]); //ymin
        tabelaPontos[i][1] = float(P[L[i][1]][1]); //ymax
        tabelaPontos[i][2] = float(P[L[i][1]][0]); //xmin
        tabelaPontos[i][3] = float(P[L[i][0]][0] - P[L[i][1]][0]) / float(P[L[i][0]][1] - P[L[i][1]][1]); // 1/m
        tabelaPontos[i][4] = float(P[L[i][1]][0]); //xmax
      }
      else {
        tabelaPontos[i][0] = float(P[L[i][1]][1]); //ymin
        tabelaPontos[i][1] = float(P[L[i][0]][1]); //ymax
        tabelaPontos[i][2] = float(P[L[i][0]][0]); //xmin
        tabelaPontos[i][3] = float(P[L[i][0]][0] - P[L[i][1]][0]) / float(P[L[i][0]][1] - P[L[i][1]][1]); // 1/m
        tabelaPontos[i][4] = float(P[L[i][0]][0]); //xmax
      }
    }
    
    // Linha de varredura
    for(int ytemp = ymin; ytemp <= ymax; ytemp++) {
      FloatList intersec = new FloatList(); 
      
      for(int i = 0; i < v; i++) {        
        // Para eliminar os lados do poligono os quais a linha de varredura não intercepta
        if(ytemp > tabelaPontos[i][0] || ytemp < tabelaPontos[i][1]) continue;
        else {
          // Intersecção da linha de varredura
          float x = (tabelaPontos[i][3]*(float(ytemp)-tabelaPontos[i][1])) + tabelaPontos[i][2];
          intersec.append(x);
          
          // Considerar duas intersecções
          // !TODO
        }
      }
      
      // Ordena os valores de x
      intersec.sort(); 
      // Desenha as linhas 
      for(int i = 0; i < intersec.size()-1; i++) {
        linhaDDA(int(intersec.get(i)), ytemp, int(intersec.get(i+1)), ytemp, cor_preenchimento);
      }
    }
    
  }
}
