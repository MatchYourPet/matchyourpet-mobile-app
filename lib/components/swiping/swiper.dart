import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../model/content.dart';

class Swiper extends StatefulWidget {
  const Swiper({super.key});

  @override
  SwiperState createState() => SwiperState();
}

class SwiperState extends State<Swiper> {

  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {log('liked ${_names[i]}');},
          nopeAction: () {log('liked ${_names[i]}');}));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
        matchEngine: _matchEngine,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: _swipeItems[index].content.color,
            child: Text(
              _swipeItems[index].content.text,
              style: const TextStyle(fontSize: 100),
            ),
          );
        },
        onStackFinished: () {
          log('thats it');
        },
        itemChanged: (SwipeItem item, int index) {
          print("item: ${item.content.text}, index: $index");
        },
        fillSpace: true,
      );
  }
}
