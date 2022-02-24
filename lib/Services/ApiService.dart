import 'dart:convert';
import 'dart:developer';
import 'package:astrotak/Constants/apis.dart';
import 'package:astrotak/Models/askQuestionsModel.dart';
import 'package:astrotak/Models/locationAPIModel.dart';
import 'package:astrotak/Models/relativesModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<AskQuestionModel> getAllQuestions() async {
    AskQuestionModel result = AskQuestionModel();
    try {
      final response = await http.get(
        Uri.parse(getQuestions),
        // headers: {
        //   HttpHeaders.contentTypeHeader: "application/json",
        // },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = AskQuestionModel.fromJson(item);
        return result;
      } else {
        log("Some error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<RelativesModel> getAllRelatives() async {
    RelativesModel result = RelativesModel();
    try {
      final response = await http.get(
        Uri.parse(getRelative),
        headers: {"Authorization": token},
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = RelativesModel.fromJson(item);
        return result;
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<LocationAPIModel> getLocation(String query) async {
    LocationAPIModel result = LocationAPIModel();
    if(query.isEmpty){
      query='a';
    }
    try {
      final response = await http.get(
        Uri.parse(getLocations + query),
        headers: {"Authorization": token},
      );
      log(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = LocationAPIModel.fromJson(item);
        return result;
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  deleteRelatives(String? uuid) async {
    try {
      final response = await http.post(
        Uri.parse(deleteRelative + uuid!),
        headers: {"Authorization": token},
      );
      log(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
      } else {
        log(response.body);
      }
      return json.decode(response.body);
    } catch (e) {
      log(e.toString());
    }
  }
}
