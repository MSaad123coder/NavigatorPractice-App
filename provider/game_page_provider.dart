import 'dart:convert'; // Lets us work with JSON data, which is how we get questions from the internet.
import 'package:flutter/material.dart'; // Tools for making user interfaces in Flutter.
import 'package:dio/dio.dart'; // A package for making web requests (like talking to an API).
import 'package:flutter_application_1/pages/game_page.dart'; // The game page where we display questions and play the game.

class GamePageProvider extends ChangeNotifier {
  // This class keeps track of game data and notifies the UI when something changes.
  List? Questions; // Stores all the questions fetched from the internet.
  int _currentQuestionCount = 0; // Keeps track of which question we are currently on.
  int _correctCount = 0; // Counts how many questions the user has answered correctly.
  final Dio _dio = Dio(); // An object to help us make requests to a web service.
  final int _maxQuestions = 10; // The total number of questions to fetch.
  final String difficultylevel; // The chosen difficulty level of the game (easy, medium, or hard).

  BuildContext context; // A reference to the current page, so we can show alerts or navigate.

  GamePageProvider({required this.context, required this.difficultylevel}) {
    // This is like the "start" function for the provider.
    _dio.options.baseUrl =
        'https://opentdb.com/api/php'; // The website we use to get questions.
    _getQuestionsFromAPI(); // Start fetching questions right after this class is created.
  }

  Future<void> _getQuestionsFromAPI() async {
    // A function to get questions from the internet.
    var _response = await _dio.get(
      // Send a GET request to the API (website).
      '',
      queryParameters: {
        'amount': 10, // Number of questions we want.
        'type': 'boolean', // Only fetch true/false questions.
        'difficulty': difficultylevel, // The difficulty level selected by the user.
      }, // These options help the API understand what we need.
    );
    var _data = jsonDecode(
      // Convert the raw API response into a format (JSON) that we can use.
      _response.toString(),
    );
    Questions = _data["results"]; // Save the list of questions from the response.
    notifyListeners(); // Notify the UI that questions are now ready.
  }

  String getCurrentQuestionText() {
    // Get the text of the current question.
    return Questions![_currentQuestionCount]["questions"];
  }

  void answerQuestion(String answer) async {
    // This is called when the player picks "True" or "False".
    bool isCorrect =
        Questions![_currentQuestionCount]["correct_answer"] == answer; // Check if the answer matches the correct answer.
    _correctCount += isCorrect ? 1 : 0; // If correct, increase the score by 1.
    _currentQuestionCount++; // Move to the next question.

    showDialog(
      // Show a popup (dialog box) to indicate whether the answer was correct or wrong.
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: isCorrect
              ? Colors.green
              : Colors.red, // Green for correct, red for wrong.
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white, // Show a checkmark or cross icon based on the result.
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(
        seconds: 1, // Wait for 1 second before closing the popup.
      ),
    );
    Navigator.pop(context); // Close the popup.

    if (_currentQuestionCount == _maxQuestions) {
      // If all questions are done...
      endgame(); // End the game.
    } else {
      notifyListeners(); // Otherwise, notify the UI to show the next question.
    }
  }

  Future<void> endgame() async {
    // This is called when the game is finished.
    showDialog(
      // Show a popup saying the game is over and display the score.
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: Colors.blueAccent, // Set a blue background.
          title: const Text(
            'Game Over', // Title text saying the game is done.
            style: TextStyle(fontSize: 25), // Large text size.
          ),
          content:
              Text('Score:$_correctCount/$_maxQuestions'), // Show the final score.
        );
      },
    );
    await Future.delayed(
      const Duration(
        seconds: 3, // Wait for 3 seconds before exiting.
      ),
    );
    Navigator.pop(context); // Close the "Game Over" popup.
    Navigator.pop(context); // Go back to the previous screen (e.g., home page).
  }
}
