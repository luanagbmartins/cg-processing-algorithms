final int axisLinhas = 9;
final int axisVertices = 12; 

class Cubo3D {
  int projecao;
  float xMedio, yMedio, zMedio;
  
  int pontos = 8+axisVertices, linhas = 12+axisLinhas;

  float[][] mPontos;
  float[][] auxPontos;

  int[][] mLinhas;
  color corLinha;
  color[] axisColors;

  float[] rotacao;
  float[] escala;
  float[] translacao;
  float[] translacao2;

  Cubo3D() {
    projecao = 0;

    this.auxPontos = new float[pontos][3];

    float[][] mPontos = {
      {-10, -10, 10}, 
      {-10, -10, -10}, 
      {10, -10, -10}, 
      {10, -10, 10}, 
      {10, 10, 10}, 
      {-10, 10, 10}, 
      {-10, 10, -10}, 
      {10, 10, -10},

      {15, 0, 0},
      {-15, 0, 0},
      {0, 15, 0},
      {0, -15, 0},
      {0, 0, 15},
      {0, 0, -15},

      {12.8, 2, 0},
      {2, 12.8, 0},
      {2, 0, 12.8},
      {12.8, -2, 0},      
      {-2, 12.8, 0},   
      {-2, 0, 12.8}
    };
    this.mPontos = mPontos;

    int[][] mLinhas = {
      {0, 1}, 
      {1, 2}, 
      {2, 3}, 
      {3, 0}, 
      {4, 5}, 
      {5, 6}, 
      {6, 7}, 
      {7, 4}, 
      {0, 5}, 
      {1, 6}, 
      {2, 7}, 
      {3, 4},
      {8, 9},
      {10, 11},
      {12, 13},
      {8, 14},
      {10, 15},
      {12, 16},
      {8, 17},
      {10, 18},
      {12, 19}
    };
    this.mLinhas = mLinhas;

    this.axisColors = new color[3];
    this.axisColors[0] = color(255, 0, 0);
    this.axisColors[1] = color(0, 255, 0);
    this.axisColors[2] = color(0, 0, 255);

    float[] rotacao = {0.001, 0.001, 0.001};
    this.rotacao = rotacao;

    float[] escala = {10.0, 10.0, 10.0};
    this.escala = escala;
    
    float[] translacao = {0, 0, 0};
    this.translacao = translacao;

    float[] translacao2 = {width/2.0, height/2.0, 0};
    this.translacao2 = translacao2;
  }

  void proximaProjecao() {
    projecao++;
    if (projecao > 4) projecao = 0;
  }

  int getProjecao() {
    return projecao;
  }

  void calcX() {
    this.xMedio = 0;
    for (int i = 0; i < pontos; i++) {  
      xMedio += this.auxPontos[i][X];
    }
    this.xMedio /= pontos;
  }

  int getX() {
    this.calcX();
    return int(xMedio);
  }  

  void calcY() {
    this.yMedio = 0;
    for (int i = 0; i < pontos; i++) {  
      yMedio += this.auxPontos[i][Y];
    }
    this.yMedio /= pontos;
  }

  int getY() {
    this.calcY();
    return int(yMedio);
  }  

  void calcZ() {
    this.zMedio = 0;
    for (int i = 0; i < pontos; i++) {  
      zMedio += this.auxPontos[i][Z];
    }
    this.zMedio /= pontos;
  }

  int getZ() {
    this.calcZ();
    return int(zMedio);
  }

  void rotacao(float x, float y, float z) {
    rotacao[X] += x;
    rotacao[Y] += y;
    rotacao[Z] += z;
  }

  void escala(float x, float y, float z) {
    escala[X] += x;
    escala[Y] += y;
    escala[Z] += z;
  }

  void translacao(float x, float y, float z) {
    translacao[X] += x;
    translacao[Y] += y;
    translacao[Z] += z;
  } 

  // Mudar cor do objeto selecionado para vermelho
  public void selecionado() {
    this.corLinha = color(255, 0, 0);
  }

  // Mudar cor do objeto não selecionado para preto
  public void naoSelecionado() {
    this.corLinha = color(0, 0, 0);
  }

