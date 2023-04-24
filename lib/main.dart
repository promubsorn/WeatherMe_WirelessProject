import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project/components/current_weather_widget.dart';
import 'package:project/components/header.dart';
import 'package:project/components/hourly_data_widget.dart';
import 'package:project/controller/globalController.dart';
import 'components/navMenu.dart';
import 'package:project/components/searchPageNew.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  logger.wtf("What a terrible failure log");
  logger.i("Info log");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherMe',
      theme: ThemeData.light(useMaterial3: true),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''), actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: SearchPage());
          },
          icon: Icon(Icons.search_sharp),
        )
      ]),
      drawer: NavDrawer(),
      body: Container(
        child: Obx(() => globalController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const HeaderWidget(),
                  //current temp
                  CurrentWeatherWidget(
                    weatherDataCurrent:
                        globalController.getData().getCurrentWeather(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  HourlyDataWidget(
                      weatherDataHourly:
                          globalController.getData().getHourlyWeather())
                ],
              )),
      ),
    );
  }
}
