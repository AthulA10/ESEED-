import 'package:http/http.dart' as http;
import 'dart:convert';

batteryData() async {
  String slaveip = 'http://192.168.0.184/status';

  final http.Response response = await http.post(slaveip);

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);

    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    //return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get response from server');
  }
}
