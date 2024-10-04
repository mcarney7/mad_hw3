import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'card_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Matching Game'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).resetGame();
            },
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: ScoreBoard(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const CardGrid(),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int score = context.watch<GameProvider>().score;
    String victoryMessage = context.watch<GameProvider>().victoryMessage;
    return Column(
      children: [
        Text(
          'Score: $score',
          style: const TextStyle(fontSize: 24),
        ),
        if (victoryMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              victoryMessage,
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
          ),
      ],
    );
  }
}

class CardGrid extends StatelessWidget {
  const CardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CardModel> cards = context.watch<GameProvider>().cards;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4x4 grid
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardWidget(cardIndex: index);
      },
    );
  }
}
