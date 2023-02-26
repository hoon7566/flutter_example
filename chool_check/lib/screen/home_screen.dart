import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 위도 경도
  static final LatLng homeLatLng = LatLng(37.5233273, 126.921252);
  static final CameraPosition initialCameraPosition = CameraPosition(
    target: homeLatLng,
    zoom: 15.0,
  );
  static final double distance = 100.0;
  static final Circle circle = Circle(
      circleId: CircleId("circle"),
      center: homeLatLng,
      fillColor: Colors.blue.withOpacity(0.2),
      radius: distance,
      strokeColor: Colors.blue,
      strokeWidth: 1);

  static final Marker marker = Marker(
    markerId: MarkerId("marker"),
    position: homeLatLng,
    infoWindow: InfoWindow(title: "집"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppBar(),
      body: FutureBuilder(
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == "위치 권한이 허가되었습니다.") {
              return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  // print(snapshot.data);

                  bool isWithInRange = false;

                  if(snapshot.data != null) {
                    final currentPosition = snapshot.data! ;
                    final distanceInMeters = Geolocator.distanceBetween(
                        currentPosition.latitude,
                        currentPosition.longitude,
                        homeLatLng.latitude,
                        homeLatLng.longitude);
                    isWithInRange = distanceInMeters <= distance;
                  }

                  return Column(children: [
                    _CustomGoogleMap(
                      initialCameraPosition: initialCameraPosition,
                      circle: circle,
                      marker: marker,
                    ),
                    _ChoolCheck(),
                  ]);
                }
              );
            } else {
              return Center(child: Text(snapshot.data));
            }
          }),
    );
  }

  Future<String> checkPermission() async {
    final isLocationPermission = await Geolocator.isLocationServiceEnabled();

    if (!isLocationPermission) {
      return "위치 권한 허용해주세요";
    }

    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();
      if (checkPermission == LocationPermission.denied) {
        return "위치 권한 허용해주세요";
      }
    }
    if (checkPermission == LocationPermission.deniedForever) {
      return "위치 권한을 세팅에서 변경해주세요";
    }

    return "위치 권한이 허가되었습니다.";
  }

  AppBar _renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text('오늘도 출근',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)),
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final Circle circle;
  final Marker marker;

  const _CustomGoogleMap(
      {required this.initialCameraPosition, required this.circle,
        required this.marker,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapType: MapType.terrain,
          initialCameraPosition: initialCameraPosition,
          circles: Set.from([circle]),
          markers: Set.from([marker]),
      ),

    );
  }
}

class _ChoolCheck extends StatelessWidget {
  const _ChoolCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: TextButton(onPressed: () {}, child: Text('출근하기')));
  }
}
