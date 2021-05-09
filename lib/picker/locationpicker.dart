import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

import '../components/rounded_input_field.dart';
import '../model/event.dart';
import '../states/location.dart';
import '../theme/extension.dart';
import '../theme/text_styles.dart';

class PickALocation extends StatefulWidget {
  @override
  _PickALocationState createState() => _PickALocationState();
}

class _PickALocationState extends State<PickALocation> {
  final location = Get.put(GoogleLocation());

  GoogleMapController mapController;

  Marker marker = Marker(markerId: MarkerId('marker'));
  LatLng selectedCoordinates;
  Placemark placeInfo;

  Future<Placemark> placemark(LatLng coordinates) async {
    return await placemarkFromCoordinates(
            coordinates.latitude, coordinates.longitude)
        .then((value) => value[0]);
  }

  void createMarker(LatLng coordinates, Placemark placemark) {
    Marker newMarker = Marker(
        markerId: MarkerId('marker'),
        alpha: 0.7,
        position: coordinates,
        infoWindow: InfoWindow(title: placemark.toString()));
    setState(() {
      marker = newMarker;
    });
  }

  animateCamera(LatLng coordinates) async {
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: coordinates, zoom: 18),
      ),
    );
  }

  goToPlace(LatLng coordinates) async {
    setState(() {
      selectedCoordinates = coordinates;
    });

    await placemark(coordinates).then((value) {
      placeInfo = value;
      createMarker(coordinates, value);
      animateCamera(coordinates);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<GoogleLocation>(
          init: GoogleLocation(),
          builder: (_) => location.currentLocation == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      markers: {marker},
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          location.currentLocation.latitude,
                          location.currentLocation.longitude,
                        ),
                        zoom: 15,
                      ),
                      onTap: goToPlace,
                    ),
                    TextFieldContainer(
                      width: double.maxFinite,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search Places',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ).ripple(() => Get.to(() => _search())).hP16,
                    Positioned.fill(
                      bottom: 10,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          ),
                        ),
                        onPressed: () {
                          LocationModel pickedLocation = LocationModel(
                            coordinates: selectedCoordinates,
                            placemark: placeInfo,
                          );
                          Get.back(result: pickedLocation);
                          return pickedLocation;
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: FontSizes.title),
                        ),
                      ).alignBottomCenter,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget _search() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        bottom: false,
        child: MapBoxPlaceSearchWidget(
          popOnSelect: true,
          apiKey: env['MAPBOX_API_KEY'],
          searchHint: 'Search around',
          onSelected: (place) async {
            print('${place.toRawJson()}');
            await goToPlace(
              LatLng(
                place.geometry.coordinates[1],
                place.geometry.coordinates[0],
              ),
            );
          },
          context: context,
        ),
      ),
    );
  }
}
