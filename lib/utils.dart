import 'dart:convert';

import 'package:huawei_location/location/location.dart';
import 'package:huawei_map/components/latLng.dart';
import 'package:http/http.dart' as http;

import 'models/request.dart';
import 'models/response.dart';

class ApplicationUtils {
  static String encodeComponent(String component) => Uri.encodeComponent(component);

  static const String API_KEY =
      "YOUR_API_KEY";

  // HTTPS POST
  static String url =
      "https://mapapi.cloud.huawei.com/mapApi/v1/routeService/walking?key=" +
          encodeComponent(API_KEY);
}

class LocationUtils {
  static LatLng locationToLatLng(Location location) =>
      LatLng(location.latitude, location.longitude);
}

class DirectionUtils {
  static Future<DirectionResponse> getDirections(
      DirectionRequest request) async {
    print("Request: ${jsonEncode(request.toJson())}");
    var headers = <String, String>{
      "Content-type": "application/json",
    };
    print(jsonEncode(request.toJson()));
    var response = await http.post(ApplicationUtils.url,
        headers: headers, body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      DirectionResponse directionResponse =
          DirectionResponse.fromJson(jsonDecode(response.body));
      return directionResponse;
    } else
      throw Exception('Failed to load direction response');
  }
}
