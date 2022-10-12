import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/pages/home.dart';
import 'package:matchyourpet_mobile_app/pages/login_page.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';
import 'package:matchyourpet_mobile_app/theme/matchyourpet_theme.dart';

import 'constants/storage_access_keys.dart';
void main() {
  runApp(const MatchYourPet());
}

class MatchYourPet extends StatelessWidget {
  const MatchYourPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MatchYourPetTheme.light();

    return MaterialApp(
      theme: theme,
      title: 'MatchYourPet',
      home: const Home(),
    );
  }
}
