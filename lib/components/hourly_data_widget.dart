import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/models/weather_data_hourly.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});

  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: const Text(
            'Today',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff6B70CC),
            ),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 12
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                margin: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: cardIndex.value == index
                        ? const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff7861EA),
                              Color.fromARGB(107, 228, 96, 230),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(107, 250, 209, 132),
                              Color.fromARGB(255, 248, 247, 245),
                            ],
                          )),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: HourlyDetails(
                    timestamp: weatherDataHourly.hourly[index].dt!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!,
                    temp: weatherDataHourly.hourly[index].temp!.toInt(),
                  ),
                ),
              ))));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int timestamp;
  String weatherIcon;
  String getTime(final timerStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  HourlyDetails(
      {super.key,
      required this.timestamp,
      required this.temp,
      required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(getTime(timestamp)),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Image.network(
              'https://openweathermap.org/img/wn/${weatherIcon}@2x.png',
              height: 40,
              width: 40,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text('${temp}°C'),
          )
        ],
      ),
    );
  }
}
