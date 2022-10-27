import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/matching_controller.dart';
import 'package:matchyourpet_mobile_app/services/hex_color.dart';
import 'package:matchyourpet_mobile_app/model/match.dart';

class MatchCardEntry extends StatefulWidget {

  final Match match;
  
  final Function() notifyParent;

  const MatchCardEntry({Key? key, required this.match, required this.notifyParent}) : super(key: key);

  @override
  State<MatchCardEntry> createState() => _MatchCardEntryState();
}

class _MatchCardEntryState extends State<MatchCardEntry> {

  Color green = HexColor.fromHex('#b5fcae');
  Color red = HexColor.fromHex('#ff9999');

  MatchingController matchingController = MatchingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      color: widget.match.matched ? green : red,
      shadowColor: Colors.black,
      elevation:1,
      shape:RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(4.0),
        side: const BorderSide(color:Color(0x4d9e9e9e), width:1),
      ),
      child:
      Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        crossAxisAlignment:CrossAxisAlignment.center,
        mainAxisSize:MainAxisSize.max,
        children:[

          Padding(
            padding:const EdgeInsets.fromLTRB(5, 5, 25, 5),
            child:Container(
              height:78,
              width:78,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child:Image.network(
                  'http://5.132.159.71:9000/animal/picture?animalId=${widget.match.animal.id}',
                  fit:BoxFit.cover),
            ),
          ),

          Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisSize:MainAxisSize.max,
            children: [
              Padding(
                padding:const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child:Text(
                  widget.match.animal.name,
                  textAlign: TextAlign.start,
                  overflow:TextOverflow.clip,
                  style: Theme.of(context).textTheme.headline2
                ),
              ),
              Text(
                '${widget.match.matchTime.day}. ${widget.match.matchTime.month}. ${widget.match.matchTime.year}',
                textAlign: TextAlign.start,
                overflow:TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyText1,
                ),
            ],),
          Padding(
            padding:const EdgeInsets.fromLTRB(40, 0, 0, 0),
            child:IconButton(
              icon:const Icon(
                  Icons.delete
              ),
              onPressed:(){ deleteMatch(widget.match.id, context); },
              color: Colors.black,
              iconSize:24,
            ),
          ),
        ],),
    );
  }

  void deleteMatch(int id, BuildContext context) {
    matchingController.deleteMatch(id).then((value) => widget.notifyParent());
  }

}