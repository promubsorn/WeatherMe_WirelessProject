import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/components/header.dart';
import 'components/current_pollution_widget.dart';
import 'components/navMenu.dart';
import 'controller/AirController.dart';

class AirPollution extends StatelessWidget {
  const AirPollution({super.key});

  @override
  Widget build(BuildContext context) {
    final AirController airController =
        Get.put(AirController(), permanent: true);

    return Scaffold(
      appBar: AppBar(title: Text('')),
      drawer: NavDrawer(),
      body: Container(
        child: Obx(() => airController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const HeaderWidget(),
                  CurrentPollutionWidget(airController: airController),
                ],
              )),
      ),
    );
  }
}
