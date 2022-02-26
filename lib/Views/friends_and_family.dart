import 'dart:developer';

import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Constants/relations.dart';
import 'package:astrotak/Models/location_api_model.dart';
import 'package:astrotak/Models/relatives_model.dart';
import 'package:astrotak/Provider/relative_provider.dart';
import 'package:astrotak/Services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FriendsAndFamily extends StatefulWidget {
  final ScrollController scontroller;
  final ScrollPhysics sphysics;

  const FriendsAndFamily(
      {Key? key, required this.scontroller, required this.sphysics})
      : super(key: key);

  @override
  State<FriendsAndFamily> createState() => _FriendsAndFamilyState();
}

class _FriendsAndFamilyState extends State<FriendsAndFamily> {
  @override
  void initState() {
    super.initState();
    final queProv = Provider.of<RelativesDataProvider>(context, listen: false);
    queProv.getRelativesData();
    node = FocusNode();

    relations = [
      Relations("Father", 1),
      Relations("Mother", 2),
      Relations("Brother", 3),
      Relations("Sister", 4),
      Relations("Spouse", 5),
      Relations("Son", 6),
      Relations("Daughter", 7),
      Relations("Father in Law", 8),
      Relations("Mother in Law", 9),
      Relations("Brother in Law", 10),
      Relations("Sister in Law", 11),
      Relations("Daughter in Law", 12),
      Relations("Uncle", 13),
      Relations("Aunt", 14),
      Relations("Friend", 15),
      Relations("Fiance", 16),
    ];
    debugPrint(_relation.relation);
    // node!.requestFocus();
  }

  @override
  void dispose() {
    node!.dispose();
    super.dispose();
  }

  bool addingProfile = false;
  bool _isEditProfile = false;
  final _formKey = GlobalKey<FormState>();
  late FocusNode? node;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _location = TextEditingController(text: "");
  final TextEditingController _dd = TextEditingController();
  final TextEditingController _mm = TextEditingController();
  final TextEditingController _yy = TextEditingController();
  final TextEditingController _hh = TextEditingController();
  final TextEditingController _min = TextEditingController();
  final TextEditingController _pob = TextEditingController();
  final TextEditingController _gender = TextEditingController(text: 'MALE');
  String uuid = "";
  BirthPlace _birthPlace = BirthPlace();
  Relations _relation = Relations("Father", 1);
  List<Relations>? relations = [];
  String amPm = "AM";
  setAmPmSwitch(String ap) {
    setState(() {
      amPm = ap;
    });
  }

  preFillUser(AllRelatives relative) {
    _name.text = relative.fullName!;
    _pob.text = relative.birthPlace!.placeName!;
    _gender.text = relative.gender!;
    _relation.relation = relative.relation!;
    _dd.text = relative.birthDetails!.dobDay.toString();
    _mm.text = relative.birthDetails!.dobMonth.toString();
    _yy.text = relative.birthDetails!.dobYear.toString();
    _hh.text = relative.birthDetails!.tobHour.toString();
    _min.text = relative.birthDetails!.tobMin.toString();
    _birthPlace.placeId = relative.birthPlace!.placeId;
    _birthPlace.placeName = relative.birthPlace!.placeName;
    _location.text = relative.birthPlace!.placeName!;
    _relation.relation = relative.relation;
    _relation.relationId = relative.relationId;
    amPm = relative.birthDetails!.meridiem!;
    uuid = relative.uuid!;
    log(_birthPlace.placeName!);
  }

  clearControllers() {
    _dd.clear();
    _mm.clear();
    _hh.clear();
    _yy.clear();
    _min.clear();
    _location.clear();
    _name.clear();
    amPm = "PM";
  }

