import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'buy1.dart';
import 'buy.dart';

// class Album {
//   final int id;
//   final String title;
//   Album({this.id, this.title});
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       //id: json['id'],
//       //title: json['title'],
//     );
//   }
// }
var slaveip;
void request() async {
  try {
    //var url =slaveip;
    if (slaveip == '') {
      slaveip = 'http://ptsv2.com/g';
    }
    if (count == 1) {
      final http.Response response = await http.post(
        'http://192.168.0.184/status',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{}),
      );

      if (response.statusCode == 200) {
        count = 0;
        var data = json.decode(response.body);
        var rest = data["current"] as int;
        var buy = data["buy"] as int;
        var sell = data["sell"] as int;
        print(rest);
        print("buy $buy");
        print("sell $sell");
        //list = rest.map<Article>((json) => Article.fromJson(json)).toList();
        if (buy == 1) {
          if (currentCharge <= 100 && currentCharge >= 0) {
            currentCharge = displayVal;
          } else
            throw Exception('range error');
        }
        if (sell == 1) {
          if (currentCharge <= 100 && currentCharge >= 1) {
            currentCharge = displayVal;
          } else
            throw Exception('range error');
        }
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to get response from server');
      }
    }
  } on Exception catch (exception) {
    print('reset esp32');
  } catch (error) {
    print('reset esp32');
  }
}
