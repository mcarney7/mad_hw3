// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management
import 'game_provider.dart';             // Importing GameProvider

// Widget that represents an individual card in the grid
class CardWidget extends StatelessWidget {
  final int cardIndex; // The index of the card in the list

  const CardWidget({Key? key, required this.cardIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieves the specific card from the GameProvider using the index
    CardModel card = context.watch<GameProvider>().cards[cardIndex];

    return GestureDetector(
      // When the card is tapped, call the flipCard method in GameProvider
      onTap: () {
        context.read<GameProvider>().flipCard(cardIndex);
      },
      // AnimatedContainer to provide the flip animation effect
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400), // Duration of the flip animation
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),    // Rounded corners for the card
          color: card.isFaceUp ? Colors.white : Colors.transparent, // Card color based on face-up or face-down
          boxShadow: const [BoxShadow(blurRadius: 5)], // Adds a shadow effect
        ),
        // Center widget to center the content inside the card
        child: Center(
          child: card.isFaceUp
              // If the card is face-up, display its content
              ? Text(
                  card.content, // The content of the card (e.g., 'A', 'B', etc.)
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Styling the text
                )
              // If the card is face-down, display the back design image
              : Image.asset('assets/card_back.png'), // Path to the card back image
        ),
      ),
    );
  }
}
