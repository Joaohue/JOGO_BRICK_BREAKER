import processing.sound.*;
SoundFile file; //necessário baixar biblioteca sound 1
SoundFile som2; //sound 2
// variáveis para controlar a posição x e y e o tamanho da bola
int bolaX = 300 + int(random(-50, 50)); // bola começa em um ângulo aleatório a cada jogo
int bolaY = 400;
int tamanhoBola = 10;
// variáveis para controlar a velocidade da bola
int velocidadeX = 2;
int velocidadeY = -2;
// variáveis para controlar a posição x e y e o tamanho da raquete
int raqueteX = 300, raqueteY = 420;
int larguraRaquete = 75;
int alturaRaquete = 10;
// array para controlar os blocos
int[] blocos = new int[30];
// variáveis para acompanhar a pontuação, nível e tela do jogo
int pontuacao = 0;
int nivel = 1;
int espera = 0;
int telaJogo = 0;
// definir fontes
PFont bitwise;
PFont start;
// outros
int startTime;
boolean creditos = false;
boolean jogoIniciado = false;
boolean modoTeclado = false;
boolean modoMouse = false;
boolean secreto = false;
boolean facil = false;
boolean normal = false;
boolean dificil = false;
boolean extremo = false;
boolean proximo = false;
int j = int(random(1,6));

void setup() {
  int i;
  size(600, 500);
  bitwise = loadFont("bitwise-100.vlw");
  start = loadFont("PressStartReg-50.vlw");
  file = new SoundFile(this, "som1.mp3"); //som
  file.loop();
  // inicializar os blocos
  for (i=0; i<30; i++) {
    blocos[i] = 1;
  }
}

