import 'package:flutter/material.dart';
import 'dart:async';
import 'resultado.dart';
import 'dart:math';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int perguntaNumero = 0;
  int acertos = 0;
  int erros = 0;
  int _currentBackgroundIndex = 0;
  late List<Map<String, dynamic>> quiz;

  final List<String> _backgroundImages = [
    'assets/images/FundoP6.png',
  ];

  final TextStyle appBarTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontFamily: 'FonteMine',
    shadows: [
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 3,
        color: Colors.black.withOpacity(0.7),
      ),
    ],
  );

  final TextStyle quizTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'FonteMine',
    shadows: [
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 3,
        color: Colors.black.withOpacity(0.7),
      ),
    ],
  );

  final TextStyle timerTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'FonteMine',
  );

  Timer? _timer;
  int _tempoRestante = 15;

  @override
  void initState() {
    super.initState();
    _startBackgroundTimer();
    _startTimer();
    _shuffleQuiz();
  }

  void _shuffleQuiz() {
    quiz = List<Map<String, dynamic>>.from(_originalQuiz);
    quiz.shuffle(Random(DateTime.now().millisecondsSinceEpoch));
  }

  void _startBackgroundTimer() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      setState(() {
        _currentBackgroundIndex = (_currentBackgroundIndex + 1) % _backgroundImages.length;
      });
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_tempoRestante > 0) {
        setState(() {
          _tempoRestante--;
        });
      } else {
        timer.cancel();
        respondeu(-1); // -1 para indicar que o tempo acabou
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Cor da AppBar definida como verde
        elevation: 0, // Remove a sombra da AppBar
        centerTitle: true,
        title: Text(
          'Pergunta ${perguntaNumero + 1} de ${quiz.length}',
          style: appBarTextStyle,
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: Container(
          key: ValueKey<int>(_currentBackgroundIndex),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_backgroundImages[_currentBackgroundIndex]),
              fit: BoxFit.cover,
            ),
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5), // Define a cor preta com opacidade
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    quiz[perguntaNumero]['imagem'],
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    quiz[perguntaNumero]['pergunta'],
                    style: quizTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < 2; i++)
                        GestureDetector(
                          onTap: () {
                            respondeu(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/minecraft_butao.png',
                                  width: 200,
                                  height: 100,
                                ),
                                Text(
                                  quiz[perguntaNumero]['respostas'][i],
                                  style: quizTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for (var i = 2; i < 4; i++)
                        GestureDetector(
                          onTap: () {
                            respondeu(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/minecraft_butao.png',
                                  width: 200,
                                  height: 100,
                                ),
                                Text(
                                  quiz[perguntaNumero]['respostas'][i],
                                  style: quizTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    'Tempo restante: $_tempoRestante segundos',
                    style: timerTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void respondeu(int respostaNumero) {
    setState(() {
      _timer?.cancel(); // Cancela o temporizador quando a pergunta é respondida
      if (respostaNumero == -1) {
        // Se o tempo acabou
        erros++;
      } else if (quiz[perguntaNumero]['alternativa correta'] == respostaNumero) {
        acertos++;
      } else {
        erros++;
      }

      if (perguntaNumero == quiz.length - 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Resultado(
              acertos: acertos,
              totalPerguntas: quiz.length,
            ),
          ),
        );
      } else {
        perguntaNumero++;
        _tempoRestante = 15; // Reinicia o tempo para a próxima pergunta
        _startTimer(); // Inicia o temporizador para a próxima pergunta
      }
    });
  }

  final List<Map<String, dynamic>> _originalQuiz = [
    {
      "pergunta": "Qual desses eh um Mob hostil",
      "respostas": ["Ovelha", "Piglin", "Aldeão", "Gato"],
      "alternativa correta": 1,
      "imagem": "assets/images/imagem1.png",
    },
    {
      "pergunta": "Qual material voce precisa para fazer um portal do Nether",
      "respostas": ["Diamante", "Ouro", "Obsidiana", "Ferro"],
      "alternativa correta": 2,
      "imagem": "assets/images/imagem2.png",
    },
    {
      "pergunta": "Qual item eh necessario para domar um cavalo",
      "respostas": ["Carne", "Feno", "Cenoura", "Sela"],
      "alternativa correta": 3,
      "imagem": "assets/images/imagem3.png",
    },
    {
      "pergunta": "Qual eh o mob mais poderoso",
      "respostas": ["Enderman", "Creeper", "Ender Dragon", "Phatom"],
      "alternativa correta": 2,
      "imagem": "assets/images/imagem4.png",
    },
    {
      "pergunta": "Qual desses mobs nao eh amigavel",
      "respostas": ["Lobo", "Esqueleto", "Cavalo", "Papagaio"],
      "alternativa correta": 1,
      "imagem": "assets/images/imagem5.png",
    },
    {
      "pergunta": "Qual eh o bloco mais resistente em Minecraft",
      "respostas": ["Bedrock", "Obsidiana", "Diamante", "Netherite"],
      "alternativa correta": 0,
      "imagem": "assets/images/imagem6.png",
    },
    {
      "pergunta": "Qual planta pode ser usada para fazer pao",
      "respostas": ["Trigo", "Cogumelo", "Cenoura", "Batata"],
      "alternativa correta": 0,
      "imagem": "assets/images/imagem7.png",
    },
    {
      "pergunta": "Qual mob pode ser encontrado no Nether",
      "respostas": ["Vaca", "Creeper", "Ghast", "Aldeao"],
      "alternativa correta": 2,
      "imagem": "assets/images/imagem8.png",
    },
    {
      "pergunta": "Qual destes materiais nao pode ser usado para fazer uma picareta",
      "respostas": ["Madeira", "Pedra", "Ouro", "Cobre"],
      "alternativa correta": 3,
      "imagem": "assets/images/imagem9.png",
    },
    {
      "pergunta": "Qual mob eh conhecido por explodir",
      "respostas": ["Esqueleto", "Creeper", "Zumbi", "Enderman"],
      "alternativa correta": 1,
      "imagem": "assets/images/imagem10.png",
    }
  ];
}
