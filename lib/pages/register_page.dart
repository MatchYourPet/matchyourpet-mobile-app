import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/user_controller.dart';
import 'package:matchyourpet_mobile_app/api/http_service.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/adopter.dart';
import 'package:matchyourpet_mobile_app/model/constants/living_situation.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

import '../model/constants/area.dart';

class RegisterPage extends StatefulWidget {

  final Function() notifyParent;

  const RegisterPage({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  UserController userController = UserController();
  StorageService storageService = StorageService();

  bool privacyPolicy = false;

  LivingSituation dropdownLivingSituation = LivingSituation.getAll().first;
  Area dropdownRegion = Area.getAll().first;
  bool dropdownGarden = false;
  bool dropdownExistingAnimals = false;

  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputTelephone = TextEditingController();
  TextEditingController inputFirstname = TextEditingController();
  TextEditingController inputSurname = TextEditingController();
  TextEditingController inputDescription = TextEditingController();
  TextEditingController inputBirthday = TextEditingController();
  TextEditingController inputHouseholdSize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar:
        AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text(
            "Neuen Account erstellen",
            style: Theme.of(context).appBarTheme.titleTextStyle
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)}
          ),
        ),
        body:
        ListView(
          scrollDirection: Axis.vertical,
          padding:const EdgeInsets.all(0),
          shrinkWrap:false,
          physics: const ScrollPhysics(),
          children:[

            Padding(
              padding:const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-Mail muss angegeben werden!';
                  }

                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Gültie E-Mail-Adresse angeben!';
                  }
                  return null;
                },
                controller: inputEmail,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration: const InputDecoration(
                  labelText:"E-Mail-Adresse",
                  hintText:"jemand@example.com",
                  filled:false,
                  fillColor: Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal:12),
                  prefixIcon: Icon(Icons.mail,color:Color(0xff212435),size:24),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child:TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Passwort muss angegeben werden!';
                  }
                  return null;
                },
                controller: inputPassword,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration:const InputDecoration(
                  labelText:"Passwort",
                  hintText:"Eingeben...",
                  filled:false,
                  fillColor:Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                  prefixIcon:Icon(Icons.lock,color:Color(0xff212435),size:24),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child:TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefonnummer muss angegeben werden!';
                  }
                  return null;
                },
                controller: inputTelephone,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration:const InputDecoration(
                  labelText:"Telefonnummer",
                  hintText:"+43 1234 56789",
                  filled:false,
                  fillColor:Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 20, 5, 2),
              child:TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vorname muss angegeben werden!';
                  }
                  return null;
                },
                controller: inputFirstname,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration:const InputDecoration(
                  labelText:"Vorname",
                  hintText:"Eingeben...",
                  filled:false,
                  fillColor:Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child:TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nachname muss angegeben werden!';
                  }
                  return null;
                },
                controller: inputSurname,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration:const InputDecoration(
                  labelText:"Nachname",
                  hintText:"Eingeben...",
                  filled:false,
                  fillColor:Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child:TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Beschreibung muss angegeben werden!';
                    }
                    return null;
                  },
                controller: inputDescription,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration:const InputDecoration(
                  labelText:"Beschreibung",
                  hintText:"Eingeben...",
                  filled:false,
                  fillColor:Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding:EdgeInsets.fromLTRB(12, 150, 12, 8),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child:TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geburtsdatum muss angegeben werden!';
                  }
                  if (DateTime.tryParse(value) == null || value.length != 10) {
                    return 'Datum im Format JJJJ-MM-DD eingeben!';
                  }
                  return null;
                },
                controller: inputBirthday,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration:const InputDecoration(
                  labelText:"Geburtsdatum",
                  hintText:"Eingeben...",
                  filled:false,
                  fillColor:Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 20, 5, 2),
              child:Container(
                width:130,
                height:50,
                padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      labelText: 'Region'
                  ),
                  value: dropdownRegion,
                  items: Area.getAll().map<DropdownMenuItem<Area>>((Area value) {
                    return DropdownMenuItem<Area>(
                      value: value,
                      child: Text(value.germanValue),);
                  }).toList(),style: const TextStyle(
                  color:Color(0xff000000),
                  fontSize:16,
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                ),
                  elevation:8,
                  isExpanded: true,
                  onChanged: (Area? value) {
                    setState(() {
                      dropdownRegion = value!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child:Container(
                width:130,
                height:50,
                padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      labelText: 'Wohnsituation'
                  ),
                  value: dropdownLivingSituation,
                  items: LivingSituation.getAll().map<DropdownMenuItem<LivingSituation>>((LivingSituation value) {
                    return DropdownMenuItem<LivingSituation>(
                      value: value,
                      child: Text(value.germanValue),);
                  }).toList(),
                  style: const TextStyle(
                  color:Color(0xff000000),
                  fontSize:16,
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,),
                  elevation:8,
                  isExpanded: true,
                  onChanged: (LivingSituation? value) {
                    setState(() {
                      dropdownLivingSituation = value!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
              child:Container(
                width:130,
                height:50,
                padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Garten vorhanden?'
                  ),
                  value: dropdownGarden,
                  items:[true, false].map<DropdownMenuItem<bool>>((bool value) {
                    return DropdownMenuItem<bool>(
                      value: value,
                      child: Text(value ? 'Ja' : 'Nein'));
                  }).toList(),style: const TextStyle(
                  color:Color(0xff000000),
                  fontSize:16,
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                ), onChanged: (bool? value){
                  setState(() {
                    dropdownGarden = value!;
                  });
                },
                  elevation:8,
                  isExpanded: true,),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 15, 5, 2),
              child:TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Haushaltsgröße muss angegeben werden!';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Wert muss eine Zahl sein!';
                  }
                  return null;
                },
                controller: inputHouseholdSize,
                obscureText:false,
                textAlign:TextAlign.start,
                maxLines:1,
                style:const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                  fontSize:14,
                  color:Color(0xff000000),
                ),
                decoration:const InputDecoration(
                  labelText:"Haushaltsgröße",
                  hintText:"Eingeben...",
                  filled:false,
                  fillColor:Color(0xfff2f2f3),
                  isDense:false,
                  contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(5, 5, 5, 10),
              child:Container(
                width:130,
                height:50,
                padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      labelText: 'Tiere vorhanden?'
                  ),
                  value: dropdownExistingAnimals,
                  items:[true, false].map<DropdownMenuItem<bool>>((bool value) {
                    return DropdownMenuItem<bool>(
                        value: value,
                        child: Text(value ? 'Ja' : 'Nein'));
                  }).toList(),style: const TextStyle(
                  color:Color(0xff000000),
                  fontSize:16,
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                ), onChanged: (bool? value){
                  setState(() {
                    dropdownExistingAnimals = value!;
                  });
                },
                  elevation:8,
                  isExpanded: true,),
              ),
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisSize:MainAxisSize.max,
              children:[
                Padding(
                  padding:const EdgeInsets.symmetric(vertical: 0,horizontal:15),
                  child:Checkbox(
                    onChanged:(value) {
                      setState(() {
                        privacyPolicy = value!;
                      });
                    },
                    activeColor:const Color(0xff3a57e8),
                    autofocus:false,
                    checkColor:const Color(0xffffffff),
                    hoverColor:const Color(0x42000000),
                    splashRadius:20,
                    value: privacyPolicy,
                  ),
                ),
                const Text(
                  "Datenschutzerklärung akzeptiert",
                  textAlign: TextAlign.start,
                  overflow:TextOverflow.clip,
                  style:TextStyle(
                    fontWeight:FontWeight.w400,
                    fontStyle:FontStyle.normal,
                    fontSize:14,
                    color:Color(0xff000000),
                  ),
                ),
              ],),
            Padding(
              padding:const EdgeInsets.fromLTRB(35, 5, 35, 10),
              child:MaterialButton(
                onPressed:() {submit(context);},
                color:const Color(0xff960000),
                elevation:0,
                shape:RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(10.0),
                  side:const BorderSide(color:Color(0xffff0000),width:2),
                ),
                padding:const EdgeInsets.all(16),
                textColor:const Color(0xff000000),
                height:40,
                minWidth:140,
                child:const Text("Jetzt registrieren", style: TextStyle( fontSize:14,
                  fontWeight:FontWeight.w400,
                  fontStyle:FontStyle.normal,
                ),),
              ),
            ),
          ],),
      ),
    );
  }

  submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (privacyPolicy) {
        Adopter adopter = Adopter(0,
            inputFirstname.value.text,
            inputSurname.value.text,
            inputPassword.value.text,
            inputTelephone.value.text,
            inputEmail.value.text,
            inputDescription.value.text,
            DateTime.parse(inputBirthday.value.text),
            dropdownLivingSituation,
            dropdownRegion,
            dropdownGarden,
            int.parse(inputHouseholdSize.value.text),
            dropdownExistingAnimals);

        userController.registerUser(adopter).then((value) => {
          storageService.saveToStorage(StorageAccessKeys.jwt, value.token),
          storageService.saveToStorage(StorageAccessKeys.email, value.email),
          storageService.saveToStorage(StorageAccessKeys.adopterId, value.adopterId.toString()),
          log(value.token),
          Navigator.pop(context),
          widget.notifyParent()
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datenschutzerklärung zustimmen!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formular enthält ungültige Eingaben!')),
      );
    }
  }
}