void draw() {
  int i;
  int posicaoBlocoX; // posição x do bloco
  int posicaoBlocoY; // posição y do bloco
  int nivelConcluido;

  // esquema de cores aleatório toda vez que o programa é executado
  int a=1, b=1, c=1;
  if (j==1) {a=2; b=4; c=6;} 
  else if (j==2) {a=2; b=6; c=4;}
  else if (j==3) {a=4; b=2; c=6;} 
  else if (j==4) {a=4; b=6; c=2;} 
  else if (j==5) {a=6; b=2; c=4;} 
  else if (j==6) {a=6; b=4; c=2;}

  // exibir o conteúdo da tela atual
  if (telaJogo == 0) {
    menuPrincipal();
  } else if (telaJogo == 1) {
    selecionarModo();
  } else if (telaJogo == 2) {
    selecionarDificuldade();
  } else if (telaJogo == 4) {
    telaCreditos();
  }
  
  // voltar para a tela principal
  telaJogo = 0;

  // para a tela "menu principal"
  if (mousePressed && telaJogo == 0) {
    if (telaJogo == 0 && mouseX > width/2-115 && mouseX < width/2+115 &&
      mouseY>310 && mouseY < 390) {
      jogoIniciado = true;
    }
    if(telaJogo == 0 && mouseX > width/2-50 && mouseX < width/2+185 &&
    mouseY>395 && mouseY < 460) {
      creditos = true;
   }
  }
  if (keyPressed && telaJogo == 0) { 
    if (telaJogo == 0 && key == ENTER || key == 10) {
      jogoIniciado = true;
    }
  }
  if (jogoIniciado==true) {
    telaJogo = 1; // avançar para a próxima tela
  } 
  if (creditos==true) {
    telaJogo = 4; // avançar para a tela de créditos
    if (millis() - startTime > 15000) {
      telaJogo = 0; // Volte para a tela inicial após 15 segundos
    }
  }
  // para a tela "selecionar modo de jogo"
  if (mousePressed && telaJogo == 1) {
    if  (telaJogo == 1 && mouseX > 30 && mouseX < 200 && mouseY>300 && mouseY < 370) {
      modoMouse = true;
      proximo = true;
    }
    if  (telaJogo == 1 && mouseX > 520 && mouseX < 590 && mouseY > 10 && mouseY < 45) {
      secreto = true;
    }
  }
  if (keyPressed && telaJogo == 1) { 
    if (key == 'k' || key == 'K') {
      modoTeclado = true;
      proximo = true;
    }
  }
  if (proximo == true) {
    telaJogo = 2; // avançar para a próxima tela
  } 
  if (secreto == true) {
    telaJogo = 3; 
  } 

  // para a tela "selecionar dificuldade"
  if (mousePressed && telaJogo == 2) {
    if (telaJogo == 2  && mouseX > 45 && mouseX < 195 && mouseY > 160 && mouseY < 240) {
      facil = true;
    } else if (telaJogo == 2 && mouseX > 225 && mouseX < 378 && mouseY > 160 && mouseY < 240) {
      normal = true;
    } else if (telaJogo == 2 && mouseX > 405 && mouseX < 558 && mouseY > 160 && mouseY < 240) {
      dificil = true;
    } else if (telaJogo == 2 && mouseX > 210 && mouseX < 392 && mouseY > 270 && mouseY < 355) {
      extremo = true;
    }
  }
  if (keyPressed && telaJogo == 2) {
    if (key == 'e' || key == 'E') {
      facil = true;
    } else if (key == 'n' || key == 'N') {
      normal = true;
    } else if (key == 'h' || key == 'H') {
      dificil = true;
    } else if (key == 'x' || key == 'X') {
      extremo = true;
    }
  }
  if (telaJogo == 2 && facil==true || normal==true || dificil==true || extremo==true) {
    telaJogo = 3; // avançar para a próxima tela
  } 
  
  //volta para a tela inicial após os créditos
  
//  if (telaJogo == 4) {
//    delay(500);
//      telaJogo=0;
//  }

  // exibir o jogo
  if (telaJogo == 3) {
    background(0);
    fill(255);
    stroke(0);
    rectMode(CENTER);
    textFont(start);

    // mostrar pontuação
    textAlign(LEFT); // sem isso, o texto "pontuação" se move após perder
    textSize(10);
    text("Pontuação: ", 10, 490);
    text(pontuacao, 113, 490);
    // mostrar nível atual
    text("Nível", 10, 470);
    text(nivel, 65, 470);

    // desenhar bola
    ellipse(bolaX, bolaY, tamanhoBola, tamanhoBola);

    // desenhar raquete
    if (facil==true) {
      larguraRaquete=100;
    } else if (normal==true) {
      larguraRaquete=75;
    } else if (dificil==true) {
      larguraRaquete=50;
    } else if (extremo==true) {
      larguraRaquete=25;
    }
    rect(raqueteX, raqueteY, larguraRaquete, alturaRaquete);

    // atualizar a posição da bola adicionando a velocidade
    bolaX = bolaX + velocidadeX;
    bolaY = bolaY + velocidadeY;

    // se a bola tocar nas laterais da tela
    if (bolaX>width-(tamanhoBola/2) || bolaX<0+(tamanhoBola/2)) {  
      velocidadeX = -velocidadeX;
    }
    // se a bola tocar na parte superior da tela
    if (bolaY<0+(tamanhoBola/2)) {
      velocidadeY = -velocidadeY;
    }
    // se a bola passar da parte inferior da tela
    if (bolaY>height) {
      textSize(30);
      textAlign(CENTER);
      text("FIM DE JOGO :(", 300, 300);
      som2 = new SoundFile(this, "som2.mp3"); //som de perdeu
      file.stop();
      som2.play();
      fill(150);
      textSize(9);
      textAlign(LEFT);
      text("Clique ou pressione R/ESPAÇO para reiniciar", 160, 490);
    }
    // se a bola tocar na raquete
    if ((raqueteX-((larguraRaquete/2)+2))<bolaX && (raqueteX+((larguraRaquete/2)+2))>bolaX && 
      (raqueteY-tamanhoBola)<bolaY && (raqueteY)>bolaY) {
      velocidadeY = -velocidadeY; // inverte a velocidadeY para mudar a direção da bola
      pontuacao = pontuacao + 1;
      //println("boop");
    }

    // permitir que o usuário jogue usando o teclado
    if (modoTeclado==true) {
      // definir teclas jogáveis (é possível usar A e D ou as setas ESQUERDA e DIREITA)
       if (keyPressed) { // se eu usar o método keyPressed(), a raquete se move muito devagar
        if (keyCode == RIGHT || key == 'd' || key == 'D') {
          // mover raquete para a direita
          raqueteX = raqueteX + (4 + (nivel));
        } else if (keyCode == LEFT || key == 'a' || key == 'A') {
          // mover raquete para a esquerda
          raqueteX = raqueteX - (4 + (nivel));
        }
      }
    }
    // permitir que o usuário jogue usando o mouse
    if (modoMouse==true) {
      raqueteX = mouseX; 
    }
    // jogo se joga sozinho (eventualmente perde no nível 9)
    if (secreto==true) {
      raqueteX = bolaX; 
    }

    nivelConcluido = 1; // inicializa todos os blocos como "concluídos" antes de serem desenhados
    
    // loop para todos os blocos
    for (i=0; i<30; i++) {
      // posição x e y do canto superior direito de cada bloco
      posicaoBlocoX = i%6*100+10; // i%6 fará 6 fileiras
      posicaoBlocoY = 40*(i/6)+10; 
      
      // se o bloco existir
      if (blocos[i]==1) { 
        // desenhar bloco
        fill(color(100+(i*a*nivel), 100+(i*b*nivel), 100+(i*c*nivel))); // muda a cada nível
        rect(posicaoBlocoX+40, posicaoBlocoY+10, 80, 25);
        nivelConcluido = 0; /* porque o bloco está desenhado, ele não desapareceu. quando um bloco é removido
         com blocos[i]=0, "nivelConcluido = 0" não é mais verdadeiro. "if (blocos[i]==1)" verifica se 
         existem blocos, então se não houver nenhum, ele volta ao padrão nivelConcluido=1, indicando 
         que o nível foi concluído */
      }

      // verificar se a bola toca na parte superior/inferior do bloco
      if (bolaX>(posicaoBlocoX-1) && bolaX<(posicaoBlocoX+81) && // verificar se a bola está dentro do intervalo x
        bolaY>posicaoBlocoY-5 && bolaY<(posicaoBlocoY+25) && blocos[i]==1) { // verificar se a bola está acima/abaixo do bloco
        blocos[i]=0; // remover o bloco
        velocidadeY = -velocidadeY; // mudar para a direção y oposta
        pontuacao = pontuacao + 5; // adicionar 5 pontos
      }
      // verificar se a bola toca nos lados
      if (((bolaX>(posicaoBlocoX-5) && bolaX<posicaoBlocoX) || (bolaX>(posicaoBlocoX+80) && bolaX<(posicaoBlocoX+85))) &&
        bolaY>posicaoBlocoY-5 && bolaY<(posicaoBlocoY+25) && blocos[i]==1) { 
        blocos[i]=0;
        velocidadeX = -velocidadeX; // mudar para a direção x oposta
        pontuacao = pontuacao + 5;
      }
    }
    
    // se o nível for concluído
    if (nivelConcluido==1 && espera<400) { // espera permite que haja tempo entre os níveis
      textSize(40);
      textAlign(CENTER);
      fill(random(0, 255), random(0, 255), random(0, 255));
      text("VOCÊ VENCEU", 300, 250);
      // parar a bola de se mover
      velocidadeX = 0;
      velocidadeY = 0;
      espera++; // espera aumenta = tempo passa
      if (espera>150 && espera<400) {
        fill(255);
        textSize(25);
        text("CARREGANDO NÍVEL " + (nivel+1), 300, 330);
        espera++;
      }
      if (espera==400) { // avança para o próximo nível
        espera = 0;
        bolaX = 300 + int(random(-50, 50));
        bolaY = 400;
        // a velocidade aumenta conforme o nível (ex: velocidade do nível 2 é 4, velocidade do nível 3 é 5, assim por diante.)
        velocidadeX = 2+nivel;  
        velocidadeY = -2-nivel;
        raqueteX = 300;
        nivel++;
        // coloca todos os blocos de volta na tela
        for (i=0; i<30; i++) {
          blocos[i] = 1;
        }
      }
    }
  }
}
  
