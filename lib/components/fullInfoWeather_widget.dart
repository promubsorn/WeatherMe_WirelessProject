// FullInfoWeather
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/models/weather_data_current.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'header.dart';

class FullInfoWeather extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  FullInfoWeather({super.key, required this.weatherDataCurrent});

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
          WeatherBanner(weatherDataCurrent: weatherDataCurrent),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Divider(
              color: Color.fromARGB(50, 111, 109, 109),
            ),
          ),
          WeatherForecast(
            weatherDataCurrent: weatherDataCurrent,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
            child: Divider(
              color: Color.fromARGB(50, 111, 109, 109),
            ),
          ),
          Suntime(
            sunrise: weatherDataCurrent.current.sunrise!,
            sunset: weatherDataCurrent.current.sunset!,
          )
        ],
      ),
    );
  }
}

class WeatherForecast extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const WeatherForecast({
    super.key,
    required this.weatherDataCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Text(
            'Weather Forecast',
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
                      Text('Atmospheric pressure'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('UV index'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Cloudiness'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Humidity'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Visibility'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Wind Speed'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Wind Direction'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Wind Gust'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${weatherDataCurrent.current.pressure} hPa'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${weatherDataCurrent.current.uvi}'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${weatherDataCurrent.current.clouds} %'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${weatherDataCurrent.current.humidity} %'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${weatherDataCurrent.current.visibility} meter'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${weatherDataCurrent.current.windSpeed} meter/sec'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${weatherDataCurrent.current.windDeg} degree'),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${weatherDataCurrent.current.windGust} meter/sec'),
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
                          'Temperature',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white54,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${weatherDataCurrent.current.temp}°C',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Feel like ${weatherDataCurrent.current.feelsLike}°C',
                          style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
