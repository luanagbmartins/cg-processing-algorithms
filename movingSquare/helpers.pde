void keyPressed() {
  switch(key) {
  case '8':
  case 'w':
  case 'W':
    squarePosition.y--;
    if (squarePosition.y < 0) squarePosition.y = height;
    clean = false;
    break;

  case '2':
  case 'x':
  case 'X':
    squarePosition.y++;
    if (squarePosition.y > height) squarePosition.y = 0;
    clean = false;
    break;

  case '4':
  case 'a':
  case 'A':
    squarePosition.x--;
    if (squarePosition.x < 0) squarePosition.x = width;
    clean = false;
    break;

  case '6':
  case 'd':
  case 'D':
    squarePosition.x++;
    if (squarePosition.x > width) squarePosition.x = 0;
    clean = false;
    break;

  case '5':
  case 's':
  case 'S':
    clean = true;
    break;
  }
}

void helpMenu() {
  int x = 1;
  textSize(16);
  fill(0);
  text("--------- HELP ----------", 10, 10 + 17 * (x++));
  text("8 e w/W - UP", 10, 10 + 17 * (x++));
  text("2 e x/X - DOWN", 10, 10 + 17 * (x++));
  text("4 e a/A - LEFT", 10, 10 + 17 * (x++));
  text("6 e d/D - RIGHT", 10, 10 + 17 * (x++));
  text("5 e s/S - CLEAN", 10, 10 + 17 * (x++));
}