// cria tela de Menu Principal
void menuPrincipal() {
  int a=1, b=1, c=1;
  if (j==1) {a=2; b=4; c=6;} 
  else if (j==2) {a=2; b=6; c=4;}
  else if (j==3) {a=4; b=2; c=6;} 
  else if (j==4) {a=4; b=6; c=2;} 
  else if (j==5) {a=6; b=2; c=4;} 
  else if (j==6) {a=6; b=4; c=2;}
  background(0);
  fill(150);
  textFont(start);
  textSize(12);
  text("Clique em JOGAR ou pressione ENTER", 100, 480);
  fill(255);
  textFont(bitwise);
  textSize(70);
  text("Brick Breaker", 100, 150);
  textSize(35);
  text("Computação Visual", 160, 230);
  rectMode(CENTER);
  fill(255);
  if (mouseX > width/2-115 && mouseX < width/2+115 &&
    mouseY>310 && mouseY < 390) {
   // botão JOGAR muda de cor dependendo do esquema de cores
    fill(color(100+(30*a), 100+(30*b), 100+(30*c)));
  } else {
    fill(255);
  }
  rect(width/2, height/2+100, 230, 80);
  fill(0);
  textFont(start);
  textSize(35);
  text("JOGAR", width/2-90, height/2+120);
  
  if (mouseX > width/2-50 && mouseX < width/2+185 &&
    mouseY>395 && mouseY < 460) {
   // botão Créditos muda de cor dependendo do esquema de cores
    fill(color(100+(30*a), 100+(30*b), 100+(30*c)));
  } else {
    fill(255);
  }
    
  rect(width/2, height/2+180, 120, 43);
  fill(0);
  textFont(start);
  textSize(14);
  text("Créditos", width/2-50, height/2+185);
 }

