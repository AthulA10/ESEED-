import 'dart:ui';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'trade.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'request.dart';
import 'package:intl/intl.dart';
import 'buy.dart';

double walletBal = 1000.0;
//var sec = int.parse(_secondString);
var count = 0;
void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatefulWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      theme: ThemeData.dark(),
      home: MyStatelessWidget(),
    );
  }
}

//final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
String temp = 'E-SEED';

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatefulWidget {
  MyStatelessWidget({Key key}) : super(key: key);
  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  int _selectedIndex = 0;
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
    _selectedIndex = 0;
    //displayVal = 0;
    //currentCharge = 70;
    unitValue = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TimeWidget(),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 50,
                  decoration: BoxDecoration(
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
                    min: 10,
                    max: 100,
                    initialValue: currentCharge,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          'TATA ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.amber, fontSize: 15),
                        ),
                        Text(
                          ' NEXON EV',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child: Image.asset(
              'assets/eseedlo(1).png',
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Text(
                            'Total Units consumed\n\n                250',
                            style: TextStyle(
                                color: Colors.yellow[600], fontSize: 15),
                          ),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Color(0x3E1D1E33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Text(
                            'Total Units Supplied\n\n                300',
                            style: TextStyle(
                                color: Colors.lightGreenAccent, fontSize: 15),
                          ),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Color(0x3E1D1E33),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 10, 20),
                          height: 100,
                          child: Text(
                            'Wallet Balance  :',
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 15,
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(15.0, 15.0, 0, 15.0),
                          decoration: BoxDecoration(
                            color: Color(0x3E1D1E33),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            '$walletBal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.cyanAccent,
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                          height: 100,
                          margin: EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
                          decoration: BoxDecoration(
                            color: Color(0x3E1D1E33),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
              //openPage(context);
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

////////////////////////////

class TimeWidget extends StatefulWidget {
  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  String _secondString;
  var sec;
  var prev_sec;
  @override
  void initState() {
    super.initState();
    prev_sec = 0;
    sec = 0;
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  //@override
  void _getTime() {
    final String secondsTime =
        DateFormat('ss').format(DateTime.now()).toString();
    setState(() {
      _secondString = secondsTime;
      sec = int.parse(_secondString);
      if ((sec - prev_sec).abs() >= 10) {
        request();
        count = 1;
      } else {
        count = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 0,
    );
  }
}
