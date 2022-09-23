import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wifi_connector/wifi_connector.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _ssidController = TextEditingController(text: '680030000195');
  final _passwordController = TextEditingController(text: 'm12341234');
  var _isSucceed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wifi connector example app'),
        ),
        body: ListView(
          children: [
            _buildTextInput(
              'ssid',
              _ssidController,
            ),
            _buildTextInput(
              'password',
              _passwordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ElevatedButton(
                child: Text(
                  'connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _onConnectPressed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ElevatedButton(
                child: Text(
                  'connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  print("sdfljk");
                  WifiConnector.disconnectToWifi();
                },
              ),
            ),
            Text(
              'Is wifi connected?: $_isSucceed',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput(String title, TextEditingController controller) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Container(width: 80.0, child: Text(title)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextField(
              controller: controller,
              onChanged: (value) => setState(
                () {},
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _onConnectPressed() async {
    // http.get(Uri.parse("https://baidu.com"));
    try {
      print("sdfljk star");
      // var response = await client.get(Uri.parse("https://baidu.com"));
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      // var uri = Uri.parse(decodedResponse['uri'] as String);
      var response = await http.get(Uri.parse("https://baidu.com"));
      print(response.body);
    } catch (e) {
      print("sdfljk $e");
    } finally {
      print("sdfljk");
    }

    final ssid = _ssidController.text;
    final password = _passwordController.text;
    setState(() => _isSucceed = false);

    final isSucceed = await WifiConnector.connectToWifi(ssid: ssid);
    setState(() => _isSucceed = isSucceed);
  }
}
