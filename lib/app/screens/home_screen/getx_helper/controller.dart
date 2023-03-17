import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship_task/app/services/firebase.dart';

class MapController extends GetxController {
  RxList<LatLng> zonePoints = <LatLng>[].obs;

  TextEditingController zoneController = TextEditingController();
  Rx<Set<Polygon>> polygon = HashSet<Polygon>().obs;
  RxList<Marker> zoneMarkers = <Marker>[].obs;

  late GoogleMapController mapController;

  Rx<LatLng> initialPosition = const LatLng(
    45.51563,
    -122.677433,
  ).obs;

  CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(
    45.51563,
    -122.677433,
  ));

  @override
  Future<void> onInit() async {
    await getCurrentLocation();

    super.onInit();
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  addPolygon() async {
    polygon.value.clear();

    zoneMarkers.add(Marker(
      markerId: MarkerId('${zoneMarkers.length + 1}'),
      position: zonePoints.last,
      zIndex: 2,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size.square(20)),
          "assets/map-marker.png"),
    ));

    polygon.value.add(Polygon(
        polygonId: const PolygonId('1'),
        points: zonePoints,
        geodesic: true,
        strokeWidth: 3,
        fillColor: Colors.transparent,
        strokeColor: Colors.black));
  }

  uploadingZoneInfoToDatabase() async {
    if (zonePoints.isNotEmpty) {
      log(zonePoints.toString());
      FirebaseFireStore.to.uploadZoneData(zoneController.text, zonePoints);
      zoneMarkers.value = <Marker>[];
      zonePoints.value = <LatLng>[];
      zoneController.clear();
      polygon.value = HashSet<Polygon>();
    }
  }

  Future<void> navigateToCurrentLocation() async {
    bool isServiceEnabled = false;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('error');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission Denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permission Denied forever');
    }

    Position position = await Geolocator.getCurrentPosition();
    initialPosition.value = LatLng(position.latitude, position.longitude);

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 16)));
  }

  Future<void> getCurrentLocation() async {
    bool isServiceEnabled = false;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('error');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission Denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permission Denied forever');
    }

    Position position = await Geolocator.getCurrentPosition();
    initialPosition.value = LatLng(position.latitude, position.longitude);
  }
}
