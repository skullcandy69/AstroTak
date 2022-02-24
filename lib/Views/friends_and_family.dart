import 'dart:developer';

import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Models/locationAPIModel.dart';
import 'package:astrotak/Models/relativesModel.dart';
import 'package:astrotak/Provider/relativeProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';

class FriendsAndFamily extends StatefulWidget {
  const FriendsAndFamily({Key? key}) : super(key: key);

  @override
  State<FriendsAndFamily> createState() => _FriendsAndFamilyState();
}

class _FriendsAndFamilyState extends State<FriendsAndFamily> {
  @override
  void initState() {
    super.initState();
    final queProv = Provider.of<RelativesDataProvider>(context, listen: false);
    queProv.getRelativesData();
  }

  bool addingProfile = false;
  bool _isEditProfile = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<AutoCompleteTextFieldState<LocationModelData>> key = GlobalKey();
  TextEditingController _name = TextEditingController();
  TextEditingController _location = TextEditingController(text: "delhi");
  TextEditingController _dd = TextEditingController();
  TextEditingController _mm = TextEditingController();
  TextEditingController _yy = TextEditingController();
  TextEditingController _hh = TextEditingController();
  TextEditingController _min = TextEditingController();
  TextEditingController _pob = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _relation = TextEditingController();
List<LocationModelData> a=[];
  preFillUser(AllRelatives relative) {
    _name.text = relative.fullName!;
    _pob.text = relative.birthPlace!.placeName!;
    _gender.text = relative.gender!;
    _relation.text = relative.relation!;
  }

  setAddingProfile(_edit) {
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
        child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: addingProfile
                ? addNewProfile(_isEditProfile,relatives)
                : relativeProfile(relatives)),
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
        relatives.relatives.data == null
            ? const Text("No Data Present")
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                child: DataTable(
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
                  columnSpacing: 10,
                  showBottomBorder: true,
                  dividerThickness: 5,
                  rows: List<DataRow>.generate(
                    relatives.relatives.data!.allRelatives!.length,
                    (int index) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(relatives.relatives.data!
                                .allRelatives![index].firstName ??
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
                              preFillUser(relatives
                                  .relatives.data!.allRelatives![index]);
                            },
                            icon: const Icon(Icons.edit))),
                        DataCell(IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                                      style: TextStyle(
                                                          color: white),
                                                    )),
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("No",
                                                    style: TextStyle(
                                                        color: white)))
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
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () => setAddingProfile(false),
            child: const Text(
              "+Add New Profile",
              style: TextStyle(color: white),
            ),
          ),
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
                return 'Please enter some text';
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
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    maxLength: 2,
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
                    child: Switch(value: true, onChanged: (_) => () {}),
                  )),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Place of Birth"),
          ),
          // FutureBuilder<dynamic>(
              // future: relative.fetchLocation(_location.text),
              // builder: (context, AsyncSnapshot<dynamic> location) {
                 AutoCompleteTextField(
                  itemSubmitted: (LocationModelData item) {
                    // setState(() {
                    //   _location.text = item.placeName!;
                    // });
                  },
                  key: key,
                  controller: _location,
                  suggestions: relative.locations.data! ,
                  textChanged: (data) => {
                    debugPrint(data),
                    relative.fetchLocation(data)},
                  itemBuilder: (context, LocationModelData item) {
                    // ui for the autocompelete row
                    return SizedBox(height: 30, child: Text(item.placeName!));
                  },
                  itemFilter: (LocationModelData item, query) {
                    return item.placeName!
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (LocationModelData a, LocationModelData b) {
                    return a.placeName!.compareTo(b.placeName!);
                  },
                ),
              // }),
          // TextFormField(
          //   controller: _pob,
          //   decoration: InputDecoration(
          //     floatingLabelBehavior: FloatingLabelBehavior.always,
          //     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          //     border:
          //         OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          //   ),
          // ),
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
                            value: 'Male',
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Male"),
                                value: "Male",
                              ),
                              DropdownMenuItem(
                                child: Text("Female"),
                                value: "Female",
                              )
                            ],
                            onChanged: (value) {}),
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
                        child: DropdownButtonFormField(
                            value: 'Father',
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Father"),
                                value: "Father",
                              ),
                              DropdownMenuItem(
                                child: Text("Sister"),
                                value: "Sister",
                              ),
                              DropdownMenuItem(
                                child: Text("Brother"),
                                value: "Brother",
                              )
                            ],
                            onChanged: (value) {}),
                      ),
                    ],
                  ))
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () => setAddingProfile(false),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
