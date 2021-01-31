import 'dart:ui';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'trade.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

double unitValue;
void sellJson() async {
  String slaveip = 'http://192.168.0.184/update';

  final http.Response response = await http.post(
    slaveip,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'cmd': '2',
      'unit': '$unitValue',
    }),
  );

  if (response.statusCode == 200) {
    print('successful with unitvalue $unitValue');
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    //return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get response from server');
  }
}

void main() => runApp(buypage());
double displayVal;
double currentCharge = 70; //venel zero akam

/// This is the main application widget.
class buypage extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData.dark(),
      home: MyStatelessWidget(),
    );
  }
}

double _currentSliderValue = 20;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
String temp = 'E-SEED';

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatefulWidget {
  MyStatelessWidget({Key key}) : super(key: key);
  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  int _selectedIndex;
  double rateValue;
  double creditValue;

  void navig(int index) {
    if (index == 1) {
      setState(() {
        _selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => tradeRoute()),
        );
      });
    } else {
      setState(() {
        _selectedIndex = index; //aadhyam preshnam kandu...nottapulli
      });
    }
  }

  @override
  void initState() {
    _selectedIndex = 1;
    rateValue = 7;
    creditValue = 0;
    // displayVal = 0;
    //currentCharge = 70;
    unitValue = 0;
    setState(() {
      _currentSliderValue = currentCharge;
    });
  }

  @override
  Widget build(BuildContext context) {
    unitValue = currentCharge - _currentSliderValue.round();
    creditValue = unitValue * rateValue;
    displayVal = 0.0 + _currentSliderValue.round();

    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0x3E1D1E33),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 25),
                      size: 205,
                      customColors: CustomSliderColors(),
                      infoProperties: InfoProperties(
                        mainLabelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                        bottomLabelText: 'Battery',
                      ),
                    ),
                    min: 0,
                    max: 100,
                    initialValue: currentCharge,
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child: Column(
              children: [
                Text(
                  '% Charge To Be Retained: $displayVal',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber[300], fontSize: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        activeColor: Colors.tealAccent,
                        value: _currentSliderValue,
                        min: 0,
                        max: currentCharge,
                        divisions: 100,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Selected No of Units :',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    Text(
                      '  $unitValue',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Rate per Unit :',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    Text(
                      '  $rateValue',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Credit Amount:',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    Text(
                      '  $creditValue Rupees',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Text(
                  'Proceed to \n       Sell',
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.green,
                onPressed: sellJson,
              ),
              margin: EdgeInsets.all(75.0),
              decoration: BoxDecoration(
                color: Color(0x3E1D1E33),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "$temp",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Next page',
            onPressed: () {
              // Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'My Car',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Trade',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: navig,
      ),
    );
  }
}
