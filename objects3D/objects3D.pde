/*
 * Computação Gráfica
 * Autor: Luana Guedes Barros Martins
 *
 * Trabalho de implementação 06:
 * Aperfeiçoe o seu programa para ter as novas características e funcionalidades descritas abaixo:
 1. Incluir, na estrutura de dados representando um objeto 3D, as seguintes informações sobre para cada uma de suas faces:
 - uma lista ordenada em sentido anti-horário dos índices dos vértices que compõem a face;
 - a cor RGB da face, na forma de três valores reais no intervalo [0,1];
 - um campo de dado para guardar a posição z média dos vértices da face (esse campo será utilizado posteriormente, 
 no próximo trabalho, para calcular a distância aproximada da face ao observador).
 2. Implementar a leitura de um arquivo, logo no início da execução do programa, contendo o conjunto de objetos 3D 
 a ser carregado para a estrutura de dados. O nome do arquivo deve ser "figure.dat".  
 3. Permitir armazenar, selecionar, manipular (escalonar, rotacional e transladar) e projetar mais de um objeto 3D 
 por meio das seguintes novas funcionalidades:
 - manter uma lista circular de objetos 3D carregados de um arquivo;  
 - apresentar visualmente todos os objetos 3D na lista;  
 - permitir selecionar qualquer um dos objetos na lista com as teclas TAB (para avançar a seleção) e SHIFT+TAB 
 (para voltar a seleção ao objeto anterior). O objeto selecionado deve ser apresentado na tela com uma cor diferente 
 dos demais, por exemplo, com suas linhas na cor vermelhar;
 - as operações de translação, escalonamento e rotação devem ser realizadas apenas sobre o objeto selecionado.
 ----
 O arquivo de entrada e saída de dados (com objetos 3D) deve ser em texto simples na codificação UTF-8 com padrão
 Linux/Unix e seguir o formato abaixo:
 - 1a Linha: String começando com # e contendo logo em seguida o nome da figura que compõe a imagem
 - 2a Linha: quatro números reais separados por espaço (Xmin Xmax Ymin Ymax) definindo o tamanho do sistema de 
 coordenadas do universo
 - 3a Linha: um número inteiro n indicando quantos objetos 3D estão descritos no arquivo
 - Abaixo, em sequência para cada um dos n objetos, deve haver as seguintes linhas:
 -- Linha 1: Uma string começando com # e contendo o nome do objeto 3D em questão.
 -- Linha 2: três números inteiros P, L e F indicando respectivamente a quantidade de pontos, a quantidade de linhas 
 e a quantidade de faces geométricas do objeto.
 -- Linha Pi: para cada ponto Pi, i=1,2,...P, uma linha no arquivo com as coordenadas tridimensionais cartesianas 
 desse ponto na forma de três números reais separados por espaço (xi yi zi).
 -- Linha Lj: para cada linha geométrica Lj, j=1,2,...L, uma linha no arquivo com os dois índices (iniciando em 1) 
 dos pontos extremos de Lj, na forma de dois números inteiros separados por espaço (Pa Pb).
 -- Linha Fk: para cada face geométrica Fk, k=1,2,...F, uma linha no arquivo contendo a descrição das características
 dessa face na forma de uma sequência de números separados por espaço:
 ---> N – quantidade de pontos da face (N>=3)
 ---> P1 P2 … P_N – sequência ordenada em sentido anti-horário dos índices (começando em 1) dos N pontos que formam a face
 ---> R G B – três valores reais no intervalo [0,1] informando o componente RGB da cor da face.
 -- Linha rotação: três valores reais separados por espaço (theta_x theta_y theta_z) indicando os ângulos de rotação a ser 
 aplicado no objeto em torno dos eixos x, y e z, respectivamente.
 -- Linha escala: três valores reais separados por espaço (Sx Sy Sz) indicando o escalonamento a ser aplicado no objeto 
 nos eixos x, y e z respectivamente.
 -- Linha translação: três valores reais separados por espaço (Tx Ty Tz) indicando a translação a ser feita do objeto 
 nos eixos x, y e z respectivamente.
 **/
 

import java.util.*; 




final int X = 0, Y = 1, Z = 2;
boolean isPressed = true;
boolean shift = false;
Controle controle = new Controle();




void setup () {
  fullScreen();
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
