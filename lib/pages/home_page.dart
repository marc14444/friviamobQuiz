import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;

  double _currentDifficultyLevel = 0;

  final List<String> _difficultyTexts = ["Easy", "Medium", "Hard"];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _appTitle(), 
                _difficultySlider(), 
                _startGameButton()
                ]
          ),
        ),
      )),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        const Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficultyTexts[_currentDifficultyLevel.toInt()],
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
      label: "Difficulty",
      value: _currentDifficultyLevel,
      min: 0,
      max: 2,
      divisions: 3,
      onChanged: (double value) {
        setState(() {
          _currentDifficultyLevel = value;
          print(_currentDifficultyLevel);
        });
      },
    );
  }
  Widget _startGameButton(){
    return MaterialButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext _context){
        return GamePage(
          difficultyLevel: 
            _difficultyTexts[_currentDifficultyLevel.toInt()].toLowerCase());
      }
      ),
      );
    },
    color: Colors.blue,
    minWidth: _deviceWidth! * 0.80,
    height: _deviceHeight! * 0.10,
    padding: EdgeInsets.all(10),
    child: Text(
      "Start Game",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      )); 
  }
}
