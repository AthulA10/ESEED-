import 'dart:ui';

import 'package:flutter/material.dart';
import 'trade.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Expanded(
                    child: Image.asset(
                      'assets/eseedlo(1).png',
                    ),
                  ),
                  width: 200,
                  height: 100,
                ),
                Container(
                  child: Expanded(
                    child: Text('E CAR',
                        style: TextStyle(fontSize: 40),
                        textAlign: TextAlign.center),
                  ),
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            SizedBox(
              height: 200,
            ),
            Row(children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/eseedlo(1).png',
                ),
                padding:
                    EdgeInsets.only(top: 20, bottom: 50, left: 90, right: 10),
                width: 300,
                height: 300,
              ),
            ]),
          ],
        ),
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
