import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/components/current_search.dart';
import 'package:project/components/searchPageNew.dart';
import 'package:project/controller/globalController.dart';
import 'components/current_weather_widget.dart';
import 'components/header.dart';

class SearchWeather extends StatelessWidget {
  const SearchWeather({super.key});

  @override
  Widget build(BuildContext context) {
    
    final GlobalController globalController =
        Get.put(GlobalController(), permanent: true);
    return Container(
        child: Scaffold(
      appBar: AppBar(title: Text('Search Weather'), actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: SearchPage());
            
          },
          icon: Icon(Icons.search_sharp),
        )
      ]),
      body: Container(
        child: Obx(() => globalController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  //current temp
                  CurrentWeatherSearch(
                    weatherDataCurrent:
                        globalController.getData().getCurrentWeather(),
                  ),
                ],
              )),
      ),
    ));
  }
}