  public void calPosicao() {
    // Rotacao
    for (int i = 0; i < pontos; i++) {
      // Rotação em x
      this. auxPontos[i][Y] = (mPontos[i][Y] * cos(rotacao[X])) - (mPontos[i][Z] * sin(rotacao[X])); 
      this.auxPontos[i][Z] = (mPontos[i][Y] * sin(rotacao[X])) + (mPontos[i][Z] * cos(rotacao[X]));
      float y = auxPontos[i][Y];
      float z = auxPontos[i][Z];

      // Rotação em y
      this.auxPontos[i][X] = (mPontos[i][X] * cos(rotacao[Y])) + (z * sin(rotacao[Y])); 
      this.auxPontos[i][Z] = (mPontos[i][X] * sin(rotacao[Y]) * -1) + (z * cos(rotacao[Y]));
      float x = auxPontos[i][0];

      // Rotação em z
      this.auxPontos[i][X] = (x * cos(rotacao[Z])) - (y * sin(rotacao[Z])); 
      this.auxPontos[i][Y] = (x * sin(rotacao[Z])) + (y * cos(rotacao[Z]));
    }

    // Escala
    for (int i = 0; i < pontos; i++) {
      for (int j = 0; j < 3; j++) {
        this.auxPontos[i][j] *= escala[j];
      }
    }

    // Translacao no ponto 0
    for (int i = 0; i < pontos; i++) {
      for (int j = 0; j < 3; j++) {
        this.auxPontos[i][j] += translacao[j];
      }
    }

    // Projecao
    switch(projecao) {
    case 0: // Cavaleira 
      for (int i = 0; i < pontos; i++) {
        float x = auxPontos[i][X], y = auxPontos[i][Y], z = auxPontos[i][Z];
        this.auxPontos[i][X] = x + cos(45*PI/180)*z;
        this.auxPontos[i][Y] = y - sin(45*PI/180)*z;
      }
      break;

    case 1: // Cabinet
      for (int i = 0; i < pontos; i++) {
        float x = auxPontos[i][X], y = auxPontos[i][Y], z = auxPontos[i][Z];
        this.auxPontos[i][X] = x + cos(45*PI/180)*z/2;
        this.auxPontos[i][Y] = y - sin(45*PI/180)*z/2;
      }
      break;

    case 2: // Isométrica 
      for (int i = 0; i < pontos; i++) {
        float x = auxPontos[i][X], y = auxPontos[i][Y], z = auxPontos[i][Z];
        // Rotação de y seguido de rotação em x
        this.auxPontos[i][X] = (x*cos(45*PI/180)) + (z*sin(45*PI/180));
        this.auxPontos[i][Y] = (x*sin(45*PI/180)*sin(35.26*PI/180)) + (y*cos(35.26*PI/180)) + (z*-cos(45*PI/180)*sin(35.26*PI/180));
      }
      break;

    case 3: // Um ponto de fuga em Z
      for (int i = 0; i < pontos; i++) {
        float x = auxPontos[i][X], y = auxPontos[i][Y], z = auxPontos[i][Z];
        if (( 1 - (z/100) ) == 0) {
          this.auxPontos[i][X] = 0;
          this.auxPontos[i][Y] = 0;
        } else {
          this.auxPontos[i][X] = x / ( 1 - (z/width) );
          this.auxPontos[i][Y] = y / ( 1 - (z/width) );
        }
      }
      break;

    case 4: // Dois pontos de fuga em X e em Z
      for (int i = 0; i < pontos; i++) {
        float x = auxPontos[i][X], y = auxPontos[i][Y], z = auxPontos[i][Z];
        if (( 1 - (z/100) - (z/100) ) == 0) {
          this.auxPontos[i][X] = 0;
          this.auxPontos[i][Y] = 0;
        } else {
          this.auxPontos[i][X] = x / ( 1 - (x/width) - (z/width) );
          this.auxPontos[i][Y] = y / ( 1 - (x/width) - (z/width) );
        }
      }
      break;
    }

    // Translacao em relação ao mundo
    for (int i = 0; i < pontos; i++) {
      for (int j = 0; j < 2; j++) {
        this.auxPontos[i][j] += translacao2[j];
      }
    }
  }

  public void desenhaPoligono() {
    // Desenha linhas
    for (int i = 0; i < linhas - axisLinhas; i++) {
      int l1 = mLinhas[i][X], l2 = mLinhas[i][Y];
      linhaDDA(int(auxPontos[l1][X]), int(auxPontos[l1][Y]), int(auxPontos[l2][X]), int(auxPontos[l2][Y]), this.corLinha);
    }

    for (int i = linhas-axisLinhas; i < linhas; i++) {
      int l1 = mLinhas[i][X], l2 = mLinhas[i][Y];
      color cor = axisColors[abs(linhas - axisLinhas - i)%3];
      linhaDDA(int(auxPontos[l1][X]), int(auxPontos[l1][Y]), int(auxPontos[l2][X]), int(auxPontos[l2][Y]), cor);
    }
  }

} 