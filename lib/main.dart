import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/components/home.dart';
import 'package:matchyourpet_mobile_app/theme/matchyourpet_theme.dart';
void main() {
  runApp(const MatchYourPet());
}

class MatchYourPet extends StatelessWidget {
  const MatchYourPet({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = MatchYourPetTheme.light();

    return MaterialApp(
      theme: theme,
      title: 'Flutter Demo',
      home: const Home(),
    );
  }
}
