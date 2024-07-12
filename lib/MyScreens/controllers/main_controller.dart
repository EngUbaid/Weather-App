import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/MyScreens/services/api_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
    hourlyWeatherData = getHourlyWeather(latitude.value, longitude.value);
    super.onInit();
  }

  var isDark = false.obs;
  dynamic currentWeatherData;
  dynamic hourlyWeatherData;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isloaded = false.obs;

  changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.light : ThemeMode.dark);
  }

  getUserLocation() async {
    try {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        Fluttertoast.showToast(
            msg: "Location is not enabled  Please on Location ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        // throw Exception("Location is not enabled  Please on Location ");
      }
      LocationPermission userPermission = await Geolocator.checkPermission();
      if (userPermission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: "Permission is denied forever",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        // throw Exception("Permission is denied forever");
      } else if (userPermission == LocationPermission.denied) {
        userPermission = await Geolocator.requestPermission();
        if (userPermission == LocationPermission.denied) {
          Fluttertoast.showToast(
              msg: "Permission is denied",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          // throw Exception("Permission is denied");
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      isloaded.value = true;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error getting user location: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // print("Error getting user location: $e");
    }
  }
}
