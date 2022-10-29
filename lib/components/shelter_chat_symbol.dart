import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/model/shelter.dart';
import 'package:matchyourpet_mobile_app/pages/shelter_chat_page.dart';

class ShelterChatSymbol extends StatefulWidget {

  final Shelter shelter;

  const ShelterChatSymbol({Key? key, required this.shelter}) : super(key: key);

  @override
  State<ShelterChatSymbol> createState() => _ShelterChatSymbolState();
}

class _ShelterChatSymbolState extends State<ShelterChatSymbol> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {openShelterInfoPage(context)},
        child: Container(
          margin:const EdgeInsets.fromLTRB(0, 0, 0, 16),
          padding:const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:const Color(0xffffffff),
            shape:BoxShape.rectangle,
            borderRadius:BorderRadius.circular(12.0),
            border:Border.all(color:const Color(0x4d9e9e9e),width:1),
          ),
          child:
          Row(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisSize:MainAxisSize.max,
            children:[

              Expanded(
                flex: 1,
                child: Padding(
                  padding:const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child:
                  Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisSize:MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.center,
                        mainAxisSize:MainAxisSize.max,
                        children:[

                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              mainAxisSize:MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      widget.shelter.name,
                                      textAlign: TextAlign.start,
                                      maxLines:1,
                                      overflow:TextOverflow.clip,
                                      style: Theme.of(context).textTheme.headline4
                                  ),
                                ),
                              ],),),
                        ],),
                      Padding(
                        padding:const EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child:Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisSize:MainAxisSize.max,
                          children:[
                            Expanded(
                              flex: 1,
                              child: Text(
                                  "${widget.shelter.postalCode} ${widget.shelter.city}",
                                  textAlign: TextAlign.start,
                                  maxLines:1,
                                  overflow:TextOverflow.clip,
                                  style: Theme.of(context).textTheme.bodyText1
                              ),
                            ),
                            Container(
                              margin:const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                              decoration: BoxDecoration(
                                color:const Color(0x343a57e8),
                                shape:BoxShape.rectangle,
                                borderRadius:BorderRadius.circular(4.0),
                              ),
                            )
                            ,
                          ],),),
                    ],),),),
            ],),
        ),
    );
  }

  openShelterInfoPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShelterChatPage(shelter: widget.shelter)));
  }
}