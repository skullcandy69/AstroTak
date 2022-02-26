import 'dart:developer';

import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Models/location_api_model.dart';
import 'package:astrotak/Models/relatives_model.dart';
import 'package:astrotak/Services/api_services.dart';
import 'package:flutter/material.dart';

class RelativesDataProvider with ChangeNotifier {
  RelativesModel relatives = RelativesModel();
  LocationAPIModel locations = LocationAPIModel(data: []);
  bool loading = false;
  bool deleteLoader = false;
  bool error = false;
  var statusCode = {};
  ApiService apiService = ApiService();
  getRelativesData() async {
    loading = true;
    error = false;
    // notifyListeners();
    relatives = await apiService.getAllRelatives().then((value) {
      error = value.message!.contains("No relatives found") ? false : true;
      loading = false;
      notifyListeners();
      return value;
    });
  }

  deleteRelative(AllRelatives relative, BuildContext context) async {
    deleteLoader = true;
    notifyListeners();
    await apiService.deleteRelatives(relative.uuid).then((value) {
      var snackBar = SnackBar(
        content: Text(value["message"]),
        duration: const Duration(seconds: 5),
        elevation: 10,
        backgroundColor: value["httpStatusCode"] == 200 ? green : red,
      );
      if (value["httpStatusCode"] == 200) {
        getRelativesData();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
        deleteLoader = false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      deleteLoader = false;
      notifyListeners();
    });
  }

  fetchLocation(String location) async {
    locations = await apiService.getLocation(location);
    notifyListeners();
    return locations.data;
  }

  addNewRelative(
      bool _isEditProfile,
      BirthDetails _birthDetails,
      BirthPlace _birthPlace,
      String _fname,
      String _lname,
      int _rId,
      String _male,
      [String? uuid,
      String? relation]) {
    if (_isEditProfile) {
      AllRelatives r = AllRelatives();
      r.birthDetails = _birthDetails;
      r.birthPlace = _birthPlace;
      r.dateAndTimeOfBirth = _birthDetails.dobYear.toString() +
          "-" +
          _birthDetails.dobMonth.toString() +
          "-" +
          _birthDetails.dobDay.toString() +
          " " +
          _birthDetails.tobHour.toString() +
          ":" +
          _birthDetails.tobMin.toString();
      r.uuid = uuid;
      r.firstName = _fname;
      r.lastName = _lname;
      r.fullName = _fname + " " + _lname;
      r.gender = _male;
      r.relation = relation;
      r.relationId = _rId;
      r.middleName = null;
      log(r.toJson().toString());
      var result = apiService.updateRelatives(r);
      return result;
    } else {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['relationId'] = _rId;
      data['firstName'] = _fname;
      data['lastName'] = _lname;
      data['gender'] = _male;
      data['birthPlace'] = _birthPlace.toJson();
      data['birthDetails'] = _birthDetails.toJson();
      var result = apiService.addRelatives(data);
      return result;
    }
  }
}
