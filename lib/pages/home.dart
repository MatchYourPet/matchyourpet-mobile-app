import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/pages/login_page.dart';
import 'package:matchyourpet_mobile_app/pages/swiping_page.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  int _selectedIndex = 1;

  StorageService storageService = StorageService();

  static List<Widget> pages = <Widget> [
    // TODO Replace with Matches
    Container(color: Colors.red),
    SwipingPage(),
    // TODO Replace with Contact
    Container(color: Colors.blue)
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: hasJwt(),
        builder: (context, data) {
          if (data.hasData) {
            return Scaffold(
              appBar: AppBar(
                  title: Text(
                      'MatchYourPet',
                      style: Theme.of(context).textTheme.headline6),
                  actions: getCurrentIcons()
              ),
              body: pages[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pets),
                    label: 'Matches',
                  ), BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Swipen',
                  ), BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: 'Chat',
                  )],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<bool> hasJwt() {
    Future<bool> hasJwt = storageService.containsKeyInSecureData(StorageAccessKeys.jwt);
    checkForJwt(hasJwt);
    return hasJwt;
  }

  getCurrentIcons() {
    if (_selectedIndex == 1) {
      return [
        IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.supervised_user_circle),
          onPressed: () {},
        ),
      ];
    } else {
      return <Widget> [];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void checkForJwt(Future<bool> hasJwt) {
    hasJwt.then((value) =>
    {if (!value) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage())
      )
    }});
  }

}