import 'package:flutter/material.dart';
import 'package:project/models/weather_data_current.dart';
import 'fullInfoWeather_widget.dart';
import 'header.dart';

class CurrentWeatherSearch extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherSearch({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(40, 205, 202, 204),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: const HeaderWidget(),
            ),
            WeatherBanner(weatherDataCurrent: weatherDataCurrent),
          ],
        ),
      ),
    );
  }
}

class WeatherBanner extends StatelessWidget {
  const WeatherBanner({
    super.key,
    required this.weatherDataCurrent,
  });

  final WeatherDataCurrent weatherDataCurrent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Container(
        //banner
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                      'https://openweathermap.org/img/wn/${weatherDataCurrent.current.weather![0].icon}@2x.png'),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '${weatherDataCurrent.current.temp!.toInt()}°C',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          'Feel like ${weatherDataCurrent.current.feelsLike!.toInt()}°C',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                '${weatherDataCurrent.current.weather![0].description}',
                style: TextStyle(
                  color: Color.fromARGB(83, 107, 112, 204),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
