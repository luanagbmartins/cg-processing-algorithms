final int axisLinhas = 9;
final int axisVertices = 12; 

class Object3D {
  String nome;  

  int projecao;
  float xMedio, yMedio, zMedio;

  int pontos;
  float[][] mPontos;  // Matriz de pontos
  float[][] auxPontos;  // Matriz auxiliar de pontos (onde todos os calculos serão feitos)

  int linhas;
  int[][] mLinhas;  // Matriz de linhas
  color corLinha;  // Cor da linha: pode ser preto se o objeto não estiver selecionado e vermelho caso contrário
  color[] axisColors;

  int faces;
  IntList[] mFaces;  // Matriz de faces
  float[][] corFaces;  // Cor das faces

  float[] rotacao;  // Vetor de rotacao
  float[] escala;  // Vetor de escala
  float[] translacao;  // Vetor de translacao em relação com centro do objeto em (0, 0, 0) 
  float[] translacao2;  // Vetor de translacao em relação ao mundo




  // Inicializacao do objeto
  Object3D(String nome, float[][] mPontos, int[][] mLinhas, IntList[] mFaces, float[][] corFaces, int pontos, int linhas, int nFaces) {    

    projecao = 0;

    this.nome = nome;

    this.pontos = pontos + axisVertices;
    this.mPontos = copyMatrix(mPontos, pontos + axisVertices, 3);
    this.auxPontos = new float[this.pontos][3];

    this.linhas = linhas + axisLinhas;
    this.mLinhas = copyMatrix(mLinhas, linhas + axisLinhas, 2);
    this.corLinha = color(0, 0, 0);

    // X-Axis
    this.mPontos[pontos][0] = 2;
    this.mPontos[pontos][1] = 0;
    this.mPontos[pontos][2] = 0;
    
    this.mPontos[pontos+1][0] = -2;
    this.mPontos[pontos+1][1] = 0;
    this.mPontos[pontos+1][2] = 0;

    this.mPontos[pontos+6][0] = 1.8;
    this.mPontos[pontos+6][1] = 0.2;
    this.mPontos[pontos+6][2] = 0;

    this.mPontos[pontos+9][0] = 1.8;
    this.mPontos[pontos+9][1] = -0.2;
    this.mPontos[pontos+9][2] = 0;

    this.mLinhas[linhas][0] = pontos;
    this.mLinhas[linhas][1] = pontos+1;

    this.mLinhas[linhas+3][0] = pontos;
    this.mLinhas[linhas+3][1] = pontos+6;

    this.mLinhas[linhas+6][0] = pontos;
    this.mLinhas[linhas+6][1] = pontos+9;
    
    // Y-Axis
    this.mPontos[pontos+2][0] = 0;
    this.mPontos[pontos+2][1] = 2;
    this.mPontos[pontos+2][2] = 0;
    
    this.mPontos[pontos+3][0] = 0;
    this.mPontos[pontos+3][1] = -2;
    this.mPontos[pontos+3][2] = 0;

    this.mPontos[pontos+7][0] = 0.2;
    this.mPontos[pontos+7][1] = 1.8;
    this.mPontos[pontos+7][2] = 0;

    this.mPontos[pontos+10][0] = -0.2;
    this.mPontos[pontos+10][1] = 1.8;
    this.mPontos[pontos+10][2] = 0;

    this.mLinhas[linhas+1][0] = pontos+2;
    this.mLinhas[linhas+1][1] = pontos+3;

    this.mLinhas[linhas+4][0] = pontos+2;
    this.mLinhas[linhas+4][1] = pontos+7;

    this.mLinhas[linhas+7][0] = pontos+2;
    this.mLinhas[linhas+7][1] = pontos+10;
    
    // Z-Axis
    this.mPontos[pontos+4][0] = 0;
    this.mPontos[pontos+4][1] = 0;
    this.mPontos[pontos+4][2] = 2;
    
    this.mPontos[pontos+5][0] = 0;
    this.mPontos[pontos+5][1] = 0;
    this.mPontos[pontos+5][2] = -2;

    this.mPontos[pontos+8][0] = 0.2;
    this.mPontos[pontos+8][1] = 0;
    this.mPontos[pontos+8][2] = 1.8;

    this.mPontos[pontos+11][0] = -0.2;
    this.mPontos[pontos+11][1] = 0;
    this.mPontos[pontos+11][2] = 1.8;

    this.mLinhas[linhas+2][0] = pontos+4;
    this.mLinhas[linhas+2][1] = pontos+5;

    this.mLinhas[linhas+5][0] = pontos+4;
    this.mLinhas[linhas+5][1] = pontos+8;

    this.mLinhas[linhas+8][0] = pontos+4;
    this.mLinhas[linhas+8][1] = pontos+11;
    
  
    // Axis colors
    this.axisColors = new color[3];
    this.axisColors[0] = color(255, 0, 0);
    this.axisColors[1] = color(0, 255, 0);
    this.axisColors[2] = color(0, 0, 255);

    this.faces = nFaces;
    this.mFaces = mFaces;
    this.corFaces = corFaces;

    float[] rotacao = {0, 0, 0};
    this.rotacao = rotacao;

    float[] escala = {0, 0, 0};
    this.escala = escala;

    float[] translacao = {0, 0, 0};
    this.translacao = translacao;

    float[] translacao2 = {width/2.0, height/2.0, 0};
    this.translacao2 = translacao2;
  }

