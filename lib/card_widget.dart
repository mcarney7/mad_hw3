import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class CardWidget extends StatelessWidget {
  final int cardIndex;

  const CardWidget({Key? key, required this.cardIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardModel card = context.watch<GameProvider>().cards[cardIndex];

    return GestureDetector(
      onTap: () {
        context.read<GameProvider>().flipCard(cardIndex);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: card.isFaceUp ? Colors.white : Colors.blue,
          boxShadow: const [BoxShadow(blurRadius: 5)],
        ),
        child: Center(
          child: Text(
            card.isFaceUp ? card.content : '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
