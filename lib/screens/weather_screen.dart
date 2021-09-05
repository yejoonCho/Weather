import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;
  final dynamic parseAirData;

  WeatherScreen({this.parseWeatherData, this.parseAirData});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // 기본 정보
  var cityName;
  var date = DateTime.now();
  // 날씨 관련
  var temperature;
  Widget? weatherIcon;
  String? description;
  // 대기질 지수
  Widget? airIcon;
  Widget? airState;
  // 미세먼지
  double? dust1;
  double? dust2;

  Model model = Model();

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirData);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    // 기본 정보
    cityName = weatherData['name'];
    temperature = weatherData['main']['temp'].toInt();
    // 날씨 관련
    int condition = weatherData['weather'][0]['id'];
    weatherIcon = model.getWeatherIcon(condition);
    description = weatherData['weather'][0]['description'];
    // 대기질 지수
    int index = airData['list'][0]['main']['aqi'];
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    // 미세먼지
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {},
            iconSize: 30,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 150),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                  Duration(minutes: 1),
                                  builder: (context) {
                                    print('${getSystemTime()}');
                                    return Text('${getSystemTime()}',
                                        style: GoogleFonts.lato(
                                            fontSize: 16, color: Colors.white));
                                  },
                                ),
                                Text(DateFormat(' - EEEE, ').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Colors.white)),
                                Text(DateFormat('d MMM, yyy').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Colors.white))
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temperature\u2103',
                              style: GoogleFonts.lato(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                weatherIcon!,
                                SizedBox(width: 10),
                                Text('$description',
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Colors.white))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(height: 15, thickness: 2, color: Colors.white30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('AQI (대기질지수)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white)),
                              SizedBox(height: 10),
                              airIcon!,
                              SizedBox(height: 10),
                              airState!
                            ],
                          ),
                          Column(
                            children: [
                              Text('미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white)),
                              SizedBox(height: 10),
                              Text('$dust1',
                                  style: GoogleFonts.lato(
                                      fontSize: 24, color: Colors.white)),
                              SizedBox(height: 10),
                              Text('ug/m3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('초미세먼지',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.white)),
                              SizedBox(height: 10),
                              Text('$dust2',
                                  style: GoogleFonts.lato(
                                      fontSize: 24, color: Colors.white)),
                              SizedBox(height: 10),
                              Text('ug/m3',
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
