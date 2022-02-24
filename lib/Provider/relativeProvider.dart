import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Models/locationAPIModel.dart';
import 'package:astrotak/Models/relativesModel.dart';
import 'package:astrotak/Services/ApiService.dart';
import 'package:flutter/material.dart';

class RelativesDataProvider with ChangeNotifier {
  RelativesModel relatives = RelativesModel();
  LocationAPIModel locations = LocationAPIModel();
  bool loading = false;
  bool deleteLoader = false;
  var statusCode = {};
  ApiService apiService = ApiService();
  getRelativesData() async {
    loading = true;
    relatives = await apiService.getAllRelatives();
    loading = false;
    notifyListeners();
  }

  deleteRelative(AllRelatives relative, BuildContext context) async {
    deleteLoader = true;
    notifyListeners();
    statusCode = await apiService.deleteRelatives(relative.uuid);
    var snackBar = SnackBar(
      content: Text(statusCode["message"]),
      duration: const Duration(seconds: 5),
      elevation: 10,
      backgroundColor: statusCode["httpStatusCode"] == 200 ? green : red,
    );
    if (statusCode["httpStatusCode"] == 200) {
      getRelativesData();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    deleteLoader = false;
    notifyListeners();
  }

  fetchLocation(String location) async {
    locations = await apiService.getLocation(location);
    notifyListeners();
    return locations;
  }
}
