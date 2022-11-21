import 'package:flutter/material.dart';

import '../model/shelter.dart';

class ShelterChatPage extends StatefulWidget {

  final Shelter shelter;

  const ShelterChatPage({Key? key, required this.shelter}) : super(key: key);

  @override
  State<ShelterChatPage> createState() => _ShelterChatPageState();
}

class _ShelterChatPageState extends State<ShelterChatPage> {
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
          widget.shelter.name,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton (
          icon: const Icon(Icons.arrow_back),
          onPressed: () {navigateBack(context);},
        )
      ),
      body:Padding(
        padding:const EdgeInsets.all(16),
        child:
        Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisSize:MainAxisSize.max,
          children: [

            ListView(
              scrollDirection: Axis.vertical,
              padding:const EdgeInsets.all(0),
              shrinkWrap:true,
              physics:const ScrollPhysics(),
              children:[

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
                            "${widget.shelter.street} ${widget.shelter.houseNumber}"
                                "${widget.shelter.stair != '' ? '/${widget.shelter.stair}' : ''}"
                                "${widget.shelter.door != '' ? '/${widget.shelter.door}' : ''}",
                            textAlign: TextAlign.start,
                            overflow:TextOverflow.clip,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            "${widget.shelter.postalCode} ${widget.shelter.city}",
                            textAlign: TextAlign.start,
                            overflow:TextOverflow.clip,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],),
                    ],),),
              ],),
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
                        widget.shelter.contactPersonName,
                        textAlign: TextAlign.start,
                        overflow:TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        widget.shelter.userEmail,
                        textAlign: TextAlign.start,
                        overflow:TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        widget.shelter.telephone,
                        textAlign: TextAlign.start,
                        overflow:TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],),
                ],),),
          ],),),
    );
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }
}