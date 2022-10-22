import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/animal_suggestion_controller.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/matching_controller.dart';
import 'package:matchyourpet_mobile_app/components/swiping/animal_swiping_card.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../model/animal.dart';

class Swiper extends StatefulWidget {
  const Swiper({super.key});

  @override
  SwiperState createState() => SwiperState();
}

class SwiperState extends State<Swiper> {

  late final List<Animal> animals;

  StorageService storageService = StorageService();

  MatchingController matchingController = MatchingController();

  @override
  initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AnimalSuggestionController().suggestAnimals(),
        builder: (context, data) {
          if (data.hasData) {
            List<SwipeItem> swipeItems = loadData(data);
            MatchEngine matchEngine = MatchEngine(swipeItems: swipeItems);
            
            if (swipeItems.isNotEmpty) {
              return SwipeCards(
                matchEngine: matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: swipeItems[index].content,
                  );
                },
                onStackFinished: () {
                  // TODO: Show not existing animal
                },
                itemChanged: (SwipeItem item, int index) {
                  // TODO: implement item change
                },
                fillSpace: true,
              );
            } else {
              return const Text('Leider keine Tiere gefunden');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  List<SwipeItem> loadData(AsyncSnapshot<Object?> data) {
    List<Animal> values = data.data as List<Animal>;
    List<SwipeItem> swipeItems = <SwipeItem>[];

    for (int i = 0; i < values.length; i++) {
      swipeItems.add(
          SwipeItem(
              content: AnimalSwipingCard(
                  animal: values[i]
              ),
              likeAction: () {likeAction(values[i].id);},
              nopeAction: () {dislikeAction(values[i].id);}
          )
      );
    }
    return swipeItems;
  }

  likeAction(int animalId) {
    storageService.readSecureData(StorageAccessKeys.adopterId).then((value) =>
        matchingController.matchAnimal(int.parse(value!), animalId)
    );
  }
  
  dislikeAction(int animalId) {
    storageService.readSecureData(StorageAccessKeys.adopterId).then((value) =>
        matchingController.notMatchAnimal(int.parse(value!), animalId)
    );
  }

}
