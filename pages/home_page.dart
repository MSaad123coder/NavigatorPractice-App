import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/game_page.dart';

// Main HomePage widget that allows difficulty selection and starts the game.
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

// The state for HomePage, containing the UI logic.
class _HomePageState extends State<HomePage> {
  double? _deviceHeight,
      _deviceWidth; // Stores the device's height and width dynamically.
  double? _currentDifficultyLevel =
      0; // Current selected difficulty level, default to 0 (easy).
  final List<String> _difficultyTexts = [
    "easy",
    "medium",
    "hard"
  ]; // Possible difficulty levels.

  @override
  Widget build(BuildContext context) {
    // Capture the height and width of the user's device.
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        // Padding the content for better responsiveness on various devices.
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
          child: Center(
            // Centering the column containing title, slider, and start button.
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Space between widgets.
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Align widgets to the center.
              mainAxisSize:
                  MainAxisSize.max, // Column will take maximum available space.
              children: [
                _appTitle(), // App title and difficulty text.
                _difficultyslider(), // Difficulty slider.
                _startGameButton(), // Button to navigate to the GamePage.
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for the app's title and currently selected difficulty.
  Widget _appTitle() {
    return Column(
      children: [
        const Text(
          "Frivia", // App name.
          style: TextStyle(
            color: Colors.white,
            fontSize: 50, // Large font size for the title.
            fontWeight: FontWeight.w500, // Medium font weight.
          ),
        ),
        Text(
          _difficultyTexts[
              _currentDifficultyLevel!.toInt()], // Show current difficulty.
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20, // Smaller font size for the difficulty text.
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Widget for the slider to adjust the difficulty.
  Widget _difficultyslider() {
    return Slider(
      label: "difficulty", // Slider label.
      min: 0, // Minimum slider value corresponds to "easy".
      max: 2, // Maximum slider value corresponds to "hard".
      divisions: 2, // Three steps: 0, 1, and 2.
      value: _currentDifficultyLevel ?? 0.0, // Slider's current value.
      onChanged: (_value) {
        setState(() {
          _currentDifficultyLevel =
              _value; // Update difficulty when slider moves.
        });
      },
    );
  }

  // Widget for the Start button to navigate to GamePage.
  Widget _startGameButton() {
    return MaterialButton(
      onPressed: () {
        // Navigate to GamePage with selected difficulty.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return GamePage(
              difficultylevel:
                  _difficultyTexts[_currentDifficultyLevel!.toInt()]
                      .toLowerCase(), // Pass the difficulty as a string.
            );
          }),
        );
      },
      color: Colors.red, // Button background color.
      minWidth: _deviceWidth! * 0.80, // Button width relative to screen width.
      height: _deviceHeight! * 0.10, // Button height relative to screen height.
      child: const Text(
        "Start", // Button text.
        style: TextStyle(
          color: Colors.white,
          fontSize: 25, // Font size for the button text.
        ),
      ),
    );
  }
}

