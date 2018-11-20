/*
 * Computação Gráfica 
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 05:
 * Implemente as seguintes projeções geométricas no seu sistema:
     - Paralela Oblíqua Cavaleira
     - Paralela Oblíqua Cabinet
     - Paralela Ortográfica Isométrica
     - Perspectiva com um ponto de fuga em Z
     - Perspectiva com dois pontos de fuga, em X e em Z
     
   Em seguida, associe a tecla <P> à troca da projeção no seu programa, 
   de modo a permitir mudá-la seguindo a lista acima de forma circular. 
   Defina a projeção cavaleira como sendo a padrão (aquela na qual o sistema inicia). 
   O programa deve indicar a projeção correntemente em uso no canto superior direito da tela.
**/




final int X = 0, Y = 1, Z = 2;




void setup () {
  fullScreen();
  background(255);
}




void draw () {    
  if (keyPressed) {
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
  if (isPressed) helpMenu();
  Controle.desenha();

  textSize(25);
  fill(0);
  switch(Controle.getProjecao()) {
  case 0: 
    text("Projeção Cavaleira", width-300, 37);
    break;
  case 1:
    text("Projeção Cabinet", width-300, 37);
    break;
  case 2:
    text("Projeção Isométrica", width-300, 37);
    break;
  case 3:
    text("Perspectiva com um ponto de fuga", width-500, 37);
    break;
  case 4:
    text("Perspectiva com dois pontos de fuga", width-500, 37);
    break;
  }
}





boolean isPressed = false;
void keyPressed() {
  if (keyCode == 112 && !isPressed) {
    isPressed = true;
  } else if (keyCode == 112 && isPressed) {
    isPressed = false;
  }

  if (key == 'i') {
    Controle.novo(new Cubo3D());
  }
  if (key == 'o') {
    Controle.excluir();
  }
  if (key== 'p') {
    Controle.proximo();
  }
}




void helpMenu() {
  int x = 1;
  textSize(16);
  fill(0);
  text("------------- Ajuda --------------------", 10, 10 + 17 * (x++));
  text("i: Novo cubo", 10, 10 + 17 * (x++));
  text("o: Excluir cubo", 10, 10 + 17 * (x++));
  text("p: Mudar de projeção", 10, 10 + 17 * (x++));
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

  static int getProjecao() { 
    if (obj.size() == 0) return -1;
    return obj.get(obj.size() -1).getProjecao();
  }

  static void proximo() {
    if (obj.size() == 0) return;
    obj.get(obj.size() -1).proximaProjecao();
  }

  static void excluir() {
    if (obj.size() == 0) return;
    obj.remove(obj.size() -1);
  }

  static void transladar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(obj.size() -1).translacao(x, y, z);
  }

  static void rotacionar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(obj.size() -1).rotacao(x, y, z);
  }

  static void escalar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(obj.size() -1).escala(x, y, z);
  }

  static void desenha() {
    if (obj.size() == 0) return;
    for (int i = 0; i < obj.size(); i++) {
      obj.get(i).desenhaObjeto();
    }
  }
}




class Cubo3D {
  int projecao;
  int pontos = 8, linhas = 12;
  int[][] mPontos;
  int[][] mLinhas;

  float[] rotacao;
  float[] escala;
  float[] translacao;
  float[] translacao2;

  Cubo3D() {
    projecao = 0;

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

    float[] rotacao = {0.001, 0.001, 0.001};
    this.rotacao = rotacao;

    float[] escala = {1.0, 1.0, 1.0};
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

  public void desenhaObjeto() {
    float[][] aux = new float[pontos][3];

    // Rotacao
    for (int i = 0; i < pontos; i++) {
      // Rotação em x
      aux[i][Y] = (float(mPontos[i][Y]) * cos(rotacao[X])) - (float(mPontos[i][Z]) * sin(rotacao[X])); 
      aux[i][Z] = (float(mPontos[i][Y]) * sin(rotacao[X])) + (float(mPontos[i][Z]) * cos(rotacao[X]));
      float y = aux[i][Y];
      float z = aux[i][Z];

      // Rotação em y
      aux[i][X] = (float(mPontos[i][X]) * cos(rotacao[Y])) + (z * sin(rotacao[Y])); 
      aux[i][Z] = (float(mPontos[i][X]) * sin(rotacao[Y]) * -1) + (z * cos(rotacao[Y]));
      float x = aux[i][0];

      // Rotação em z
      aux[i][X] = (x * cos(rotacao[Z])) - (y * sin(rotacao[Z])); 
      aux[i][Y] = (x * sin(rotacao[Z])) + (y * cos(rotacao[Z]));
    }

    // Escala
    for (int i = 0; i < pontos; i++) {
      for (int j = 0; j < 3; j++) {
        aux[i][j] *= escala[j];
      }
    }
    
    // Translacao no ponto 0
    for (int i = 0; i < pontos; i++) {
      for (int j = 0; j < 3; j++) {
        aux[i][j] += translacao[j];
      }
    }

    // Projecao
    switch(projecao) {
    case 0: // Cavaleira 
      for (int i = 0; i < pontos; i++) {
        float x = aux[i][X], y = aux[i][Y], z = aux[i][Z];
        aux[i][X] = x + cos(45*PI/180)*z;
        aux[i][Y] = y - sin(45*PI/180)*z;
      }
      break;

    case 1: // Cabinet
      for (int i = 0; i < pontos; i++) {
        float x = aux[i][X], y = aux[i][Y], z = aux[i][Z];
        aux[i][X] = x + cos(45*PI/180)*z/2;
        aux[i][Y] = y - sin(45*PI/180)*z/2;
      }
      break;

    case 2: // Isométrica 
      for (int i = 0; i < pontos; i++) {
        float x = aux[i][X], y = aux[i][Y], z = aux[i][Z];
        // Rotação de y seguido de rotação em x
        aux[i][X] = (x*cos(45*PI/180)) + (z*sin(45*PI/180));
        aux[i][Y] = (x*sin(45*PI/180)*sin(35.26*PI/180)) + (y*cos(35.26*PI/180)) + (z*-cos(45*PI/180)*sin(35.26*PI/180));
      }
      break;

    case 3: // Um ponto de fuga em Z
      for (int i = 0; i < pontos; i++) {
        float x = aux[i][X], y = aux[i][Y], z = aux[i][Z];
        if (( 1 - (z/100) ) == 0) {
          aux[i][X] = 0;
          aux[i][Y] = 0;
        } else {
          aux[i][X] = x / ( 1 - (z/height) );
          aux[i][Y] = y / ( 1 - (z/height) );
        }
      }
      break;

    case 4: // Dois pontos de fuga em;+ X e em Z
      for (int i = 0; i < pontos; i++) {
        float x = aux[i][X], y = aux[i][Y], z = aux[i][Z];
        if (( 1 - (z/100) - (z/100) ) == 0) {
          aux[i][X] = 0;
          aux[i][Y] = 0;
        } else {
          aux[i][X] = x / ( 1 - (x/width) - (z/height) );
          aux[i][Y] = y / ( 1 - (x/width) - (z/height) );
        }
      }
      break;
    }


    // Translacao em relação ao mundo
    for (int i = 0; i < pontos; i++) {
      for (int j = 0; j < 3; j++) {
        aux[i][j] += translacao2[j];
      }
    }

    // Desenha linhas
    color cor = 0;
    for (int i = 0; i < linhas; i++) {
      int l1 = mLinhas[i][X], l2 = mLinhas[i][Y];
      linhaDDA(int(aux[l1][X]), int(aux[l1][Y]), int(aux[l2][X]), int(aux[l2][Y]), cor);
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
