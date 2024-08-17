import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interactive_rose_garden/home.dart';

void main() {
  runApp(const RoseGardenApp());
}

class RoseGardenApp extends StatelessWidget {
  const RoseGardenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rose Garden Proposal',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.pacificoTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const RoseGardenScreen(),
    );
  }
}