//cria tela créditos
void telaCreditos() {
  background(0);
  fill(255, 255, 0);
  textSize(15);
  text("História de Etevaldo:", 160, 40);
  fill(255);
  textSize(12);
  text("  Etevaldo, um alienígena do planeta Zog, foi \ncapturado por caçadores de recompensas \nintergalácticos e separado de sua família. \nPara voltar para casa, ele precisa zerar o jogo \nBrick Breaker, repleto de obstáculos e desafios. \nDeterminado a se reunir com sua família, \nEtevaldo enfrenta cada nível com coragem, \nquebrando tijolos e avançando em sua jornada \npara retornar ao planeta Zog.", 15, 80);
  textSize(13);
  text("Criado por:\n\n 202110329 – Euller Passos\n 202111615 – Gabriel Gutierre\n 202117793 – Henrique Prado\n 202114022 – João Vitor Silva\n 202101432 – Lucas Zamparo", 110, 280);
}

// cria tela de Selecionar Modo
void selecionarModo() {
  background(0);
  fill(255);
  textFont(bitwise);
  textSize(45);
  text("Selecionar Modo de Jogo", 56, 80);
  rectMode(CORNER);
  rect(30, 160, 170, 70);
  rect(30, 300, 170, 70);
  textFont(start);
  textSize(15);
  text("Mover a raquete com as \n \nsetas ou A e D", 215, 180);
  text("Mover a raquete com o \n \nmouse", 215, 320);
  fill(0);
  textSize(21);
  text("TECLADO", 40, 205);
  textSize(30);
  text("MOUSE", 42, 350);
  fill(150);
  textSize(10);
  text("Pressione K para Teclado | Clique MOUSE para Mouse", 40, 490);

  fill(0);
  if (mouseX > 520 && mouseX < 590 && mouseY > 10 && mouseY < 45) {
    stroke(255);
  } else {
    stroke(0);
    fill(0);
  }
  rect(520, 10, 70, 30);
  if (mouseX > 520 && mouseX < 590 && mouseY > 10 && mouseY < 45) {
    fill(255);
  } else {
    fill(0);
  }
  textSize(10);
  text("SECRETO", 527, 30);
}

