import 'package:flutter/material.dart';
import 'dart:async';
import 'quiz.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentBackgroundIndex = 0;
  final List<String> _backgroundImages = [
    'assets/images/HomeP1.png',
    'assets/images/HomeP2.png',
    'assets/images/HomeP3.png',
    'assets/images/HomeP5.png',
    'assets/images/HomeP6.png',
  ];
  Timer? _timer;

  final TextStyle homepageTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImages[_currentBackgroundIndex]),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 3),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Quiz()),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/minecraft_butao.png',
                      width: 200,
                      height: 200,
                    ),
                    Text(
                      'Jogar',
                      style: homepageTextStyle,
                    ),
                  ],
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
