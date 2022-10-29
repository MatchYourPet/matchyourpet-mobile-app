import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/matching_controller.dart';

import '../components/shelter_chat_symbol.dart';
import '../model/shelter.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MatchingController().getMatchedShelters(),
      builder: (context, data) {
        if (data.hasData) {
          return Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisSize:MainAxisSize.max,
            children: [
              ListView(
                scrollDirection: Axis.vertical,
                padding:const EdgeInsets.all(0),
                shrinkWrap:true,
                physics:const ScrollPhysics(),
                children: generateChildren(data.data as List<Shelter>)
            ),
        ]);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<ShelterChatSymbol> generateChildren (List<Shelter> shelters) {
    List<ShelterChatSymbol> symbols = [];
    for (int i = 0; i < shelters.length; i++) {
      symbols.add(ShelterChatSymbol(shelter: shelters[i]));
    }
    return symbols;
}

}