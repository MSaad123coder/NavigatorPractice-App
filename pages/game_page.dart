import 'package:flutter/material.dart'; // Brings tools to design how the app looks.
import 'package:flutter_application_1/provider/game_page_provider.dart'; // Gets help to handle game data.
import 'package:provider/provider.dart'; // Lets parts of the app share info.

class GamePage extends StatelessWidget {
  final String difficultylevel; // Stores how hard the game is.
  double? _deviceHeight,
      _deviceWidth; // Stores the phone's screen height and width.
  GamePageProvider? _pageProvider; // Helps control the game page.

  GamePage(
      {required this.difficultylevel}); // Takes difficulty level when this screen is created.

  @override
  Widget build(BuildContext context) {
    // Creates the screen layout.
    _deviceHeight =
        MediaQuery.of(context).size.height; // Gets the phone's height.
    _deviceWidth = MediaQuery.of(context).size.width; // Gets the phone's width.

    return ChangeNotifierProvider(
      // Allows app to track game data changes.
      create: (_context) => GamePageProvider(
        context: context,
        difficultylevel: difficultylevel, // Gives difficulty to the helper.
      ),
      child: _buildUI(), // Builds the game's look.
    );
  }

  Widget _buildUI() {
    // Decides how everything looks.
    return Builder(
      builder: (_context) {
        // Listens for updates.
        _pageProvider =
            _context.watch<GamePageProvider>(); // Connects to game data.
        if (_pageProvider!.Questions != null) {
          // If game questions are ready.
          return Scaffold(
            // Prepares the screen's basic look.
            body: SafeArea(
              // Avoids edges of the phone screen.
              child: Container(
                // Holds all the game items.
                padding: EdgeInsets.symmetric(
                    horizontal: _deviceHeight! * 0.05), // Adds side padding.
                child: _gameUI(), // Draws the main game parts.
              ),
            ),
          );
        } else {
          // If questions are not ready yet.
          return Center(
            // Shows a loading spinner in the center.
            child: Container(
              child: CircularProgressIndicator(), // Spinning loading icon.
              color: Colors.black, // Black background.
            ),
          );
        }
      },
    );
  }

  Widget _gameUI() {
    // Adds main game content like question and buttons.
    return Column(
      // Organizes content vertically.
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Spaces items equally.
      mainAxisSize: MainAxisSize.max, // Takes all available space.
      crossAxisAlignment: CrossAxisAlignment.center, // Centers items.
      children: [
        _QuestionText(), // Displays the question.
        Column(
          // Holds the answer buttons.
          children: [
            _TrueButton(), // True button.
            SizedBox(height: _deviceHeight! * 0.01), // Adds small gap.
            _FalseButton(), // False button.
          ],
        ),
      ],
    );
  }

  Widget _QuestionText() {
    // Displays the question text.
    return Text(
      _pageProvider!.getCurrentQuestionText(), // Gets and shows the question.
      style: const TextStyle(
          color: Colors.white, // Text color is white.
          fontSize: 25, // Text size is 25.
          fontWeight: FontWeight.w400), // Normal weight for text.
    );
  }

  Widget _TrueButton() {
    // Creates the "True" answer button.
    return MaterialButton(
      // Adds button style.
      onPressed: () {
        _pageProvider?.answerQuestion("True"); // Handles "True" answer.
      },
      color: const Color.fromARGB(255, 3, 70, 5), // Green button color.
      minWidth: _deviceHeight! * 0.80, // Button width.
      height: _deviceHeight! * 0.10, // Button height.
      child: const Text(
        "True", // Button label.
        style: TextStyle(fontSize: 25), // Text size.
      ),
    );
  }

  Widget _FalseButton() {
    // Creates the "False" answer button.
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("False"); // Handles "False" answer.
      },
      color: const Color.fromARGB(255, 87, 3, 3), // Red button color.
      minWidth: _deviceHeight! * 0.80, // Button width.
      height: _deviceHeight! * 0.10, // Button height.
      child: const Text(
        "False", // Button label.
        style: TextStyle(fontSize: 25), // Text size.
      ),
    );
  }
}
