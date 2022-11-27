import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/animal_type_controller.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/breed_controller.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/model/animal_type.dart';
import 'package:matchyourpet_mobile_app/model/breed.dart';
import 'package:matchyourpet_mobile_app/model/constants/gender.dart';
import 'package:matchyourpet_mobile_app/model/filter_params.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';
import 'package:matchyourpet_mobile_app/theme/matchyourpet_theme.dart';

class FilterPage extends StatefulWidget {

  final FilterParams filterParams;
  final Function() notifyParent;

  const FilterPage({Key? key, required this.filterParams, required this.notifyParent}) : super(key: key);


  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController inputMinAge = TextEditingController();
  TextEditingController inputMaxAge = TextEditingController();
  TextEditingController inputMaxPrice = TextEditingController();
  TextEditingController inputMaxDistance = TextEditingController();

  List<AnimalType> animalTypes = [];
  List<Breed> breeds = [];

  @override
  Widget build(BuildContext context) {
    if (animalTypes.isEmpty) {
      getAnimalTypes();
    }

    inputMinAge.text = widget.filterParams.minAge != null ? widget.filterParams.minAge.toString(): "";
    inputMaxAge.text = widget.filterParams.maxAge != null ? widget.filterParams.maxAge.toString(): "";
    inputMaxPrice.text = widget.filterParams.maxPrice != null ? widget.filterParams.maxPrice.toString(): "";
    inputMaxDistance.text = widget.filterParams.maxDistance != null ? widget.filterParams.maxDistance.toString(): "";
    return Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: const Color(0xffffffff),
              appBar:
              AppBar(
                actions: [
                  IconButton(onPressed: () => {pressReset()}, icon: const Icon(Icons.refresh))
                ],
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                title: Text(
                    "Filtereinstellungen",
                    style: Theme.of(context).appBarTheme.titleTextStyle
                ),
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => {
                      Navigator.pop(context),
                      widget.notifyParent()}
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
                        if (value != null && value.isNotEmpty && int.tryParse(value) == null) {
                          return 'Wert muss eine Zahl sein!';
                        }
                        return null;
                      },
                      controller: inputMinAge,
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
                        labelText:"Altersminimum",
                        hintText:"5",
                        filled:false,
                        fillColor: Color(0xfff2f2f3),
                        isDense:false,
                        contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal:12)
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty && int.tryParse(value) == null) {
                          return 'Wert muss eine Zahl sein!';
                        }
                        return null;
                      },
                      controller: inputMaxAge,
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
                        labelText:"Altersmaximum",
                        hintText:"12",
                        filled:false,
                        fillColor: Color(0xfff2f2f3),
                        isDense:false,
                        contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal:12)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      children: [
                        Switch(
                          activeColor: MatchYourPetTheme.matchyourpetRed,
                          onChanged: (bool value) {
                            setState(() {
                              widget.filterParams.shouldHaveCoreVaccines = value;
                              });
                            },
                          value: widget.filterParams.shouldHaveCoreVaccines,
                        ),
                        Text('Wichtigste Impfungen vorhanden',
                        style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                  Container(
                    width:130,
                    height:75,
                    padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: 'Tierart'
                      ),
                      value: widget.filterParams.preferredAnimalType != null ? widget.filterParams.preferredAnimalType!.id : null,
                      items: animalTypes.map<DropdownMenuItem<int>>((AnimalType value) {
                        return DropdownMenuItem<int>(
                          value: value.id,
                          child: Text(value.name));
                      }).toList(),
                      style: const TextStyle(
                        color:Color(0xff000000),
                        fontSize:16,
                        fontWeight:FontWeight.w400,
                        fontStyle:FontStyle.normal,),
                      elevation:8,
                      isExpanded: true,
                      onChanged: (int? value) {
                        setState(() {
                          widget.filterParams.preferredAnimalType = AnimalType(id: value!, name: "");
                        });
                        loadBreeds();
                      },
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:Container(
                      width:130,
                      height:75,
                      padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            labelText: 'Rasse'
                        ),
                        value: widget.filterParams.preferredAnimalBreed != null ? widget.filterParams.preferredAnimalBreed!.id : null,
                        items: breeds.map<DropdownMenuItem<int>>((Breed value) {
                          return DropdownMenuItem<int>(
                            value: value.id,
                            child: Text(value.name),);
                        }).toList(),
                        style: const TextStyle(
                          color:Color(0xff000000),
                          fontSize:16,
                          fontWeight:FontWeight.w400,
                          fontStyle:FontStyle.normal,),
                        elevation:8,
                        isExpanded: true,
                        onChanged: (int? value) {
                          setState(() {
                            widget.filterParams.preferredAnimalBreed = Breed(id: value!, name: '', animalType: AnimalType(id: 0, name: ''));
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:Container(
                      width:130,
                      height:75,
                      padding:const EdgeInsets.symmetric(vertical: 4,horizontal:8),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            labelText: 'Geschlecht'
                        ),
                        value: widget.filterParams.preferredGender,
                        items: Gender.getAll().map<DropdownMenuItem<Gender>>((Gender value) {
                          return DropdownMenuItem<Gender>(
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
                        onChanged: (Gender? value) {
                          setState(() {
                            widget.filterParams.preferredGender = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                          return 'Wert muss eine Zahl sein! (Komma als Punkt eingeben)';
                        }
                        return null;
                      },
                      controller: inputMaxPrice,
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
                          labelText:"Maximaler Preis",
                          hintText:"15.99",
                          filled:false,
                          fillColor: Color(0xfff2f2f3),
                          isDense:false,
                          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal:12)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      children: [
                        Switch(
                          activeColor: MatchYourPetTheme.matchyourpetRed,
                          onChanged: (bool value) {
                            setState(() {
                              widget.filterParams.shouldHaveDocuments = value;
                            });
                          },
                          value: widget.filterParams.shouldHaveDocuments,
                        ),
                        Text('Dokumente vorhanden',
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      children: [
                        Switch(
                          activeColor: MatchYourPetTheme.matchyourpetRed,
                          onChanged: (bool value) {
                            setState(() {
                              widget.filterParams.apartmentOnlyAnimal = value;
                            });
                          },
                          value: widget.filterParams.apartmentOnlyAnimal,
                        ),
                        Text('Für ausschließliche Wohnungshaltung',
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      children: [
                        Switch(
                          activeColor: MatchYourPetTheme.matchyourpetRed,
                          onChanged: (bool value) {
                            setState(() {
                              widget.filterParams.shouldBeHousetrained = value;
                            });
                          },
                          value: widget.filterParams.shouldBeHousetrained,
                        ),
                        Text('Stubenrein',
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                          return 'Wert muss eine Zahl sein!';
                        }
                        return null;
                      },
                      controller: inputMaxDistance,
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
                          labelText:"Maximale Distanz",
                          hintText:"300",
                          filled:false,
                          fillColor: Color(0xfff2f2f3),
                          isDense:false,
                          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal:12)
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(35, 5, 35, 10),
                    child: MaterialButton(
                      onPressed:() {pressSubmit();},
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
                ],
              ),
            ),
          );
  }

  void getAnimalTypes() {
    AnimalTypeController().getAnimalTypes().then((value) =>
    {
      setState(() {
        animalTypes = value;
        if (widget.filterParams.preferredAnimalType != null) {
          loadBreeds();
        }
      })
    });
  }

  void loadBreeds() {
    BreedController().getBreedsForAnimalType(widget.filterParams.preferredAnimalType!.id).then((value) =>
    {
      setState((){
        breeds = value;
      })
    });
  }

  void pressSubmit() {
    if (_formKey.currentState!.validate()) {
      String filterParams = FilterParams(
          int.tryParse(inputMinAge.text) != null ? int.parse(inputMinAge.text) : null,
          int.tryParse(inputMaxAge.text) != null ? int.parse(inputMaxAge.text) : null,
          widget.filterParams.shouldHaveCoreVaccines,
          widget.filterParams.preferredAnimalType,
          widget.filterParams.preferredAnimalBreed,
          widget.filterParams.preferredGender,
          double.tryParse(inputMaxPrice.text) != null ? double.parse(inputMaxPrice.text) : null,
          widget.filterParams.shouldHaveDocuments,
          widget.filterParams.apartmentOnlyAnimal,
          widget.filterParams.shouldBeHousetrained,
          int.tryParse(inputMaxDistance.text) != null ? int.parse(inputMaxDistance.text) : null).JsonStringValue();

      StorageService().saveToStorage(
          StorageAccessKeys.filterParams,
          filterParams).then((value) => {
            Navigator.pop(context),
            widget.notifyParent()
      });
    }
  }

  void pressReset() {
    setState(() => {
      inputMinAge = TextEditingController(),
      widget.filterParams.minAge = null,
      inputMaxAge = TextEditingController(),
      widget.filterParams.maxAge = null,
      widget.filterParams.shouldHaveCoreVaccines = false,
      widget.filterParams.preferredAnimalType=null,
      widget.filterParams.preferredAnimalBreed=null,
      widget.filterParams.preferredGender=null,
      inputMaxPrice = TextEditingController(),
      widget.filterParams.maxPrice = null,
      widget.filterParams.shouldHaveDocuments = false,
      widget.filterParams.apartmentOnlyAnimal = true,
      widget.filterParams.shouldBeHousetrained = false,
      inputMaxDistance = TextEditingController(),
      widget.filterParams.maxDistance = null,
      animalTypes = [],
      breeds = [],
      StorageService().saveToStorage(
      StorageAccessKeys.filterParams,
      widget.filterParams.JsonStringValue())
    });
  }

}