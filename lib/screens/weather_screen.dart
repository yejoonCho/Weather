import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;

  WeatherScreen({this.parseWeatherData});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  double? temperature;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    temperature = weatherData['main']['temp'];
    cityName = weatherData['name'];

    print(temperature);
    print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$cityName', style: TextStyle(fontSize: 30)),
            SizedBox(
              height: 20,
            ),
            Text('$temperature', style: TextStyle(fontSize: 30))
          ],
        ),
      )),
    );
  }
}
