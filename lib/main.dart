// Importing the necessary packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management
import 'game_provider.dart'; // Importing the GameProvider class
import 'game_screen.dart';   // Importing the GameScreen widget

// The main function is the entry point of the Flutter app
void main() {
  runApp(const CardMatchingGame()); // Running the CardMatchingGame widget
}

// The root widget of the application
class CardMatchingGame extends StatelessWidget {
  const CardMatchingGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using ChangeNotifierProvider to provide the GameProvider to the widget tree
    return ChangeNotifierProvider(
      create: (context) => GameProvider(), // Creating an instance of GameProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Hides the debug banner
        title: 'Card Matching Game',       // Title of the app
        theme: ThemeData(
          primarySwatch: Colors.blue,      // Setting the primary color theme
        ),
        home: const GameScreen(),          // Setting the home screen to GameScreen
      ),
    );
  }
}
