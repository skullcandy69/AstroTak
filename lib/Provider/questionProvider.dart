import 'package:astrotak/Models/askQuestionsModel.dart';
import 'package:astrotak/Services/ApiService.dart';
import 'package:flutter/foundation.dart';

class QuestionDataProvider with ChangeNotifier {
  AskQuestionModel questions = AskQuestionModel();
  bool loading = false;
  ApiService apiService = ApiService();
  AskModelData isSelected = AskModelData("Work1");
  getQuestionData() async {
    loading = true;
    questions = await apiService.getAllQuestions();
    loading = false;
    isSelected =questions.data!.first;
    notifyListeners();
  }
  selectQuestion(value) async {
    isSelected =value;
    notifyListeners();
  }
}
