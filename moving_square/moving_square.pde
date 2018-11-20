/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 01:
 * Desenvolva um programa em Processing que apresente uma tela branca e que permita que o usuário mova 
   um quadrado preto de 8x8 pixels por meio de teclas do teclado, deixando um rastro. 
   As teclas a serem usadas são as seguintes:
       8 e w/W - move para cima
       2 e x/X - move para baixo
       4 e a/A - move para esquerda
       6 e d/D - move para direita
       5 e s/S - limpa o desenho (pinta de branco a tela)
       ESC - encerra a aplicação.
 *
**/




int x = 100, y = 100;




void setup() {
  fullScreen();
  background(255); 
  drawSquare(x, y, 8, 8);   
}




void draw() {
  boolean clean = false;
  
  if (keyPressed == true) {
    switch(key) {
      case '8':
      case 'w':
      case 'W':
        y--;
        if (y < 0) y = height;
        clean = false;
        break;
      case '2':
      case 'x':
      case 'X':
        y++;
        if (y > height) y = 0;
        clean = false;
        break;
      case '4':
      case 'a':
      case 'A':
        x--;
        if (x < 0) x = width;
        clean = false;
        break;
      case '6':
      case 'd':
      case 'D':
        x++;
        if(x > width) x = 0;
        clean = false;
        break;
      case '5':
      case 's':
      case 'S':
        clean = true;
        break;
    }
    
    if (clean) background(255);
    else {
      drawSquare(x, y, 8, 8);
    } 
  }
}




void drawSquare(int x, int y, int w, int h) {
  for(int j = x; j < x+w; j++) {
    for (int i = y; i <= y+h; i++){ 
      point(j, i);
    }
  }  
}
