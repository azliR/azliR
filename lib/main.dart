import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, size.height / 3, size.width / 8, 24),
          child: Text.rich(
            TextSpan(
              text: "I'm ",
              children: [
                TextSpan(
                  text: 'Rizal Hadiyansah',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            style: GoogleFonts.jetBrainsMono(
              fontSize: 36,
              fontWeight: FontWeight.w100,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
