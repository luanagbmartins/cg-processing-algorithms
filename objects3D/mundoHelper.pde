// Evento de tecla pressionada
void keyPressed() {
  manipulaObjeto();

  if (keyCode == 112 && !isPressed) {
    isPressed = true;
  } else if (keyCode == 112 && isPressed) {
    isPressed = false;
  }

  if (keyCode == SHIFT) {
    shift = true;
  }  

  if (key == TAB && shift) {
    controle.objetoSelecionado(-1);
  } else if (key == TAB && !shift) {
    controle.objetoSelecionado(1);
  }
  if (key== 'p') {
    controle.proximaProjecao();
  }
}

void keyReleased() {
  if (keyCode == SHIFT) shift = false;
}




// Mostrar na tela o nome da projeção utilizada no momento
void printProjecao() {
  textSize(25);
  fill(0);
  switch(controle.getProjecao()) {
  case 0: 
    text("Projeção", width-150, 37);
    text("Cavaleira", width-150, 37*1.7);
    break;
  case 1:
    text("Projeção", width-150, 37);
    text("Cabinet", width-150, 37*1.7);
    break;
  case 2:
    text(" Projeção", width-150, 37);
    text("Isométrica", width-150, 37*1.7);
    break;
  case 3:
    text(" Perspectiva com", width-250, 37);
    text("um ponto de fuga", width-250, 37*1.7);
    break;
  case 4:
    text("  Perspectiva com", width-250, 37);
    text("dois pontos de fuga", width-250, 37*1.7);
    break;
  }
}




// Mostrar na tela o nome do objeto selecionado
void nomeObjeto() {
  textSize(25);
  fill(0);
  text(controle.getNome(), width/2, 37);
}




// Mostrar na tela um menu de ajuda
void helpMenu() {
  int x = 1;
  textSize(16);
  fill(0);
  text("------------- Ajuda (F1) ----------------", 10, 10 + 17 * (x++));
  text("TAB: Próximo objeto", 10, 10 + 17 * (x++));
  text("SHIFT+TAB: Objeto Anterior", 10, 10 + 17 * (x++));
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
  text("g: Rotaciona sentido horário em z (-z)", 10, 10 + 17 * (x++));
  text("h: Rotaciona sentido anti-horário z (+z)", 10, 10 + 17 * (x++));
  text("z: Reescala para menos em x", 10, 10 + 17 * (x++));
  text("x: Reescala para mais em x", 10, 10 + 17 * (x++));
  text("c: Reescala para menos em y", 10, 10 + 17 * (x++));
  text("v: Reescala para mais em y", 10, 10 + 17 * (x++));
  text("b: Reescala para menos em z", 10, 10 + 17 * (x++));
  text("n: Reescala para mais em z", 10, 10 + 17 * (x++));
}




// Manipulação do objeto selecionado
void manipulaObjeto() {
  switch(key) {
    // Translacao
  case 'q': // -x
    controle.transladar(-2, 0, 0);
    break;
  case 'w': // +x
    controle.transladar(2, 0, 0);
    break;
  case 'e': // -y
    controle.transladar(0, -2, 0);
    break;
  case 'r': // +y
    controle.transladar(0, 2, 0);
    break;
  case 't': // -w
    controle.transladar(0, 0, -2);
    break;
  case 'y': // +w
    controle.transladar(0, 0, 2);
    break;

    // Rotacao
  case 'a': // -x
    controle.rotacionar(-0.05, 0, 0);
    break;
  case 's': // +x
    controle.rotacionar(0.05, 0, 0);
    break;
  case 'd': // -y
    controle.rotacionar(0, -0.05, 0);
    break;
  case 'f': // +y
    controle.rotacionar(0, 0.05, 0);
    break;
  case 'g': // -w
    controle.rotacionar(0, 0, -0.05);
    break;
  case 'h': // +w
    controle.rotacionar(0, 0, 0.05);
    break;      

    // Escala
  case 'z': // -x
    controle.escalar(-0.5, 0, 0);
    break;
  case 'x': // +x
    controle.escalar(0.5, 0, 0);
    break;
  case 'c': // -y
    controle.escalar(0, -0.5, 0);
    break;
  case 'v': // +y
    controle.escalar(0, 0.5, 0);
    break;
  case 'b': // -w
    controle.escalar(0, 0, -0.5);
    break;
  case 'n': // +w
    controle.escalar(0, 0, 0.5);
    break;
  }
}
