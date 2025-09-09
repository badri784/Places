import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:places/Screen/places.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 45, 34, 56),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff5300d3),
          background: const Color(0xff3c3044),
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          titleSmall: GoogleFonts.unbounded(),
          titleMedium: GoogleFonts.underdog(),
        ),
      ),
      home: const Places(),
    );
  }
}
