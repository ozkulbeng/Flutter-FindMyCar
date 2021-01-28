// To parse this JSON data, do
//
//     final directionRequest = directionRequestFromJson(jsonString);

import 'dart:convert';

DirectionRequest directionRequestFromJson(String str) => DirectionRequest.fromJson(json.decode(str));

String directionRequestToJson(DirectionRequest data) => json.encode(data.toJson());

class DirectionRequest {
  DirectionRequest({
    this.origin,
    this.destination,
  });

  Destination origin;
  Destination destination;

  factory DirectionRequest.fromJson(Map<String, dynamic> json) => DirectionRequest(
    origin: Destination.fromJson(json["origin"]),
    destination: Destination.fromJson(json["destination"]),
  );

  Map<String, dynamic> toJson() => {
    "origin": origin.toJson(),
    "destination": destination.toJson(),
  };
}

class Destination {
  Destination({
    this.lng,
    this.lat,
  });

  double lng;
  double lat;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    lng: json["lng"].toDouble(),
    lat: json["lat"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lng": lng,
    "lat": lat,
  };
}
