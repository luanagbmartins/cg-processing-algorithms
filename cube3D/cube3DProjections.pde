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
boolean isPressed = true;
boolean shift = false;
Controle controle = new Controle();



void setup () {
  fullScreen();
  background(255);
}


void draw () {    
  background(255);
  if (isPressed) helpMenu();
  controle.desenha();
  nomeObjeto();
  printProjecao();
}