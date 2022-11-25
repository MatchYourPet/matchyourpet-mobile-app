import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/model/animal.dart';
import 'package:matchyourpet_mobile_app/pages/shelter_chat_page.dart';
import 'package:matchyourpet_mobile_app/theme/matchyourpet_theme.dart';

class AnimalDetailPage extends StatefulWidget {
  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();

  final Animal animal;

  const AnimalDetailPage({Key? key, required this.animal}) : super(key: key);
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar:
      AppBar(
          elevation:0,
          centerTitle:false,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius:BorderRadius.zero,
          ),
          title: Text (
            widget.animal.name,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: IconButton (
            icon: const Icon(Icons.arrow_back),
            onPressed: () {navigateBack(context);},
          )
      ),
      body: ListView(
        children: [Padding(
          padding:const EdgeInsets.all(16),
          child:
          Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisSize:MainAxisSize.max,
            children: [
          Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(
            width: 350,
            height: 450,
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("http://5.132.159.71:9000/animal/picture?animalId=${widget.animal.id}"),
                  fit: BoxFit.cover
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))
            ),
          ),
              Padding(
                padding:const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  mainAxisSize:MainAxisSize.max,
                  children:[
                    Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisSize:MainAxisSize.max,
                      children: [
                        Text(
                          '${widget.animal.name} (${widget.animal.gender.germanValue})',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          "${widget.animal.breed.name} (${widget.animal.breed.animalType.name})",
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          '${DateTime.now().year - widget.animal.birthYear} Jahre alt',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          widget.animal.color,
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],),
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  mainAxisSize:MainAxisSize.max,
                  children:[
                    Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisSize:MainAxisSize.max,
                      children: [
                        Text(
                          widget.animal.coreVaccines ? 'Wichtigste Impfungen vorhanden' : 'Wichtigste Impfungen nicht vorhanden',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          widget.animal.documents ? 'Dokumente vorhanden' : 'Dokumente nicht vorhanden',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          widget.animal.apartment ? 'Wohnungstier' : 'Kein Wohnungstier',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          widget.animal.garden ? 'Benötigt Garten' : 'Benötigt keinen Garten',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          widget.animal.housetrained ? 'Stubenrein' : 'Nicht stubenrein',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          'Erforderliche Lebenssituation: ${widget.animal.requiredLivingSituation.germanValue}',
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],),
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  mainAxisSize:MainAxisSize.max,
                  children:[
                    Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisSize:MainAxisSize.max,
                      children: [
                        Text(
                          "Untergebracht in: ${widget.animal.shelter.name}",
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "${widget.animal.shelter.postalCode}, ${widget.animal.shelter.city}",
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "Adoptionspreis: € ${widget.animal.price}",
                          textAlign: TextAlign.start,
                          overflow:TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child:  MaterialButton(
                  onPressed:() {openShelterInfoPage(context);},
                  color: MatchYourPetTheme.matchyourpetRed,
                  elevation:0,
                  shape:RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10.0),
                  ),
                  padding:const EdgeInsets.all(16),
                  textColor:const Color(0xff000000),
                  height:40,
                  minWidth:140,
                  child: Text(
                      "Tierheim kontaktieren",
                      style: Theme.of(context).textTheme.headline3
                  ),
                ),
              )
            ])),
    ]));
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  void openShelterInfoPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShelterChatPage(shelter: widget.animal.shelter)));
  }
}