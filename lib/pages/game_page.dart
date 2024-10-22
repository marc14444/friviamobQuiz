import 'package:flutter/material.dart';
import 'package:friviaa/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final String difficultyLevel; // Champ final correctement défini

  // Constructeur correctement déclaré
  GamePage({required this.difficultyLevel}); 

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
        context: context,
        difficultyLevel: difficultyLevel,
      ),
      child: _buildUI(deviceHeight, deviceWidth),
    );
  }

  Widget _buildUI(double deviceHeight, double deviceWidth) {
    return Builder(
      builder: (context) {
        final pageProvider = context.watch<GamePageProvider>();

        if (pageProvider.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                child: _gameUI(pageProvider, deviceHeight, deviceWidth),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
      },
    );
  }

  Widget _gameUI(GamePageProvider pageProvider, double deviceHeight, double deviceWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(pageProvider),
        Column(
          children: [
            _trueButton(pageProvider, deviceWidth, deviceHeight),
            SizedBox(height: deviceHeight * 0.01),
            _falseButton(pageProvider, deviceWidth, deviceHeight),
          ],
        ),
      ],
    );
  }

  Widget _questionText(GamePageProvider pageProvider) {
    return Text(
      pageProvider.getCurrentQuestiontext(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButton(GamePageProvider pageProvider, double deviceWidth, double deviceHeight) {
    return MaterialButton(
      onPressed: () => pageProvider.answerQuestion("True"),
      color: Colors.green,
      minWidth: deviceWidth * 0.80,
      height: deviceHeight * 0.10,
      child: const Text(
        "True",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _falseButton(GamePageProvider pageProvider, double deviceWidth, double deviceHeight) {
    return MaterialButton(
      onPressed: () => pageProvider.answerQuestion("False"),
      color: Colors.red,
      minWidth: deviceWidth * 0.80,
      height: deviceHeight * 0.10,
      child: const Text(
        "False",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
