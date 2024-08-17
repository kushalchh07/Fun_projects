import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const StarryNightApp());
}

class StarryNightApp extends StatelessWidget {
  const StarryNightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starry Night Proposal',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const StarryNightScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StarryNightScreen extends StatefulWidget {
  const StarryNightScreen({super.key});

  @override
  _StarryNightScreenState createState() => _StarryNightScreenState();
}

class _StarryNightScreenState extends State<StarryNightScreen>
    with TickerProviderStateMixin {
  late AnimationController _shootingStarController;
  late Animation<Offset> _shootingStarAnimation;
  late Timer _shootingStarTimer;
  bool _showMessage = false;

  @override
  void initState() {
    super.initState();

    _shootingStarController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _shootingStarAnimation = Tween<Offset>(
      begin: const Offset(-1.5, -1.5),
      end: const Offset(1.5, 1.5),
    ).animate(CurvedAnimation(
      parent: _shootingStarController,
      curve: Curves.easeInOut,
    ));

    _startShootingStarTimer();
  }

  void _startShootingStarTimer() {
    _shootingStarTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _shootingStarController.forward(from: 0.0).then((_) {
        setState(() {
          _showMessage = true;
        });
        Timer(const Duration(seconds: 5), () {
          setState(() {
            _showMessage = false;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _shootingStarController.dispose();
    _shootingStarTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildStarryBackground(),
          _buildShootingStar(),
          _buildMessage(),
        ],
      ),
    );
  }

  Widget _buildStarryBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.blueGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: List.generate(100, (index) {
          return Positioned(
            left: (index * 20.0) % MediaQuery.of(context).size.width,
            top: (index * 15.0) % MediaQuery.of(context).size.height,
            child: Icon(
              Icons.star,
              color: Colors.white.withOpacity(0.8),
              size: 3 + index % 3.0,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildShootingStar() {
    return SlideTransition(
      position: _shootingStarAnimation,
      child: const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 30,
      ),
    );
  }

  Widget _buildMessage() {
    return Center(
      child: AnimatedOpacity(
        opacity: _showMessage ? 1.0 : 0.0,
        duration: const Duration(seconds: 1),
        child: const Text(
          "May Your wish come true",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
