import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/filter_params.dart';
import 'package:matchyourpet_mobile_app/pages/chat_page.dart';
import 'package:matchyourpet_mobile_app/pages/filter_page.dart';
import 'package:matchyourpet_mobile_app/pages/login_page.dart';
import 'package:matchyourpet_mobile_app/pages/matches_page.dart';
import 'package:matchyourpet_mobile_app/pages/profile_edit_page.dart';
import 'package:matchyourpet_mobile_app/pages/swiping_page.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  refresh() {
    setState(() {});
  }

  int _selectedIndex = 1;

  StorageService storageService = StorageService();

  static List<Widget> pages = <Widget> [
    const MatchesPage(),
    SwipingPage(),
    const ChatPage()
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: hasJwt(),
        builder: (context, data) {
          if (data.hasData) {
            if (data.data as bool) {
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
              return LoginPage(notifyParent: refresh);
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<bool> hasJwt() {
    Future<bool> hasJwt = storageService.containsKeyInSecureData(StorageAccessKeys.jwt);
    return hasJwt;
  }

  getCurrentIcons() {
    if (_selectedIndex == 1) {
      return [
        IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {openFilterPage();},
        ),
        IconButton(
          icon: const Icon(Icons.supervised_user_circle),
          onPressed: () {openProfileSettingsPage();},
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

  void openFilterPage() async{
    FilterParams filterParams;
    if (await StorageService().containsKeyInSecureData(StorageAccessKeys.filterParams)) {
      StorageService().readSecureData(StorageAccessKeys.filterParams).then((value) => {
        filterParams = FilterParams.fromJson(jsonDecode(value!)),
        Navigator.push(context, MaterialPageRoute(builder: (context) => FilterPage(notifyParent: refresh, filterParams: filterParams)))
      }
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => FilterPage(notifyParent: refresh, filterParams: FilterParams.getEmpty())));
    }
  }

  void openProfileSettingsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditPage(notifyParent: refresh)));
  }

}