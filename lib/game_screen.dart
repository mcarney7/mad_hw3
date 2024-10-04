// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management
import 'game_provider.dart';             // Importing GameProvider
import 'card_widget.dart';               // Importing the CardWidget

// The main game screen widget
class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar at the top of the screen
      appBar: AppBar(
        title: const Text('Card Matching Game'), // Title of the app
        actions: [
          // IconButton to reset the game
          IconButton(
            onPressed: () {
              // Calls the resetGame method in GameProvider when pressed
              Provider.of<GameProvider>(context, listen: false).resetGame();
            },
            icon: const Icon(Icons.restart_alt), // Icon for the reset button
          ),
        ],
      ),
      // Body of the screen containing the scoreboard and the card grid
      body: Column(
        children: [
          // Padding around the scoreboard
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: ScoreBoard(), // Displays the score and victory message
          ),
          // Expanded widget to fill the remaining space with the card grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const CardGrid(), // The grid of cards
            ),
          ),
        ],
      ),
    );
  }
}

// Widget to display the score and victory message
class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int score = context.watch<GameProvider>().score;                // Retrieves the current score
    String victoryMessage = context.watch<GameProvider>().victoryMessage; // Retrieves the victory message
    return Column(
      children: [
        // Text widget to display the score
        Text(
          'Score: $score',
          style: const TextStyle(fontSize: 24), // Styling the text
        ),
        // If there is a victory message, display it
        if (victoryMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              victoryMessage,
              style: const TextStyle(fontSize: 18, color: Colors.green), // Styling the victory message
            ),
          ),
      ],
    );
  }
}

// Widget to create the grid of cards
class CardGrid extends StatelessWidget {
  const CardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CardModel> cards = context.watch<GameProvider>().cards; // Retrieves the list of cards

    // GridView.builder to build the grid dynamically based on the number of cards
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,     // Number of cards per row
        mainAxisSpacing: 4.0,  // Vertical spacing between cards
        crossAxisSpacing: 4.0, // Horizontal spacing between cards
      ),
      itemCount: cards.length, // Total number of cards
      itemBuilder: (context, index) {
        // Builds a CardWidget for each card in the list
        return CardWidget(cardIndex: index);
      },
    );
  }
}