  // Retornar o nome do objeto
  String getNome() {
    return this.nome;
  }

  // Mudar de projeção
  void proximaProjecao() {
    this.projecao++;
    if (projecao > 4) this.projecao = 0;
  }

  // Retornar qual a atual projeção
  int getProjecao() {
    return projecao;
  }

  void calcX() {
    this.xMedio = 0;
    for (int i = 0; i < faces; i++) {  
      float aux = 0;
      for (int j = 0; j < mFaces[i].size(); j++) {
        aux += this.auxPontos[mFaces[i].get(j)][X];
      }
      this.xMedio = aux/mFaces[i].size();
    }
    this.xMedio /= faces;
  }

  int getX() {
    this.calcX();
    return int(xMedio);
  }  

  void calcY() {
    this.yMedio = 0;
    for (int i = 0; i < faces; i++) {  
      float aux = 0;
      for (int j = 0; j < mFaces[i].size(); j++) {
        aux += this.auxPontos[mFaces[i].get(j)][Y];
      }
      this.yMedio = aux/mFaces[i].size();
    }
    this.yMedio /= faces;
  }




  int getY() {
    this.calcY();
    return int(yMedio);
  }  





  void calcZ() {
    this.zMedio = 0;
    for (int i = 0; i < faces; i++) {  
      float aux = 0;
      for (int j = 0; j < mFaces[i].size(); j++) {
        aux += this.auxPontos[ mFaces[i].get(j) ] [Z];
      }
      this.zMedio = aux/mFaces[i].size();
    }
    this.zMedio /= faces;
  }




  int getZ() {
    this.calcZ();
    return int(zMedio);
  }  




  // Incrementar/Decrementar rotacao
  void rotacao(float x, float y, float z) {
    this.rotacao[X] += x;
    this.rotacao[Y] += y;
    this.rotacao[Z] += z;
  }




  // Incrementar/Decrementar escala
  void escala(float x, float y, float z) {
    this.escala[X] += x;
    this.escala[Y] += y;
    this.escala[Z] += z;
  }




  // Incrementar/Decrementar translacao
  void translacao(float x, float y, float z) {
    this.translacao[X] += x;
    this.translacao[Y] += y;
    this.translacao[Z] += z;
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

    case 4: // Dois pontos de fuga em;+ X e em Z
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
