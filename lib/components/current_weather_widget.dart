import 'package:flutter/material.dart';
import 'package:project/models/weather_data_current.dart';
import 'fullInfoWeather_widget.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherWidget({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherBanner(weatherDataCurrent: weatherDataCurrent),
        MoreDetails(weatherDataCurrent: weatherDataCurrent),
        ButtonNextPage(
          weatherDataCurrent: weatherDataCurrent,
        ),
      ],
    );
  }
}

class ButtonNextPage extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const ButtonNextPage({
    super.key,
    required this.weatherDataCurrent,
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
                    FullInfoWeather(weatherDataCurrent: weatherDataCurrent)),
          );
        },
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
                              color: Colors.white),
                        ),
                        Text(
                          'Feel like ${weatherDataCurrent.current.feelsLike!.toInt()}°C',
                          style: TextStyle(
                              color: Colors.white,
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
                  color: Colors.white54,
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

class MoreDetails extends StatelessWidget {
  const MoreDetails({
    super.key,
    required this.weatherDataCurrent,
  });

  final WeatherDataCurrent weatherDataCurrent;

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
                weatherDataCurrent: weatherDataCurrent,
                title: 'Wind Speed',
                icon: Icon(Icons.storm, color: Colors.white),
                data: weatherDataCurrent.current.windSpeed),
            DetailsItem(
                weatherDataCurrent: weatherDataCurrent,
                title: 'Wind Gust',
                icon: Icon(Icons.wind_power, color: Colors.white),
                data: weatherDataCurrent.current.windGust),
            DetailsItem(
                weatherDataCurrent: weatherDataCurrent,
                title: 'UV index',
                icon: Icon(Icons.sunny, color: Colors.white),
                data: weatherDataCurrent.current.uvi),
          ],
        ),
      ),
    );
  }
}

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    super.key,
    required this.weatherDataCurrent,
    required this.title,
    required this.icon,
    required this.data,
  });

  final WeatherDataCurrent weatherDataCurrent;
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
