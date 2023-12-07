import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/views/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          useMaterial3: false,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: scaffoldBgColor,
          canvasColor: bgColor,
          textTheme: GoogleFonts.arimoTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white)
              .copyWith(
                bodySmall: const TextStyle(color: bodyTextColor),
                bodyMedium: const TextStyle(color: bodyTextColor),
              )),
      home: const HomeScreen(),
    );
  }
}
