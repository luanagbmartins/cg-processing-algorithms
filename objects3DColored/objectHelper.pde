// Para ordenar uma lista de objetos
public class Comparador implements Comparator<Object3D> {
  public int compare(Object3D obj1, Object3D obj2) {
    int z1 = abs(obj1.getZ() - int(PO[obj1.getProjecao()][Z]));
    int z2 = abs(obj2.getZ() - int(PO[obj2.getProjecao()][Z]));
    if (z1 >= z2) return 1;
    else return -1;
  }
}




// Desenhar uma linha
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
    point(int(x), int(y));
  }
}

float[][] copyMatrix(float[][] m, int rows, int cols) {
  // Copia uma matriz m para uma nova matriz com dimensões [rows][cols]
  
  float[][] tempMatrix = new float[rows][cols];
  
  if(m.length > 0) {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        if(i < m.length && j < m[0].length) {
          tempMatrix[i][j] = m[i][j];
        }
        // else tempMatrix[i][j] = 0
      }
    }
  }
  
  return tempMatrix;
}

int[][] copyMatrix(int[][] m, int rows, int cols) {
  // Copia uma matriz m para uma nova matriz com dimensões [rows][cols]
  
  int[][] tempMatrix = new int[rows][cols];
  
  if(m.length > 0) {
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        if(i < m.length && j < m[0].length) {
          tempMatrix[i][j] = m[i][j];
        }
      }
    }
  }
  
  return tempMatrix;
}


// Pinta poligono
void pintaPoligono(int v, float[][] P, int[][]L, color cor_preenchimento) {
  int ymin = 0, ymax = height;

  //Criar tabela de pontos. Y cresce pra baixo!!
  float[][] tabelaPontos = new float[v][5];
  for (int i = 0; i < v; i++) {
    if (P[L[i][0]][1] > P[L[i][1]][1]) {
      tabelaPontos[i][0] = (P[L[i][0]][1]); //ymin
      tabelaPontos[i][1] = (P[L[i][1]][1]); //ymax
      tabelaPontos[i][2] = (P[L[i][1]][0]); //xmin
      tabelaPontos[i][3] = (P[L[i][0]][0] - P[L[i][1]][0]) / (P[L[i][0]][1] - P[L[i][1]][1]); // 1/m
      tabelaPontos[i][4] = (P[L[i][1]][0]); //xmax
    } else {
      tabelaPontos[i][0] = (P[L[i][1]][1]); //ymin
      tabelaPontos[i][1] = (P[L[i][0]][1]); //ymax
      tabelaPontos[i][2] = (P[L[i][0]][0]); //xmin
      tabelaPontos[i][3] = (P[L[i][0]][0] - P[L[i][1]][0]) / (P[L[i][0]][1] - P[L[i][1]][1]); // 1/m
      tabelaPontos[i][4] = (P[L[i][0]][0]); //xmax
    }
  }

  // Linha de varredura
  for (int ytemp = ymin; ytemp <= ymax; ytemp++) {
    FloatList intersec = new FloatList(); 

    for (int i = 0; i < v; i++) {        
      // Para eliminar os lados do poligono os quais a linha de varredura não intercepta
      if (ytemp > tabelaPontos[i][0] || ytemp < tabelaPontos[i][1]) continue;
      else {
        // Intersecção da linha de varredura
        float x = (tabelaPontos[i][3]*(float(ytemp)-tabelaPontos[i][1])) + tabelaPontos[i][2];
        intersec.append(x);
      }
    }

    // Ordena os valores de x
    intersec.sort(); 
    // Desenha as linhas 
    for (int i = 0; i < intersec.size()-1; i++) {
      linhaDDA(int(intersec.get(i)), ytemp, int(intersec.get(i+1)), ytemp, cor_preenchimento);
    }
  }
}




// Ler arquivo de poligonos
void pegaPoligonos() {
  BufferedReader reader = createReader("figure.dat");
  String line = null;

  try {
    for (int i = 0; i <= 2; i++) line = reader.readLine();    
    String[] pieces = split(line, ' ');
    controle.maxObjeto = int(pieces[0]);

    for (int i = 0; i < controle.maxObjeto; i++) {

      /*********************** Nome *************************/
      String nome = "";

      line = reader.readLine();    
      if (line == null) break;
      pieces = split(line, ' ');
      if (pieces[0].equals("#")) {
        nome = pieces[1];
        line = reader.readLine();    
        pieces = split(line, ' ');
      }

      /************** Dados do poligono ***********************/
      int pontos = int(pieces[0]); // Quantidade de pontos
      int linhas = int(pieces[1]); // Quantidade de linhas
      int faces = int(pieces[2]); // Quantidade de faces

      /*********************** Pontos *************************/
      float[][] mPontos = new float[pontos][3];
      for (int j = 0; j < pontos; j++) {
        line = reader.readLine();    
        pieces = split(line, ' ');
        for (int k = 0; k < 3; k++) {
          mPontos[j][k] = float(pieces[k]);
        }
      }


      /*********************** Linhas *************************/
      int[][] mLinhas = new int[linhas][2];
      for (int j = 0; j < linhas; j++) {
        line = reader.readLine();    
        pieces = split(line, ' ');
        for (int k = 0; k < 2; k++) {
          mLinhas[j][k] = int(pieces[k]) - 1;
        }
      }


      /*********************** Faces *************************/
      IntList[] mFaces = new IntList [faces];
      float[][] corFaces = new float[faces][3];

      int j = 0;
      do {
        mFaces[j] = new IntList();

        line = reader.readLine();    
        pieces = split(line, ' ');

        for (int k = 1; k <= int(pieces[0]); k++) {
          mFaces[j].append(int(pieces[k]) - 1);
        }

        corFaces[j][X] = float(pieces[int(pieces[0])+1]);
        corFaces[j][Y] = float(pieces[int(pieces[0])+2]);
        corFaces[j][Z] = float(pieces[int(pieces[0])+3]);

        j++;
      } while (j < faces);

      /********************************************************/

      // Criando o objeto
      Object3D objeto = new Object3D(nome, mPontos, mLinhas, mFaces, corFaces, pontos, linhas, faces);

      /********************************************************/

      // Rotacao
      line = reader.readLine();    
      pieces = split(line, ' ');
      objeto.rotacao(float(pieces[X]), float(pieces[Y]), float(pieces[Z]));

      //Escala
      line = reader.readLine();    
      pieces = split(line, ' ');
      objeto.escala(float(pieces[X]), float(pieces[Y]), float(pieces[Z]));

      // Translacao
      line = reader.readLine();    
      pieces = split(line, ' ');
      objeto.translacao(float(pieces[X]), float(pieces[Y]), float(pieces[Z]));

      controle.novo(objeto);
    }
    reader.close();
  }
  catch (IOException e) {
    e.printStackTrace();
  }

  controle.desenha();
}
