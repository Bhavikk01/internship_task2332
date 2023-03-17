import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internship_task/app/screens/home_screen/getx_helper/controller.dart';

import '../../utils/theme_helper.dart';

class MapScreen extends GetView<MapController> {
  MapScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.navigateToCurrentLocation();
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: Obx(
            () => SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: controller.initialPosition.value,
                        zoom: 16,
                      ),
                      onTap: (latLng) {
                        log(latLng.toString());
                        controller.zonePoints.add(latLng);
                        controller.addPolygon();
                      },
                      zoomControlsEnabled: false,
                      markers: Set<Marker>.of(controller.zoneMarkers),
                      compassEnabled: false,
                      polygons: controller.polygon.value,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      onMapCreated: (GoogleMapController mapController) {
                        controller.setMapController(mapController);
                      },
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            decoration: ThemeHelper().inputBoxDecorationShadow(),
                            child: TextFormField(
                              controller: controller.zoneController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "The zone name can't be empty";
                                }
                                return null;
                              },
                              decoration: ThemeHelper().textInputDecoration(
                                  'Zone name', 'Enter your zone name'),
                            ),
                          ),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  'Submit'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.uploadingZoneInfoToDatabase();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
