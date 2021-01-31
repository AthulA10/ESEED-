import 'package:flutter/material.dart';
import 'main.dart';
import 'barchart.dart';
import 'buy.dart';
import 'buy1.dart';

class tradeRoute extends StatefulWidget {
  @override
  _tradeRouteState createState() => _tradeRouteState();
}

class _tradeRouteState extends State<tradeRoute> {
  int _selectedIndex = 1;

  void navig1(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
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
        title: Text("E-SEED"),
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              children: <Widget>[
                BarChartSample2(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                  padding: new EdgeInsets.fromLTRB(60, 10, 60, 10),
                  child: Text('Buy'),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => buy1page()),
                    );
                  }),
              RaisedButton(
                  padding: new EdgeInsets.fromLTRB(60, 10, 60, 10),
                  child: Text('Sell'),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => buypage()),
                    );
                  })
            ],
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
        onTap: navig1,
      ),
    );
  }
}
