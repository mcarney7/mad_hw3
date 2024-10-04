import 'package:flutter/material.dart';
import 'dart:math';

class CardModel {
  final String content;
  bool isFaceUp;
  bool isMatched;

  CardModel({required this.content, this.isFaceUp = false, this.isMatched = false});
}

class GameProvider extends ChangeNotifier {
  List<CardModel> _cards = [];
  int _flippedCardsCount = 0;
  int _score = 0;
  int _moves = 0;
  String _victoryMessage = '';
  bool _isGameOver = false;

  List<CardModel> get cards => _cards;
  int get score => _score;
  String get victoryMessage => _victoryMessage;
  bool get isGameOver => _isGameOver;

  GameProvider() {
    _initializeGame();
  }

  void _initializeGame() {
    _flippedCardsCount = 0;
    _score = 0;
    _moves = 0;
    _isGameOver = false;
    _victoryMessage = '';

    List<String> cardContents = _generateCardContent();
    _cards = cardContents.map((content) => CardModel(content: content)).toList();
    _cards.shuffle(Random());
    notifyListeners();
  }

  List<String> _generateCardContent() {
    List<String> baseCards = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    return List<String>.from(baseCards)..addAll(baseCards); 
  }

  void flipCard(int index) {
    if (_cards[index].isMatched || _cards[index].isFaceUp || _flippedCardsCount == 2) {
      return; 
    }

    _cards[index].isFaceUp = true;
    _flippedCardsCount++;
    notifyListeners();

    if (_flippedCardsCount == 2) {
      _checkForMatch();
    }
  }

  void _checkForMatch() async {
    _moves++;
    await Future.delayed(const Duration(seconds: 1));
    List<int> faceUpIndices = [];
    for (int i = 0; i < _cards.length; i++) {
      if (_cards[i].isFaceUp && !_cards[i].isMatched) {
        faceUpIndices.add(i);
      }
    }

    if (faceUpIndices.length == 2 && _cards[faceUpIndices[0]].content == _cards[faceUpIndices[1]].content) {
      _cards[faceUpIndices[0]].isMatched = true;
      _cards[faceUpIndices[1]].isMatched = true;
      _score++;
    }

    for (int i = 0; i < _cards.length; i++) {
      if (!_cards[i].isMatched) {
        _cards[i].isFaceUp = false;
      }
    }
    _flippedCardsCount = 0;

    if (_checkGameOver()) {
      _isGameOver = true;
      _victoryMessage = "You Win! Total Moves: $_moves";
    }
    notifyListeners();
  }

  bool _checkGameOver() {
    return _cards.every((card) => card.isMatched);
  }

  void resetGame() {
    _initializeGame();
  }
}
