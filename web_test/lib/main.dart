import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = "Ideal Weight Calculator";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IdealWeightFrontPage(),
      routes: {'/Result': (context) => Scaffold(body: Column(children: [Text("Some Text",), FlatButton(child: Text("Go Back",),
        onPressed: (){ Navigator.pop(context); },)],))},
    );
  }
}

class IdealWeightFrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(backgroundColor: Colors.purpleAccent[100],
      drawer: Drawer(),
      appBar: AppBar(title: Text("Ideal Weight Calculator"), leading: Icon(Icons.android),),
      body: CalculatorInterface(),
    );
  }
}

class CalculatorInterface extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalculatorInterfaceState();
  }
}

enum Gender { Male, Female, }
enum Formula { Robinson, Miller, Hamwi, Devine}

class CalculatorInterfaceState extends State<CalculatorInterface> {
  final _headingStyle = TextStyle(color: Colors.white, fontSize: 24);
  final _subheadingStyle = TextStyle(color: Colors.deepPurple, fontSize: 20);
  double _sliderValue = 175;
  static const _sliderMin = 100.0;
  static const _sliderMax = 250.0;
  var _heightText = "1 meter and 75 centimeters";
  var _genderText = "Please Select Your Gender";
  Gender _gender = Gender.Male;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return ListView(
      children: [
        Center(child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
              child: Container(child: Text("Please Select Your Height", style: _headingStyle,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              child: Container(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(padding: EdgeInsets.only(left: 4),child: IconButton(padding: const EdgeInsets.all(2), iconSize: 36.0, onPressed: decreaseValue, icon: Icon(Icons.arrow_left, color: Colors.purple,),)),
                  Flexible(
                    flex: 1,
                    child: Slider(
                      value: _sliderValue, min: _sliderMin, max: _sliderMax, divisions: 150,
                      onChanged: slide,
                    ),
                  ),
                  Container(padding: EdgeInsets.only(right: 4),child: IconButton(padding: const EdgeInsets.all(2), iconSize: 36.0, onPressed: increaseValue, icon: Icon(Icons.arrow_right, color: Colors.purple),)),
                ],
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: Text(_heightText, style: _subheadingStyle,),
            ),
          ],
        ),
        ),
        Divider(color: Colors.deepPurple, thickness: 2,),
        Center(child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Text(_genderText, style: _headingStyle,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: IntrinsicWidth(child: RadioListTile<Gender>(title : Text("Male"), groupValue: _gender, value: Gender.Male, onChanged: selectGender,)),
                  ),
                  Container(
                    child: IntrinsicWidth(child: RadioListTile<Gender>(title : Text("Female"), groupValue: _gender, value: Gender.Female, onChanged: selectGender,)),
                  ),
                ],
              ),
            ), ],
        ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(child: Text("Press the button",) ,onPressed: () { Navigator.pushNamed(context, '/Result'); },),
          ),
        )
      ],
    );
  }
  void slide (double v) {
    setState(() {
      _sliderValue = v;
      int i = _sliderValue.toInt();
      int j = i ~/ 100;
      String s;
      s = j.toString();
      j > 1 ? s += " meters": s += " meter";

      i = _sliderValue.toInt() % 100;

      //i == 1 ? s += " centimeter" : s += " centimeters";
      if (i == 1) { s = s + " and " + i.toString() + " centimeter"; }
      else if (i > 1) { s = s + " and " + i.toString() + " centimeters"; }

      _heightText = s;
    });
  }
  void increaseValue() {
    setState(() {

      if (_sliderValue < _sliderMax) {
        _sliderValue += 1.0;
        slide(_sliderValue);
      }
    });
  }

  void decreaseValue() {
    setState(() {

      if (_sliderValue > _sliderMin) {
        _sliderValue -= 1.0;
        slide(_sliderValue);
      }
    });
  }

  void selectGender(Gender g) {
    setState(() {
      _gender = g;
    });
  }

}