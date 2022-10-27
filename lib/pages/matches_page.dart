import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/matching_controller.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/match.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

import '../components/match_card_entry.dart';

class MatchesPage extends StatefulWidget {

  const MatchesPage({Key? key}) : super(key: key);


  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
              future: MatchingController().getMatches(),
              builder: (context, data) {
                if (data.hasData) {
                  return ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: false,
                      physics: const ScrollPhysics(),
                      children: generateMatchEntries(data.data as List<Match>)
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
              );
    /*return */
  }

  List<MatchCardEntry> generateMatchEntries (List<Match> matches) {
    List<MatchCardEntry> entries = [];
    for (int i = 0; i < matches.length; i++) {
      entries.add(MatchCardEntry(
          match: matches[i],
          notifyParent: refresh,
      ));
    }
    return entries;

  }
}

