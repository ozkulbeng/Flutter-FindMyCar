import 'package:flutter/material.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_location/permission/permission_handler.dart';
import 'package:huawei_map/map.dart';

import 'custom_button.dart';
import 'models/request.dart';
import 'models/response.dart';
import 'prefs.dart';
import 'utils.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PermissionHandler _permissionHandler = PermissionHandler();
  FusedLocationProviderClient _locationService = FusedLocationProviderClient();
  Location _myLocation;
  LatLng _center;
  double _zoom = 18;
  bool _isCarParked = false;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _points = [];

  @override
  void initState() {
    requestPermission();
    getCarStatus();
    super.initState();
  }

  requestPermission() async {
    bool hasPermission = await _permissionHandler.hasLocationPermission();
    if (!hasPermission)
      hasPermission = await _permissionHandler.requestLocationPermission();
    if (hasPermission) getLastLocation();
  }

  getLastLocation() async {
    _myLocation = await _locationService.getLastLocation();
    setState(() {
      _center = LocationUtils.locationToLatLng(_myLocation);
    });
  }

  getCarStatus() async {
    _isCarParked = await Prefs.getIsCarParked();
    setState(() {});
    addMarker();
  }

  addMarker() async {
    if (_isCarParked && _markers.isEmpty) {
      LatLng carLocation = await Prefs.getCarLocation();
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId("myCar"),
          position: carLocation,
        ));
      });
    }
  }

  void parkMyCar() {
    getLastLocation();
    Prefs.setCarLocation(_myLocation);
    Prefs.setIsCarParked(true);
    getCarStatus();
  }

  void goToMyCar() async {
    getLastLocation();
    addMarker();
    LatLng carLocation = await Prefs.getCarLocation();
    DirectionRequest request = DirectionRequest(
      origin: Destination(
        lat: _myLocation.latitude,
        lng: _myLocation.longitude,
      ),
      destination: Destination(
        lat: carLocation.lat,
        lng: carLocation.lng,
      ),
    );
    DirectionResponse response = await DirectionUtils.getDirections(request);
    drawRoute(response);
  }

  drawRoute(DirectionResponse response) {
    if (_polylines.isNotEmpty) {
      _polylines.clear();
      _points.clear();
    }
    var steps = response.routes[0].paths[0].steps;
    for (int i = 0; i < steps.length; i++) {
      for (int j = 0; j < steps[i].polyline.length; j++) {
        _points.add(steps[i].polyline[j].toLatLng());
      }
    }
    setState(() {
      _polylines.add(
        Polyline(
            polylineId: PolylineId("route"),
            points: _points,
            color: Colors.redAccent),
      );
    });
  }

  clearScreen() {
    Prefs.setIsCarParked(false);
    Prefs.setCarLocation(null);
    _markers.clear();
    _polylines.clear();
    getCarStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find My Car"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: _myLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                HuaweiMap(
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: _zoom,
                  ),
                  markers: _markers,
                  polylines: _polylines,
                  mapType: MapType.normal,
                  tiltGesturesEnabled: true,
                  buildingsEnabled: true,
                  compassEnabled: true,
                  zoomControlsEnabled: true,
                  rotateGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  trafficEnabled: false,
                ),
                Positioned(
                  left: 20,
                  top: 20,
                  child: _isCarParked
                      ? CustomButton(
                          text: "Go to My Car",
                          onPressed: goToMyCar,
                        )
                      : CustomButton(
                          text: "Set Location",
                          onPressed: parkMyCar,
                        ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.clear),
                    onPressed: clearScreen,
                  ),
                )
              ],
            ),
    );
  }
}
