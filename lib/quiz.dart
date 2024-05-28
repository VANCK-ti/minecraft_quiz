import 'package:flutter/material.dart';
import 'dart:async';
import 'resultado.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int perguntaNumero = 0;
  int acertos = 0;
  int erros = 0;
  int _currentBackgroundIndex = 0;

  final List<Map<String, dynamic>> quiz = [
    {
      "pergunta": "Qual desses é um Mob hostil?",
      "respostas": ["Ovelha", "Creeper", "Aldeão", "Gato"],
      "alternativa correta": 1,
    },
    {
      "pergunta": "Qual material você precisa para fazer um portal do Nether?",
      "respostas": ["Diamante", "Ouro", "Obsidiana", "Ferro"],
      "alternativa correta": 2,
    },
    {
      "pergunta": "Qual item é necessário para domar um cavalo?",
      "respostas": ["Maçã", "Feno", "Cenoura", "Sela"],
      "alternativa correta": 3,
    },
    {
      "pergunta": "Qual é o objetivo principal no modo sobrevivência de Minecraft?",
      "respostas": ["Construir casas", "Explorar cavernas", "Sobreviver e derrotar o Ender Dragon", "Coletar recursos"],
      "alternativa correta": 2,
    },
    {
      "pergunta": "Qual desses mobs NÃO é amigável?",
      "respostas": ["Lobo", "Esqueleto", "Cavalo", "Papagaio"],
      "alternativa correta": 1,
    },
    {
      "pergunta": "Qual é o bloco mais resistente em Minecraft?",
      "respostas": ["Bedrock", "Obsidiana", "Diamante", "Netherite"],
      "alternativa correta": 0,
    },
    {
      "pergunta": "Qual planta pode ser usada para fazer pão?",
      "respostas": ["Trigo", "Cana-de-açúcar", "Cenoura", "Batata"],
      "alternativa correta": 0,
    },
    {
      "pergunta": "Qual mob pode ser encontrado no Nether?",
      "respostas": ["Vaca", "Creeper", "Ghast", "Aldeão"],
      "alternativa correta": 2,
    },
    {
      "pergunta": "Qual destes materiais não pode ser usado para fazer uma picareta?",
      "respostas": ["Madeira", "Pedra", "Ouro", "Cobre"],
      "alternativa correta": 3,
    },
    {
      "pergunta": "Qual mob é conhecido por explodir?",
      "respostas": ["Esqueleto", "Creeper", "Zumbi", "Enderman"],
      "alternativa correta": 1,
    }
  ];

  final List<String> _backgroundImages = [
    'assets/images/FundoP1.png',
    'assets/images/FundoP2.png',
    'assets/images/FundoP3.png',
    'assets/images/FundoP4.png',
    'assets/images/FundoP5.png',
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

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startBackgroundTimer();
  }

  void _startBackgroundTimer() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      setState(() {
        _currentBackgroundIndex = (_currentBackgroundIndex + 1) % _backgroundImages.length;
      });
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
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
      if (quiz[perguntaNumero]['alternativa correta'] == respostaNumero) {
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
      }
    });
  }
}
