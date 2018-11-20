/*
 * Computação Gráfica 
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 04:
 * Evolua o seu programa, desenvolvido até o momento, para:
    1. Ter uma estrutura de dados representando objetos 3D no formato de “arames”;
    2. Possuir funções para criar, fazer uma cópia e destruir objetos 3D (ou seja, instâncias dessa estrutura de dados);
    3. Ter funções para corretamente aplicar transformações de translação, rotação e de escala sobre objetos 3D;
    4. Declarar uma instância de um objeto 3D simples, como um cubo ou uma pirâmide;
    5. Desenhar esse objeto na tela utilizando uma projeção cavaleira; e
    6. Ter teclas do teclado associadas a comandos para transladar, rotacionar e escalonar o objeto nos três eixos (X, Y e Z).
        Isso significa a definição de, pelo menos, 18 teclas se consideramos incrementos e decrementos de valores em cada eixo e 
        para cada tipo de transformação. Configure também a tecla F1 para mostrar uma mensagem de ajuda na tela descrevendo as 
        teclas de movimentação.

  Recomendação para a estrutura de dados dos objetos 3D:
    - Campos principais:
       n (inteiro): número de pontos
       m (inteiro): número de linhas ligando os pontos
       pontos: matriz n x 3 para guardar as coordenadas (X, Y, Z) de cada ponto
       linhas: matriz m x 2 para guardar as indicações de quais pontos compõem cada linha do objeto. 

    - Campos secundários (eles podem estar na estrutura de dados ou serem informados no momento de realizar o processamento
      ou a projeção de um objeto):
       Tx, Ty, Tz: posição do centro de referência do objeto no sistema de referência do universo.
       Rx, Ry, Rz: ângulos de rotação do objeto no sistema de referência do universo.
       Sx, Sy, Sz: fator de escala do objeto no sistema de referência do universo.
**/




void setup () {
  fullScreen();
  background(255);   
}



void draw () {  
  if(keyPressed) {
    switch(key) {
      // Translacao
      case 'q': // -x
        Controle.transladar(-1, 0, 0);
        break;
      case 'w': // +x
        Controle.transladar(1, 0, 0);
        break;
      case 'e': // -y
        Controle.transladar(0, -1, 0);
        break;
      case 'r': // +y
        Controle.transladar(0, 1, 0);
        break;
      case 't': // -w
        Controle.transladar(0, 0, -1);
        break;
      case 'y': // +w
        Controle.transladar(0, 0, 1);
        break;

      // Rotacao
      case 'a': // -x
        Controle.rotacionar(-0.05, 0, 0);
        break;
      case 's': // +x
        Controle.rotacionar(0.05, 0, 0);
        break;
      case 'd': // -y
        Controle.rotacionar(0, -0.05, 0);
        break;
      case 'f': // +y
        Controle.rotacionar(0, 0.05, 0);
        break;
      case 'g': // -w
        Controle.rotacionar(0, 0, -0.05);
        break;
      case 'h': // +w
        Controle.rotacionar(0, 0, 0.05);
        break;      
    
      // Escala
      case 'z': // -x
        Controle.escalar(-0.05, 0, 0);
        break;
      case 'x': // +x
        Controle.escalar(0.05, 0, 0);
        break;
      case 'c': // -y
        Controle.escalar(0, -0.05, 0);
        break;
      case 'v': // +y
        Controle.escalar(0, 0.05, 0);
        break;
      case 'b': // -w
        Controle.escalar(0, 0, -0.05);
        break;
      case 'n': // +w
        Controle.escalar(0, 0, 0.05);
        break; 
    }
  }
  
  
  background(255);
  if(isPressed) helpMenu();
  Controle.desenha();
}





boolean isPressed = false;
void keyPressed() {
  if (keyCode == 112 && !isPressed) {
    isPressed = true;
  }
  else if (keyCode == 112 && isPressed) {
    isPressed = false;
  }
  
  if(key == 'o') {
    Controle.novo(new Cubo3D());
  }
  if(key == 'p') {
    Controle.excluir();
  }
  
}




void helpMenu() {
  int x = 1;
  textSize(16);
  fill(0);
  text("------------- Ajuda --------------------", 10, 10 + 17 * (x++));
  text("o: Novo cubo", 10, 10 + 17 * (x++));
  text("p: Excluir cubo", 10, 10 + 17 * (x++));
  text("q: Mover para direita", 10, 10 + 17 * (x++));
  text("w: Mover para esquerda", 10, 10 + 17 * (x++));
  text("e: Mover para cima", 10, 10 + 17 * (x++));
  text("r: Mover para baixo", 10, 10 + 17 * (x++));
  text("t: Mover para frente", 10, 10 + 17 * (x++));
  text("y: Mover para trás", 10, 10 + 17 * (x++));
  text("a: Rotaciona para cima (-x)", 10, 10 + 17 * (x++));
  text("s: Rotaciona para baixo (+x)", 10, 10 + 17 * (x++));
  text("d: Rotaciona para direta (-y)", 10, 10 + 17 * (x++));
  text("f: Rotaciona para esquerda (+y)", 10, 10 + 17 * (x++));
  text("g: Rotaciona sentido horário em z (-w)", 10, 10 + 17 * (x++));
  text("h: Rotaciona sentido anti-horário z (+w)", 10, 10 + 17 * (x++));
  text("z: Reescala para menos em x", 10, 10 + 17 * (x++));
  text("x: Reescala para mais em x", 10, 10 + 17 * (x++));
  text("c: Reescala para menos em y", 10, 10 + 17 * (x++));
  text("v: Reescala para mais em y", 10, 10 + 17 * (x++));
  text("b: Reescala para menos em z", 10, 10 + 17 * (x++));
  text("n: Reescala para mais em z", 10, 10 + 17 * (x++));
}




