import 'package:flutter/material.dart';
import 'homepage.dart'; // Importe a HomePage para poder navegar de volta

class Resultado extends StatelessWidget {
  final int acertos;
  final int totalPerguntas;

  Resultado({required this.acertos, required this.totalPerguntas});

  final List<String> _backgroundImages = [
    'assets/images/FundoP4.png',
  ];

  final TextStyle resultadoTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Alterado para branco
    fontFamily: 'FonteMine', // Define a mesma fonte utilizada na tela de quiz
  );

  final TextStyle pontuacaoTextStyle = TextStyle(
    fontSize: 16, // Alterado o tamanho do texto para caber no botão
    color: Colors.white, // Alterado para branco
    fontFamily: 'FonteMine', // Define a mesma fonte utilizada na tela de quiz
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minecraft Quiz', // Alterado para FonteMine
          style: TextStyle(fontFamily: 'FonteMine'), // Aplica a fonte FonteMine
        ),
        centerTitle: true,
        backgroundColor: Colors.green, // Alterado para verde
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              _backgroundImages[acertos % _backgroundImages.length],
            ),
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
                  'Resultado',
                  style: resultadoTextStyle, // Aplica o estilo definido
                ),
                Text(
                  'Voce acertou $acertos de $totalPerguntas perguntas!',
                  style: pontuacaoTextStyle, // Aplica o estilo definido
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()), // Substitua pela HomePage
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/minecraft_butao.png',
                        width: 200, // ajuste conforme necessário
                        height: 60, // ajuste conforme necessário
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Jogar Novamente',
                        style: pontuacaoTextStyle, // Aplica o estilo definido
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
