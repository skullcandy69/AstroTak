import 'dart:convert';
import 'dart:developer';
import 'package:astrotak/Constants/apis.dart';
import 'package:astrotak/Models/ask_questions_model.dart';
import 'package:astrotak/Models/location_api_model.dart';
import 'package:astrotak/Models/relatives_model.dart';
import 'package:flutter/material.dart';
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
        Uri.parse(getRelative + "?pageSize=100"),
        headers: {"Authorization": token},
      );
      log(response.body);
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

  addRelatives(Map<String, dynamic> data) async {
    try {
      final response = await http.post(Uri.parse(addRelative),
          headers: {"Authorization": token, "Content-Type": "application/json"},
          body: jsonEncode(data));
      log(response.body);
      final item = json.decode(response.body);
      if (response.statusCode == 200) {
        return {"status": true, "message": item['message']};
      } else {
        log(response.body);
        return {"status": false, "message": item['message']};
      }
    } catch (e) {
      log(e.toString());
      return {
        "status": false,
        "message": "Some error try again after some time"
      };
    }
  }

  updateRelatives(AllRelatives r) async {
    try {
      final response = await http.post(Uri.parse(updateRelative + r.uuid!),
          headers: {"Authorization": token, "Content-Type": "application/json"},
          body: jsonEncode(r));
      log(response.body);
      final item = json.decode(response.body);
      if (response.statusCode == 200) {
        return {"status": true, "message": item['message']};
      } else {
        log(response.body);
        return {"status": false, "message": item['message']};
      }
    } catch (e) {
      log(e.toString());
      return {
        "status": false,
        "message": "Some error try again after some time"
      };
    }
  }

  Future<LocationAPIModel> getLocation(String query) async {
    LocationAPIModel result = LocationAPIModel(data: []);
    // if(query.isEmpty){
    //   query='a';
    // }
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

      return json.decode(response.body);
    } catch (e) {
      log(e.toString());
    }
  }
}
