import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/adopter_controller.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/constants/area.dart';
import 'package:matchyourpet_mobile_app/model/constants/living_situation.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';
import 'package:matchyourpet_mobile_app/services/user_service.dart';

import '../model/adopter.dart';
import '../theme/matchyourpet_theme.dart';

class ProfileEditPage extends StatefulWidget {

  final Function() notifyParent;

  const ProfileEditPage({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {

  final _formKey = GlobalKey<FormState>();
  
  late Adopter adopter;

  LivingSituation dropdownLivingSituation = LivingSituation.getAll().first;
  Area dropdownRegion = Area.getAll().first;
  bool dropdownGarden = false;
  bool dropdownExistingAnimals = false;

  TextEditingController inputTelephone = TextEditingController();
  TextEditingController inputFirstname = TextEditingController();
  TextEditingController inputSurname = TextEditingController();
  TextEditingController inputDescription = TextEditingController();
  TextEditingController inputBirthday = TextEditingController();
  TextEditingController inputHouseholdSize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAdopter(),
        builder: (context, data) {
          if (data.hasData) {
            Adopter adopter = data.data as Adopter;
            dropdownLivingSituation = adopter.livingSituation;
            dropdownRegion = adopter.area;
            dropdownGarden = adopter.garden;
            dropdownExistingAnimals = adopter.existingPets;

            inputTelephone.text = adopter.telephone;
            inputFirstname.text = adopter.firstname;
            inputSurname.text = adopter.surname;
            inputDescription.text = adopter.description;
            inputBirthday.text = DateFormat('yyyy-MM-dd').format(adopter.birthday);
            inputHouseholdSize.text= adopter.householdSize.toString();
            this.adopter = adopter;

            return Form(
              key: _formKey,
              child: Scaffold(
                backgroundColor: const Color(0xffffffff),
                appBar:
                AppBar(
                  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                  title: Text(
                      "Profil bearbeiten",
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
                      padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
                      child:TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Telefonnummer muss angegeben werden!';
                          }
                          if (!RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$").hasMatch(value)) {
                            return 'Telefonnummer darf nur + und Zahlen enthalten';
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
                          hintText:"+43123456789",
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
                          hintText:"Erzähl etwas über dich...",
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
                        height:75,
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
                            dropdownRegion = value!;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
                      child:Container(
                        width:130,
                        height:75,
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
                              dropdownLivingSituation = value!;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.fromLTRB(5, 5, 5, 2),
                      child:Container(
                        width:130,
                        height:75,
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
                            dropdownGarden = value!;
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
                        height:75,
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
                            dropdownExistingAnimals = value!;
                        },
                          elevation:8,
                          isExpanded: true,),
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.fromLTRB(35, 5, 35, 10),
                      child: MaterialButton(
                        onPressed:() {save();},
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
                            "Speichern",
                            style: Theme.of(context).textTheme.headline3
                        ),
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.fromLTRB(35, 5, 35, 10),
                      child: MaterialButton(
                        onPressed:() {logout();},
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
                            "Logout",
                            style: Theme.of(context).textTheme.headline3
                        ),
                      ),
                    ),
                  ],),
              ),
            );
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
                backgroundColor: Colors.white,);
          }
        }
        );
  }

  Future<Adopter> getAdopter () async {
    int adopterId = int.parse(await StorageService().readSecureData(StorageAccessKeys.adopterId) as String);
    return AdopterController().loadAdopterById(adopterId);
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      Adopter adopter = Adopter(0,
          inputFirstname.text,
          inputSurname.text,
          inputTelephone.text,
          this.adopter.userEmail,
          inputDescription.text,
          DateTime.parse(inputBirthday.text),
          dropdownLivingSituation,
          dropdownRegion,
          dropdownGarden,
          int.parse(inputHouseholdSize.text),
          dropdownExistingAnimals);
      AdopterController().saveAdopter(adopter)
          .then((value) => {Navigator.pop(context)});
    }
  }

  void logout() {
    UserService().logoutUser().then((value) => {
      Navigator.pop(context),
      widget.notifyParent()
    });
  }
}