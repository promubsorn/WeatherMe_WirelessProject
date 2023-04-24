// FullInfoWeather
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/models/weather_data_current.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../controller/AirController.dart';
import 'current_pollution_widget.dart';
import 'header.dart';

class FullInfoPollution extends StatelessWidget {
  final AirController airController;
  FullInfoPollution({super.key, required this.airController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          HeaderWidget(),
          PollutionBanner(airController: airController),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Divider(
              color: Color.fromARGB(50, 111, 109, 109),
            ),
          ),
          FullPollutionReport(
            airController: airController,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
            child: Divider(
              color: Color.fromARGB(50, 111, 109, 109),
            ),
          ),
          // Suntime(
          //   sunrise: airController.current.sunrise!,
          //   sunset: airController.current.sunset!,
          // )
        ],
      ),
    );
  }
}

class FullPollutionReport extends StatelessWidget {
  final AirController airController;
  const FullPollutionReport({
    super.key,
    required this.airController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Text(
            'Full Pollution Report',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PM2.5 (Fine particles matter)'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('PM10 (Coarse particulate matter)'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('CO (Carbon monoxide)'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('NO (Nitrogen monoxide)'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('NO2 (Nitrogen dioxide)'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('NH3 (Ammonia)'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('SO2 (Sulphur dioxide)'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('O3 (Ozone)'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          '${airController.getData().list![0].components!.pm25} μg/m3'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          '${airController.getData().list![0].components!.pm10} μg/m3'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          '${airController.getData().list![0].components!.co} μg/m3'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          '${airController.getData().list![0].components!.no} μg/m3'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          '${airController.getData().list![0].components!.no2} μg/m3'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          '${airController.getData().list![0].components!.nh3} μg/m3'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          '${airController.getData().list![0].components!.so2} μg/m3'),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          '${airController.getData().list![0].components!.o3} μg/m3'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PollutionBanner extends StatelessWidget {
  const PollutionBanner({
    super.key,
    required this.airController,
  });

  final AirController airController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Container(
        //banner
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff7861EA),
                Color.fromARGB(107, 228, 96, 230),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 228, 227, 224),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    if (airController.getData().list![0].main!.aqi == 1) ...[
                      AirQuality(
                        airController: airController,
                        fileLocation: 'assets/images/grinning.png',
                        text: 'Good',
                      ),
                    ] else if (airController.getData().list![0].main!.aqi ==
                        2) ...[
                      AirQuality(
                        airController: airController,
                        fileLocation: 'assets/images/smile.png',
                        text: 'Fair',
                      ),
                    ] else if (airController.getData().list![0].main!.aqi ==
                        3) ...[
                      AirQuality(
                        airController: airController,
                        fileLocation: 'assets/images/sad.png',
                        text: 'Moderate',
                      ),
                    ] else if (airController.getData().list![0].main!.aqi ==
                        4) ...[
                      AirQuality(
                        airController: airController,
                        fileLocation: 'assets/images/sick.png',
                        text: 'Poor',
                      ),
                    ] else ...[
                      AirQuality(
                        airController: airController,
                        fileLocation: 'assets/images/skull.png',
                        text: 'Very Poor',
                      ),
                    ],
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}

class Suntime extends StatelessWidget {
  int sunrise;
  int sunset;

  String getTime(final timerStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timerStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  Suntime({super.key, required this.sunrise, required this.sunset});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffFCCE98),
                    Color(0xffEDB826),
                  ],
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 14, bottom: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Sunrise',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(getTime(sunrise),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff7861EA),
                    Color.fromARGB(107, 228, 96, 230),
                  ],
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 14, bottom: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text('Sunset',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      getTime(sunset),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
