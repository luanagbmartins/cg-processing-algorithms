class Controle {
  ArrayList<Cubo3D> obj = new ArrayList<Cubo3D>();
  int nObjeto = 0;
  int maxObjeto = 0;

  void novo(Cubo3D cube) {
    obj.add(cube);
    maxObjeto++;
  }

  void excluir() {
    if (obj.size() == 0) return;
    obj.remove(nObjeto);
    maxObjeto--;
    objetoSelecionado(1);
  }

  int getProjecao() { 
    if (obj.size() == 0) return -1;
    return obj.get(nObjeto).getProjecao();
  }

  void proximaProjecao() {
    if (obj.size() == 0) return;
    for (int i = 0; i < maxObjeto; i++) {
      obj.get(i).proximaProjecao();
    }
  }

  void transladar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(nObjeto).translacao(x, y, z);
  }

  void rotacionar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(nObjeto).rotacao(x, y, z);
  }

  void escalar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(nObjeto).escala(x, y, z);
  }

  // Desenhar objetos
  void desenha() {
    if (obj.size() == 0) return;

    // Vê qual objeto está selecionado para setar a cor das suas linhas
    for (int i = 0; i < maxObjeto; i++) {
      obj.get(i).naoSelecionado();
    }
    obj.get(nObjeto).selecionado();

    // Calcula posição dos objetos em relação ao mundo
    for (int i = 0; i < maxObjeto; i++) {
      obj.get(i).calPosicao();
    }

    // Desenha os objetos
    for (int i = maxObjeto-1; i >= 0; i--) {
      obj.get(i).desenhaPoligono();
    }

    textSize(15);
    fill(0);
    text("Coordenadas (" + controle.getX() + ", " + controle.getY() + ", " + controle.getZ()+")", (width/2)-50, 37*1.5);
  }

  // Mudar de objeto selecionado
  void objetoSelecionado(int direcao) {
    nObjeto = nObjeto + (1 * direcao);
    if (nObjeto > maxObjeto-1) nObjeto = 0;
    if (nObjeto < 0) nObjeto = maxObjeto - 1;
  }

  // Pegar nome do objeto selecionado
  String getNome() {
    if (obj.size() == 0) return "";
    return "Cubo";
  }

  int getX() {
    return obj.get(nObjeto).getX();
  }

  int getY() {
    return obj.get(nObjeto).getY();
  }

  int getZ() {
    return obj.get(nObjeto).getZ();
  }

}
