// To parse this JSON data, do
//
//     final directionResponse = directionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:huawei_map/components/components.dart';

DirectionResponse directionResponseFromJson(String str) =>
    DirectionResponse.fromJson(json.decode(str));

String directionResponseToJson(DirectionResponse data) =>
    json.encode(data.toJson());

class DirectionResponse {
  DirectionResponse({
    this.routes,
    this.returnCode,
    this.returnDesc,
  });

  List<Route> routes;
  String returnCode;
  String returnDesc;

  factory DirectionResponse.fromJson(Map<String, dynamic> json) =>
      DirectionResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        returnCode: json["returnCode"],
        returnDesc: json["returnDesc"],
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "returnCode": returnCode,
        "returnDesc": returnDesc,
      };
}

class Route {
  Route({
    this.trafficLightNum,
    this.paths,
    this.bounds,
  });

  int trafficLightNum;
  List<Path> paths;
  Bounds bounds;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        trafficLightNum: json["trafficLightNum"],
        paths: List<Path>.from(json["paths"].map((x) => Path.fromJson(x))),
        bounds: Bounds.fromJson(json["bounds"]),
      );

  Map<String, dynamic> toJson() => {
        "trafficLightNum": trafficLightNum,
        "paths": List<dynamic>.from(paths.map((x) => x.toJson())),
        "bounds": bounds.toJson(),
      };
}

class Bounds {
  Bounds({
    this.southwest,
    this.northeast,
  });

  Point southwest;
  Point northeast;

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
        southwest: Point.fromJson(json["southwest"]),
        northeast: Point.fromJson(json["northeast"]),
      );

  Map<String, dynamic> toJson() => {
        "southwest": southwest.toJson(),
        "northeast": northeast.toJson(),
      };
}

class Point {
  Point({
    this.lng,
    this.lat,
  });

  double lng;
  double lat;

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        lng: json["lng"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lng": lng,
        "lat": lat,
      };

  LatLng toLatLng() => LatLng(lat, lng);
}

class Path {
  Path({
    this.duration,
    this.durationText,
    this.durationInTrafficText,
    this.durationInTraffic,
    this.distance,
    this.startLocation,
    this.startAddress,
    this.distanceText,
    this.steps,
    this.endLocation,
    this.endAddress,
  });

  double duration;
  String durationText;
  String durationInTrafficText;
  double durationInTraffic;
  double distance;
  Point startLocation;
  String startAddress;
  String distanceText;
  List<Step> steps;
  Point endLocation;
  String endAddress;

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        duration: json["duration"].toDouble(),
        durationText: json["durationText"],
        durationInTrafficText: json["durationInTrafficText"],
        durationInTraffic: json["durationInTraffic"].toDouble(),
        distance: json["distance"].toDouble(),
        startLocation: Point.fromJson(json["startLocation"]),
        startAddress: json["startAddress"],
        distanceText: json["distanceText"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
        endLocation: Point.fromJson(json["endLocation"]),
        endAddress: json["endAddress"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "durationText": durationText,
        "durationInTrafficText": durationInTrafficText,
        "durationInTraffic": durationInTraffic,
        "distance": distance,
        "startLocation": startLocation.toJson(),
        "startAddress": startAddress,
        "distanceText": distanceText,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "endLocation": endLocation.toJson(),
        "endAddress": endAddress,
      };
}

class Step {
  Step({
    this.duration,
    this.orientation,
    this.durationText,
    this.distance,
    this.startLocation,
    this.instruction,
    this.action,
    this.distanceText,
    this.endLocation,
    this.polyline,
    this.roadName,
  });

  double duration;
  int orientation;
  String durationText;
  double distance;
  Point startLocation;
  String instruction;
  String action;
  String distanceText;
  Point endLocation;
  List<Point> polyline;
  String roadName;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        duration: json["duration"].toDouble(),
        orientation: json["orientation"],
        durationText: json["durationText"],
        distance: json["distance"].toDouble(),
        startLocation: Point.fromJson(json["startLocation"]),
        instruction: json["instruction"],
        action: json["action"],
        distanceText: json["distanceText"],
        endLocation: Point.fromJson(json["endLocation"]),
        polyline:
            List<Point>.from(json["polyline"].map((x) => Point.fromJson(x))),
        roadName: json["roadName"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "orientation": orientation,
        "durationText": durationText,
        "distance": distance,
        "startLocation": startLocation.toJson(),
        "instruction": instruction,
        "action": action,
        "distanceText": distanceText,
        "endLocation": endLocation.toJson(),
        "polyline": List<dynamic>.from(polyline.map((x) => x.toJson())),
        "roadName": roadName,
      };
}
