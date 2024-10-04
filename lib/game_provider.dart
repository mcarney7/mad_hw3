// Importing necessary packages
import 'package:flutter/material.dart';
import 'dart:math'; // For generating random numbers (used in shuffling the cards)

// The data model for each card in the game
class CardModel {
  final String content; // The content displayed on the front of the card
  bool isFaceUp;        // Indicates if the card is currently face-up
  bool isMatched;       // Indicates if the card has been matched with its pair

  // Constructor for CardModel
  CardModel({required this.content, this.isFaceUp = false, this.isMatched = false});
}

// The provider class that manages the state and logic of the game
class GameProvider extends ChangeNotifier {
  // List of all cards in the game
  List<CardModel> _cards = [];
  int _flippedCardsCount = 0; // Number of cards currently flipped face-up
  int _score = 0;             // Player's score (number of matched pairs)
  int _moves = 0;             // Number of moves made by the player
  String _victoryMessage = ''; // Message displayed upon winning
  bool _isGameOver = false;   // Indicates if the game is over

  // Getters to access private variables outside this class
  List<CardModel> get cards => _cards;
  int get score => _score;
  String get victoryMessage => _victoryMessage;
  bool get isGameOver => _isGameOver;

  // Constructor for GameProvider
  GameProvider() {
    _initializeGame(); // Initializes the game when an instance is created
  }

  // Method to initialize or reset the game
  void _initializeGame() {
    _flippedCardsCount = 0;
    _score = 0;
    _moves = 0;
    _isGameOver = false;
    _victoryMessage = '';

    List<String> cardContents = _generateCardContent(); // Generate card contents
    // Create CardModel instances for each content and add to the list
    _cards = cardContents.map((content) => CardModel(content: content)).toList();
    _cards.shuffle(Random()); // Shuffle the cards to randomize their positions
    notifyListeners(); // Notify listeners to update the UI
  }

  // Generates a list of card contents (pairs of letters)
  List<String> _generateCardContent() {
    List<String> baseCards = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    // Duplicate the list to create pairs and return the combined list
    return List<String>.from(baseCards)..addAll(baseCards);
  }

  // Method to handle the logic when a card is flipped
  void flipCard(int index) {
    // If the card is already matched, face-up, or two cards are already face-up, do nothing
    if (_cards[index].isMatched || _cards[index].isFaceUp || _flippedCardsCount == 2) {
      return;
    }

    _cards[index].isFaceUp = true; // Flip the card face-up
    _flippedCardsCount++;          // Increment the count of face-up cards
    notifyListeners();             // Update the UI

    // If two cards are face-up, check for a match
    if (_flippedCardsCount == 2) {
      _checkForMatch();
    }
  }

  // Method to check if the two face-up cards match
  void _checkForMatch() async {
    _moves++; // Increment the number of moves made
    await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second before checking

    List<int> faceUpIndices = []; // List to hold indices of face-up cards
    for (int i = 0; i < _cards.length; i++) {
      if (_cards[i].isFaceUp && !_cards[i].isMatched) {
        faceUpIndices.add(i);
      }
    }

    // If two face-up cards have the same content, mark them as matched
    if (faceUpIndices.length == 2 && _cards[faceUpIndices[0]].content == _cards[faceUpIndices[1]].content) {
      _cards[faceUpIndices[0]].isMatched = true;
      _cards[faceUpIndices[1]].isMatched = true;
      _score++; // Increment the score for a successful match
    }

    // Flip back any unmatched cards
    for (int i = 0; i < _cards.length; i++) {
      if (!_cards[i].isMatched) {
        _cards[i].isFaceUp = false;
      }
    }
    _flippedCardsCount = 0; // Reset the count of face-up cards

    // Check if all pairs have been matched to determine if the game is over
    if (_checkGameOver()) {
      _isGameOver = true;
      _victoryMessage = "You Win! Total Moves: $_moves"; // Set the victory message
    }
    notifyListeners(); // Update the UI
  }

  // Method to check if all cards have been matched
  bool _checkGameOver() {
    return _cards.every((card) => card.isMatched); // Returns true if all cards are matched
  }

  // Method to reset the game
  void resetGame() {
    _initializeGame(); // Re-initialize the game variables and cards
  }
}
