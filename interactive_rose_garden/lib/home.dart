import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RoseGardenScreen extends StatefulWidget {
  const RoseGardenScreen({super.key});

  @override
  _RoseGardenScreenState createState() => _RoseGardenScreenState();
}

class _RoseGardenScreenState extends State<RoseGardenScreen>
    with SingleTickerProviderStateMixin {
  int _taps = 0;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Center(
            child: Stack(
              children: [
                _buildRose(),
                _buildMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRose() {
    return GestureDetector(
      onTap: _onRoseTapped,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Image.asset(
              'assets/rose.png',
              width: 300,
            ),
          ),
          for (int i = 0; i < 7; i++)
            Positioned(
              left: (i % 2 == 0) ? 50.0 : 150.0,
              top: 200.0 + (i * 30.0),
              child: _buildPetal(i),
            ),
        ],
      ),
    );
  }

  Widget _buildPetal(int index) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _taps > index ? 0 : 1,
      child: Image.asset(
        'assets/petal.png',
        width: 50,
      ),
    );
  }

  void _onRoseTapped() {
    setState(() {
      _taps++;
      if (_taps == 7) {
        _message = 'Will you be mine? ❤️';
      }
    });
  }

  Widget _buildMessage() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 450,
      child: Text(
        _message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
          color: Colors.red,
        ),
      ),
    );
  }
}
