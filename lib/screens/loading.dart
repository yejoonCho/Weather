import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

const API_KEY = 'f60023883838bf763174efbff96d5743';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCureentLocation();
    latitude = myLocation.latitude;
    longitude = myLocation.longitude;

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?'
            'lat=$latitude&lon=$longitude&appid=$API_KEY&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?'
            'lat=$latitude&lon=$longitude&appid=$API_KEY');

    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
          parseWeatherData: weatherData, parseAirData: airData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Get my location', style: TextStyle(color: Colors.white)),
          onPressed: () {},
        ),
      ),
    );
  }
}
