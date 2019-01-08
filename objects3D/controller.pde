class Controle {
  ArrayList<Object3D> obj = new ArrayList<Object3D>();
  int nObjeto = 0;
  int maxObjeto = 0;




  // Adicionar um novo objeto na lista
  void novo(Object3D object) {
    obj.add(object);
  }




  // Mudar de objeto selecionado
  void objetoSelecionado(int direcao) {
    nObjeto = nObjeto + (1 * direcao);
    if (nObjeto > maxObjeto-1) {
      nObjeto = 0;
    }
    if (nObjeto < 0) {
      nObjeto = maxObjeto - 1;
    }
  }
  



  // Pegar nome do objeto selecionado
  String getNome() {
    if (obj.size() == 0) return "";
    return obj.get(nObjeto).getNome();
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




  // Pegar projecao atual dos objetos
  int getProjecao() { 
    if (obj.size() == 0) return -1;
    return obj.get(obj.size() -1).getProjecao();
  }




  // Mudar de projecao
  void proximaProjecao() {
    if (obj.size() == 0) return;
    for (int i = 0; i < maxObjeto; i++) {
      obj.get(i).proximaProjecao();
    }
  }




  // Incrementar/Decrementar translacao
  void transladar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(nObjeto).translacao(x, y, z);
  }




  // Incrementar/Decrementar rotacao
  void rotacionar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(nObjeto).rotacao(x, y, z);
  }




  // Incrementar/Decrementar escala
  void escalar(float x, float y, float z) {
    if (obj.size() == 0) return;
    obj.get(nObjeto).escala(x, y, z);
  }




  // Desenhar objetos
  void desenha() {
    ArrayList<Object3D> aux = new ArrayList<Object3D>(this.obj);

    // Vê qual objeto está selecionado para setar a cor das suas linhas
    if (obj.size() == 0) return;
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
      aux.get(i).desenhaPoligono();
    }

    textSize(15);
    fill(0);
    text("Coordenadas (" + controle.getX() + ", " + controle.getY() + ", " + controle.getZ()+")", (width/2)-50, 37*1.5);
  }
}