static class Controle {
  static ArrayList<Cubo3D> obj = new ArrayList<Cubo3D>();
 
  static void novo(Cubo3D cube) {
    obj.add(cube);
  }
  
  static void excluir() {
    if(obj.size() == 0) return;
    obj.remove(obj.size() -1);
  }
  
  static void transladar(float x, float y, float z) {
    if(obj.size() == 0) return;
    obj.get(obj.size() -1).translacao(x, y, z);
  }
  
  static void rotacionar(float x, float y, float z) {
    if(obj.size() == 0) return;
    obj.get(obj.size() -1).rotacao(x, y, z);
  }
  
  static void escalar(float x, float y, float z) {
    if(obj.size() == 0) return;
    obj.get(obj.size() -1).escala(x, y, z);
  }
  
  static void desenha() {
    if(obj.size() == 0) return;
    for(int i = 0; i < obj.size(); i++) {
      obj.get(i).desenhaObjeto();
    }
  }  
}




class Cubo3D {
  int pontos = 8, linhas = 12;
  int[][] mPontos;
  int[][] mLinhas;
  
  float[] rotacao;
  float[] escala;
  float[] translacao;
  
  Cubo3D() {
    int[][] mPontos = {
      {-50, -50, 50}, 
      {-50, -50, -50},
      {50, -50, -50},
      {50, -50, 50},
      {50, 50, 50}, 
      {-50, 50, 50},
      {-50, 50, -50},
      {50, 50, -50}
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
      {3, 4}
    };
    this.mLinhas = mLinhas;
    
    float[] rotacao = {0.0, 0.0, 0.0};
    this.rotacao = rotacao;
    
    float[] escala = {1.0, 1.0, 1.0};
    this.escala = escala;
    
    float[] translacao = {width/2.0, height/2.0, 0};
    this.translacao = translacao;
    
  }
  
  void rotacao(float x, float y, float z) {
    rotacao[0] += x;
    rotacao[1] += y;
    rotacao[2] += z;    
  }
  
  void escala(float x, float y, float z) {
    escala[0] += x;
    escala[1] += y;
    escala[2] += z;    
  }
  
  void translacao(float x, float y, float z) {
    translacao[0] += x;
    translacao[1] += y;
    translacao[2] += z;    
  }
  
  public void desenhaObjeto() {
    float[][] aux = new float[pontos][3];
    
    // Rotacao
    for(int i = 0; i < pontos; i++) {
      aux[i][1] = (float(mPontos[i][1]) * cos(rotacao[0])) - (float(mPontos[i][2]) * sin(rotacao[0])); 
      aux[i][2] = (float(mPontos[i][1]) * sin(rotacao[0])) + (float(mPontos[i][2]) * cos(rotacao[0]));
      float y = aux[i][1];
      float z = aux[i][2];
      
      aux[i][0] = (float(mPontos[i][0]) * cos(rotacao[1])) + (z * sin(rotacao[1])); 
      aux[i][2] = (float(mPontos[i][0]) * sin(rotacao[1]) * -1) + (z * cos(rotacao[1]));
      float x = aux[i][0];
      
      aux[i][0] = (x * cos(rotacao[2])) - (y * sin(rotacao[2])); 
      aux[i][1] = (x * sin(rotacao[2])) + (y * cos(rotacao[2]));
    }
    
    // Escala
    for(int i = 0; i < pontos; i++) {
      for(int j = 0; j < 3; j++) {
        aux[i][j] *= escala[j];
      }
    }
    
    // Translacao
    for(int i = 0; i < pontos; i++) {
      for(int j = 0; j < 3; j++) {
        aux[i][j] += translacao[j];
      }
    }
    
    // Perspectiva cavalheira (45graus = 0.707)
    for(int i = 0; i < pontos; i++) {
      float x = aux[i][0], y = aux[i][1], z = aux[i][2];
      aux[i][0] = x + 0.707*z;
      aux[i][1] = y - 0.707*z;    
    }
    
    // Desenha linhas
    color cor = 0;
    for(int i = 0; i < linhas; i++) {
      int l1 = mLinhas[i][0], l2 = mLinhas[i][1];
      linhaDDA(int(aux[l1][0]), int(aux[l1][1]), int(aux[l2][0]), int(aux[l2][1]), cor);
    }

  }
  
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
    stroke(cor);
    point((int)x, (int)y);
  }
}
