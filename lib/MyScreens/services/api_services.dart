import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather/MyScreens/models/current_weather_model.dart';
import 'package:weather/MyScreens/models/hourly_weather_model.dart';
import 'package:http/http.dart' as http;

getCurrentWeather(lat, long) async {
  try {
    var link =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=1d1ce2a6d18eb194070b839f97b1641e&units=metric";
    var res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = currentWeatherDataFromJson(res.body.toString());
      return data;
    }
  } catch (e) {
     Fluttertoast.showToast(
            msg: "$e ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
   // print("Error in the Api is $e");
  }
}

getHourlyWeather(lat, long) async {
  try {
      var link =
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=1d1ce2a6d18eb194070b839f97b1641e&units=metric";
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = hourlyWeatherDataFromJson(res.body.toString());
    return data;
  }
  } catch (e) {
     Fluttertoast.showToast(
            msg: "$e ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
   // print("Error in the Api is $e");
  }
  }
