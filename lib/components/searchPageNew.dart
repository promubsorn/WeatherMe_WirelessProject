import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../api/api_key.dart';
import '../models/city_for_searching.dart';

class SearchPage extends SearchDelegate {
  final FetchWeatherList _weatherList = FetchWeatherList();
  DatabaseReference dbSearch =
      FirebaseDatabase.instance.ref().child('Searched city');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        dbSearch.set(query);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<CityWeatherList>(
        future: _weatherList.getWeatherList(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          CityWeatherList? data = snapshot.data;
          
          return Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              height: 470,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Column(children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 30,
                            color: Color(0xffFDD468),
                          ),
                          Text(
                            '${data?.name}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff6B70CC)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                              'https://openweathermap.org/img/wn/${data?.weather![0].icon}@2x.png'),
                          Column(
                            children: [
                              Text(
                                '${data?.main!.temp!.toInt()}°C',
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Feels like ${data?.main!.feelsLike!.toInt()}°C'),
                              Text('${data?.weather![0].description}'),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 14, right: 14, top: 14),
                        child: Divider(
                          color: Color.fromARGB(50, 111, 109, 109),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 25, left: 25, top: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Min temp'),
                                Text('Max temp'),
                                Text('Humidity'),
                                Text('Pressure'),
                                Text('Wind speed'),
                                Text('Visibility'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('${data?.main!.tempMin!.toInt()}°C'),
                                Text('${data?.main!.tempMax!.toInt()}°C'),
                                Text('${data?.main!.humidity} %'),
                                Text('${data?.main!.pressure} hPa'),
                                Text('${data?.wind!.speed} m/s'),
                                Text('${(data?.visibility)! / 1000} Km'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 14, right: 14, top: 14),
                        child: Divider(
                          color: Color.fromARGB(50, 111, 109, 109),
                        ),
                      ),
                      Suntime(
                        sunrise: data!.sys!.sunrise,
                        sunset: data.sys!.sunset,
                      )
                    ]),
                  ],
                ),
              ),
            ),
          );

          // ListView.builder(
          //     // itemCount: data?.length,
          //     itemBuilder: (context, index) {
          //   return ListTile(
          //     title: Row(
          //       children: [
          //         Container(
          //           width: 60,
          //           height: 60,
          //           decoration: BoxDecoration(
          //             color: Colors.deepPurpleAccent,
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Center(
          //             child: Text(
          //               '${data?.name}',
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white),
          //               overflow: TextOverflow.clip,
          //             ),
          //           ),
          //         ),
          //         SizedBox(width: 20),
          //         Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 // '${data?.cityInfo!.name.main![0].temp}',
          //                 '${data?.main!.temp}',
          //                 style: TextStyle(
          //                     fontSize: 18, fontWeight: FontWeight.w600),
          //               ),
          //               SizedBox(height: 10),
          //               Text(
          //                 '${data?.main!.feelsLike}',
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //             ])
          //       ],
          //     ),
          //   );
          // });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search City'),
    );
  }
}

class FetchWeatherList {
  late CityWeatherList results;

  String apiURL(var city) {
    String url;
    url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apiKey&units=metric";

    return url;
  }

  Future<CityWeatherList> getWeatherList(query) async {
    var response = await http.get(Uri.parse(apiURL(query)));
    var jsonString = jsonDecode(response.body);
    results = CityWeatherList.fromJson(jsonString);
    return results;
  }
}

class Suntime extends StatelessWidget {
  int? sunrise;
  int? sunset;

  String getTime(final timerStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timerStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  Suntime({super.key, required this.sunrise, required this.sunset});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
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
                    child: Text(
                      'Sunrise',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Text(getTime(sunrise),
                        style: TextStyle(
                            fontSize: 14,
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
                    child: Text('Sunset',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                  Container(
                    child: Text(
                      getTime(sunset),
                      style: TextStyle(
                          fontSize: 14,
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
