import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../api/fetch_airPollution.dart';
import '../models/airModel.dart';
import '../models/airpollution_data.dart';

class AirController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  final airpollutionData = AirModel().obs;

  AirModel getData() {
    return airpollutionData.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    if (_isLoading.isTrue) {
      getLocation();
    } 
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location is not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    //getting the current position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      //calling weather api
      return FetchAirPollutionAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        airpollutionData.value = value;
        _isLoading.value = false;
      });
    });
  }

}