  setAddingProfile(_edit) {
    clearControllers();
    setState(() {
      _isEditProfile = _edit;
      addingProfile = !addingProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RelativesDataProvider>(
        builder: (context, relatives, child) {
      return RefreshIndicator(
        onRefresh: () => relatives.getRelativesData(),
        child: ListView(
            //  controller: widget.scontroller,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: [
              addingProfile
                  ? addNewProfile(_isEditProfile, relatives)
                  : relativeProfile(relatives)
            ]),
      );
    });
  }

  Widget relativeProfile(RelativesDataProvider relatives) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: lblue,
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.account_balance_wallet,
                size: 30,
                color: blue,
              ),
              const Text("Wallet Balance: ₹ 0",
                  style: TextStyle(color: blue, fontWeight: FontWeight.w400)),
              TextButton(
                onPressed: () {},
                child: const Text("Add Money"),
                style: TextButton.styleFrom(
                    primary: blue,
                    textStyle: const TextStyle(color: black),
                    backgroundColor: white),
              )
            ],
          ),
        ),
        relatives.relatives.data != null
            ? DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Name'),
                  ),
                  DataColumn(
                    label: Text('DOB'),
                  ),
                  DataColumn(
                    label: Text('TOB'),
                  ),
                  DataColumn(
                    label: Text('Relation'),
                  ),
                  DataColumn(
                    label: Text(''),
                  ),
                  DataColumn(
                    label: Text(''),
                  ),
                ],
                columnSpacing: 5,
                
                showBottomBorder: true,
                dividerThickness: 5,
                rows: List<DataRow>.generate(
                  relatives.relatives.data!.allRelatives!.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(relatives
                              .relatives.data!.allRelatives![index].firstName ??
                          "")),
                      DataCell(Text(DateFormat("dd-MM-yyyy").format(
                          DateTime.parse(relatives.relatives.data!
                              .allRelatives![index].dateAndTimeOfBirth
                              .toString())))),
                      DataCell(Text(DateFormat("hh:mm").format(DateTime.parse(
                          relatives.relatives.data!.allRelatives![index]
                              .dateAndTimeOfBirth
                              .toString())))),
                      DataCell(
                        Text(relatives.relatives.data!.allRelatives![index]
                                .relation ??
                            ""),
                      ),
                      DataCell(IconButton(
                          onPressed: () {
                            setAddingProfile(true);
                            preFillUser(
                                relatives.relatives.data!.allRelatives![index]);
                          },
                          icon: const Icon(Icons.edit))),
                      DataCell(IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return SimpleDialog(
                                    elevation: 20,
                                    title: const Center(
                                      child: Text(
                                        "Do you really want to Delete?",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          relatives.deleteLoader
                                              ? const CircularProgressIndicator()
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    relatives.deleteRelative(
                                                        relatives
                                                                .relatives
                                                                .data!
                                                                .allRelatives![
                                                            index],
                                                        context);
                                                  },
                                                  child: const Text(
                                                    "Yes",
                                                    style:
                                                        TextStyle(color: white),
                                                  )),
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("No",
                                                  style:
                                                      TextStyle(color: white)))
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete))),
                    ],
                  ),
                ),
              )
            : relatives.relatives.message != (null)
                ? relatives.relatives.message!.contains("No relatives found")
                    ? const Text("No relatives")
                    : const CircularProgressIndicator()
                : const CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () => setAddingProfile(false),
            child: const Text(
              "+Add New Profile",
              style: TextStyle(color: white),
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }

  Widget addNewProfile(bool _isEditProfile, RelativesDataProvider relative,
      [String? title, AllRelatives? relatives]) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => setAddingProfile(false),
                  icon: const Icon(Icons.arrow_back_ios)),
              _isEditProfile
                  ? const Text("Edit Profile")
                  : const Text("Add New Profile")
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Name"),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Valid Name';
              }
              return null;
            },
            controller: _name,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Date of Birth"),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    maxLength: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid DD';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _dd,
                    decoration: InputDecoration(
                      hintText: "DD",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    maxLength: 2,
                    controller: _mm,
                    onChanged: (value) {
                      setState(() {
                        _mm.text = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid MM';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "MM",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    maxLength: 4,
                    controller: _yy,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid YY';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "YYYY",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Time of Birth"),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    maxLength: 2,
                    controller: _hh,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid HH';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "HH",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    maxLength: 2,
                    controller: _min,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid MM';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "MM",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => setAmPmSwitch("AM"),
                              child: Container(
                                height: 50,
                                width: 50,
                                color: amPm.contains('AM') ? blue : white,
                                child: Center(
                                    child: Text(
                                  "AM",
                                  style: TextStyle(
                                      color:
                                          amPm.contains('AM') ? white : blue),
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setAmPmSwitch("PM"),
                              child: Container(
                                height: 50,
                                width: 50,
                                color: amPm.contains('PM') ? blue : white,
                                child: Center(
                                    child: Text(
                                  "PM",
                                  style: TextStyle(
                                      color:
                                          amPm.contains('PM') ? white : blue),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Place of Birth"),
          ),
          TypeAheadField<LocationModelData>(
            textFieldConfiguration: TextFieldConfiguration(
              onTap: () => node!.requestFocus(),
              onEditingComplete: () {
                setState(() {
                  node!.unfocus();
                });
              },
              enableSuggestions: true,
              scrollPadding: const EdgeInsets.all(8),
              focusNode: node,
              controller: _location,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            suggestionsCallback: (pattern) async {
              List<LocationModelData> l = await relative.fetchLocation(pattern);
              log(l.length.toString());
              return l;
            },
            itemBuilder: (context, LocationModelData suggestion) {
              return ListTile(
                title: Text(suggestion.placeName!),
                // subtitle: Text(suggestion.placeId!),
              );
            },
            errorBuilder: (context, error) => Text("Error : $error"),
            loadingBuilder: (context) => const Text("Loading. . ."),
            onSuggestionSelected: (LocationModelData suggestion) {
              setState(() {
                _location.text = suggestion.placeName!;
                _birthPlace = BirthPlace();

                _birthPlace.placeId = suggestion.placeId;
                _birthPlace.placeName = suggestion.placeName;
                node!.unfocus();
              });
            },
          ),
          _birthPlace == (null)
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Please Select a city",
                    style: TextStyle(color: red, fontSize: 12),
                  ),
                )
              : const Text(""),
          !node!.hasFocus
              ? const SizedBox(
                  height: 0,
                )
              : const SizedBox(
                  height: 500,
                ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Gender"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: DropdownButtonFormField(
                            value: _gender.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Male"),
                                value: "MALE",
                              ),
                              DropdownMenuItem(
                                child: Text("Female"),
                                value: "FEMALE",
                              )
                            ],
                            onChanged: (value) {
                              _gender.text = value.toString();
                            }),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Relation"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: relations!.isEmpty
                            ? const CircularProgressIndicator()
                            : DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return 'Invalid Relation';
                                  }
                                  return null;
                                },
                                // value: _relation == (null)
                                //     ? Relations("Father", 1)
                                //     : _relation,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8)),
                                isExpanded: true,
                                items: relations!
                                    .map((Relations e) => DropdownMenuItem(
                                          child: Text(e.relation ?? ""),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: selectRelation),
                      ),
                    ],
                  ))
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BirthDetails b = BirthDetails();
                    b.dobDay = int.parse(_dd.text);
                    b.dobYear = int.parse(_yy.text);
                    b.meridiem = amPm;
                    b.tobHour = int.parse(_hh.text);
                    b.tobMin = int.parse(_min.text);
                    b.dobMonth = int.parse(_mm.text);

                    relative
                        .addNewRelative(
                            _isEditProfile,
                            b,
                            _birthPlace,
                            _name.text.split(" ").first,
                            _name.text.split(" ").last,
                            _relation.relationId!,
                            _gender.text,
                            uuid,
                            _relation.relation)
                        .then((result) => {
                              if (result["status"])
                                {
                                  clearControllers(),
                                  relative.getRelativesData(),
                                  setAddingProfile(false),
                                },
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor:
                                          result["status"] ? green : red,
                                      content: Text(result["message"])))
                            });
                  }
                },
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  void selectRelation(Relations? value) {
    setState(() {
      _relation = value!;
    });
  }
}
