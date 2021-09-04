import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';

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
    print(latitude);
    print(longitude);

    Network network =
        Network('https://samples.openweathermap.org/data/2.5/weather?'
            'q=London&appid=b1b15e88fa797225412429c1c50c122a1');

    var weatherData = await network.getJsonData();
    print(weatherData);
  }

  // void fetchData() async {

  //     var weather = parsingData['weather'][0]['description'];
  //     var wind = parsingData['wind']['speed'];
  //     var id = parsingData['sys']['id'];
  //     print(weather);
  //     print(wind);
  //     print(id);

  // }

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
