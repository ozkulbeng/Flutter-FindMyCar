import 'package:huawei_location/location/location.dart';
import 'package:huawei_map/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String _latitude = "car_location_latitude";
  static const String _longitude = "car_location_longitude";
  static const String _isLocationSet = "is_location_set";

  static void setCarLocation(Location location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(_latitude, location.latitude);
    prefs.setDouble(_longitude, location.longitude);
    print(
        "Car's location has been set to (${location.latitude}, ${location.longitude})");
  }

  static Future<LatLng> getCarLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double lat = prefs.getDouble(_latitude);
    double lng = prefs.getDouble(_longitude);
    return LatLng(lat, lng);
  }

  static void setIsCarParked(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLocationSet, value);
  }

  static Future<bool> getIsCarParked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLocationSet)?? false;
  }
}
