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
