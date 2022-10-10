import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/components/swiping/swiping_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> pages = <Widget> [
    // TODO Replace with Matches
    Container(color: Colors.red),
    // TODO Replace with Swiping
    SwipingPage(),
    // TODO Replace with Contact
    Container(color: Colors.blue)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('MatchYourPet',
              style: Theme.of(context).textTheme.headline6)
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.send_rounded),
            label: 'Matches',
          ), BottomNavigationBarItem(
            icon: Icon(Icons.send_rounded),
            label: 'Swipen',
          ), BottomNavigationBarItem(
            icon: Icon(Icons.send_rounded),
            label: 'Kontakt',
          )],
      ),
      );
  }
}