// cria tela de Selecionar Dificuldade
void selecionarDificuldade() {
  background(0);
  fill(255);
  //stroke(255);
  textFont(bitwise);
  textSize(50);
  text("Selecionar Dificuldade", 60, 80);
  rectMode(CORNER);
  rect(45, 160, 150, 80);
  rect(225, 160, 150, 80);
  rect(405, 160, 150, 80);

  rect(210, 270, 180, 80);
  textFont(start);
  fill(0);
  textSize(26);
  text("FÁCIL", 53, 215);
  textSize(20);
  text("DIFÍCIL", 412, 210);
  textSize(20);
  text("NORMAL", 240, 210);
  fill(200, 0, 0);
  text("EXTREMO", 230, 320);
  fill(150);
  textSize(13);
  text("Clique em qualquer dificuldade", 110, 470);
  textSize(8);
  text("Pressione E para Fácil, N para Normal, H para Difícil, ou X para Extremo", 15, 490);

   if (mouseX > 210 && mouseX < 392 && mouseY > 270 && mouseY < 355) {
    stroke(255, 0, 0);
  } else {
    stroke(255);
  }
}

void keyPressed() {
  int i;
  // reiniciar se o usuário pressionar ESPAÇO ou R durante o jogo
  if (telaJogo == 3 && key == ' ' || key == 'r' || key == 'R') {
    // reiniciar o jogo (posições, velocidade, pontuação, nível)
    bolaX = 300 + int(random(-50, 50));
    bolaY = 400;
    raqueteX = 300;
    velocidadeX = 2;
    velocidadeY = -2;
    pontuacao = 0;
    nivel = 1;
    //às vezes, a largura da raquete iria para 100 após o reinício do jogo, mesmo que não estivesse em Fácil
    if (facil==true) {
      larguraRaquete=100;
    } else if (normal==true) {
      larguraRaquete=75;
    } else if (dificil==true) {
      larguraRaquete=50;
    } else if (extremo==true) {
      larguraRaquete=25;
    }
    // coloca todos os blocos de volta
    for (i=0; i<30; i++) {
      blocos[i] = 1;
    }
  }
}

void mouseClicked() {
  int i;
  // reiniciar se o usuário clicar na tela durante o jogo
  if (telaJogo == 3 && mouseX > 0 && mouseX < width &&
    mouseY>0 && mouseY < height) {
    // reiniciar o jogo (posições, velocidade, pontuação, nível)
    bolaX = 300 + int(random(-50, 50));
    bolaY = 400;
    raqueteX = 300;
    velocidadeX = 2;
    velocidadeY = -2;
    pontuacao = 0;
    nivel = 1;
    //as vezes, a largura da raquete iria para 100 após o reinício do jogo, mesmo que não estivesse em Fácil
    if (facil==true) {
      larguraRaquete=100;
    } else if (normal==true) {
      larguraRaquete=75;
    } else if (dificil==true) {
      larguraRaquete=50;
    } else if (extremo==true) {
      larguraRaquete=25;
    }
    // coloca todos os blocos de volta
    for (i=0; i<30; i++) {
      blocos[i] = 1;
    }
  }
}
