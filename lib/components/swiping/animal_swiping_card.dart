import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/model/animal.dart';
import 'package:matchyourpet_mobile_app/pages/animal_details_page.dart';
import 'package:matchyourpet_mobile_app/theme/matchyourpet_theme.dart';

class AnimalSwipingCard extends StatefulWidget {

  final Animal animal;

  const AnimalSwipingCard({Key? key, required this.animal}) : super(key: key);


  @override
  State<AnimalSwipingCard> createState() => _AnimalSwipingCardState();

}
class _AnimalSwipingCardState extends State<AnimalSwipingCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('http://194.15.36.67:9000/animal/picture?animalId=${widget.animal.id}'),
          fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.srcOver)
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      child: Stack (
        children: [
          Text(
            widget.animal.breed.name,
            style: MatchYourPetTheme.lightTextTheme.bodyText1,
          ),
          Positioned(
              top: 20,
              child: Text(
                widget.animal.name,
                style: MatchYourPetTheme.lightTextTheme.headline2,
              )
          ),
          Positioned(
            bottom: 30,
            right: 0,
            child: Text(
              widget.animal.birthYear.toString(),
              style: MatchYourPetTheme.lightTextTheme.bodyText2,
            )
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Text(
              '${widget.animal.shelter.distanceToAdopter} km entfernt',
              style: MatchYourPetTheme.lightTextTheme.bodyText1,
            )
          ),
          Positioned(
            bottom: 0,
            child: IconButton (
              icon: const Icon(Icons.info),
              onPressed: () {openAnimalInfoPage(context);},
            ),
          )
        ],
      ),
    );
  }

  void openAnimalInfoPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalDetailPage(animal: widget.animal, isSwiping: true,)));
  }
}