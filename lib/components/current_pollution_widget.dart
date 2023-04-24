import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/AirController.dart';
import 'fullInfoPollution_widget.dart';
import 'fullInfoWeather_widget.dart';

class CurrentPollutionWidget extends StatelessWidget {
  const CurrentPollutionWidget({
    super.key,
    required this.airController,
  });

  final AirController airController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PollutionBanner(airController: airController),
        MoreDetails(airController: airController),
        ButtonNextPage(
          airController: airController,
        ),
      ],
    );
  }
}

class ButtonNextPage extends StatelessWidget {
  final AirController airController;

  const ButtonNextPage({
    super.key,
    required this.airController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(right: 25),
      child: ElevatedButton(
        child: const Text('More>>'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FullInfoPollution(airController: airController)),
          );
        },
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

class AirQuality extends StatelessWidget {
  const AirQuality({
    super.key,
    required this.airController,
    required this.fileLocation,
    required this.text,
  });

  final AirController airController;
  final String fileLocation;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            fileLocation,
            height: 80,
            width: 80,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${airController.getData().list![0].components!.pm25}',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'concentration in μg/m3',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "Air quality: ${text}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoreDetails extends StatelessWidget {
  const MoreDetails({
    super.key,
    required this.airController,
  });

  final AirController airController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
      child: Container(
        // decoration: BoxDecoration(color: Colors.amber),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DetailsItem(
                airController: airController,
                title: 'PM 2.5',
                icon: Icon(CupertinoIcons.eye_fill, color: Colors.white),
                data: airController.getData().list![0].components!.pm25),
            DetailsItem(
                airController: airController,
                title: 'PM 10',
                icon: Icon(CupertinoIcons.smoke_fill, color: Colors.white),
                data: airController.getData().list![0].components!.pm10),
            DetailsItem(
                airController: airController,
                title: 'CO',
                icon: Icon(CupertinoIcons.exclamationmark_triangle_fill,
                    color: Colors.white),
                data: airController.getData().list![0].components!.co),
          ],
        ),
      ),
    );
  }
}

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    super.key,
    required this.airController,
    required this.title,
    required this.icon,
    required this.data,
  });

  final AirController airController;
  final String title;
  final Icon icon;
  final double? data;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        title,
        style: TextStyle(color: Color(0xff6F6D6D), fontSize: 14),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
            padding: EdgeInsets.all(14),
            child: icon),
      ),
      Text(
        '${data}',
        style: TextStyle(fontSize: 14, color: Color(0xff6F6D6D)),
      ),
    ]);
  }
}


// Todo
// change Colors
// change ImageS
// add full info page