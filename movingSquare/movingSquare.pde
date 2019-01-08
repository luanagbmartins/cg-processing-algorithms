/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 01:
 * Desenvolva um programa em Processing que apresente uma tela branca e que permita que o usuário mova 
 um quadrado preto de 8x8 pixels por meio de teclas do teclado, deixando um rastro. 
 As teclas a serem usadas são as seguintes
 8 e w/W - move para cima
 2 e x/X - move para baixo
 4 e a/A - move para esquerda
 6 e d/D - move para direita
 5 e s/S - limpa o desenho (pinta de branco a tela)
 ESC - encerra a aplicação.
 *
 **/

PVector squarePosition;
boolean clean = false;
final int squareSize = 20;

void setup() {
  fullScreen();
  background(255); 

  squarePosition = new PVector(width/2, height/2);
  drawSquare();
}

void draw() {
  helpMenu();
  if (clean) {
    background(255);
    squarePosition.set(width/2, height/2);
    helpMenu();
  }
  else drawSquare();  
}

void drawSquare() {
  for (int x = int(squarePosition.x); x < int(squarePosition.x) + squareSize; x++) {
    for (int y = int(squarePosition.y); y <= int(squarePosition.y) + squareSize; y++) { 
      point(x, y);
    }
  }
}
