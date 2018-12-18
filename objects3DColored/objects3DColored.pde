/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 07:
 * Estenda o último trabalho de forma a desenhar apenas as faces visíveis, pintando-as com as suas respectivas cores RGB. 
 Para realizar esta tarefa, você deverá adicionar ao seu programa as seguintes operações:
 1. após efetuar as operações de escalonamento, rotação e translação de cada objeto 3D, computar e armazenar o vetor 
 normal e a profundidade Z média de cada face;
 2. determinar quais faces dos objetos são visíveis usando o vetor normal;
 3. ordenar todas as faces visíveis (de todos os objetos) por profundidade, do menor Z médio para o maior;
 4. empregar o Algoritmo do Pintor para desenhar as faces, indo daquela mais distante do observador (menor Z médio) 
 para a mais próxima (maior Z médio) e pintando-as com a cor definida utilizando o algoritmo de preenchimento 
 geométrico de polígonos por linha-de-varredura (implementado em um trabalho individual anterior). 
 **/


import java.util.*; 




final int X = 0, Y = 1, Z = 2;
final float[][] PO = {
  {700, 700, -10000}, 
  {350, 350, -10000}, 
  {1000, 1000, -10000}, 
  {0, 0, -10000}, 
  {0, 0, -10000}
};
boolean pintura = false;
boolean isPressed = true;
boolean shift = false;
Controle controle = new Controle();




void setup () {
  fullScreen();
  // size(1200, 480);
  background(255);
  pegaPoligonos();
}




void draw () {    
  background(255);
  if (isPressed) helpMenu();
  controle.desenha();
  nomeObjeto();
  printProjecao();
}
