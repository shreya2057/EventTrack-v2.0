import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../components/message.dart';
import '../services/geolocator.dart';

class GoogleLocation extends GetxController {
  final geoLocatorService = GeolocatorService();
  static Position get to => Get.find();

  Position currentLocation;

  @override
  void onInit() {
    setCurrentLocation().then((value) {
      if (currentLocation == null) {
        FlashMessage.errorFlash('Could not get Location Data.');
      }
    });

    super.onInit();
  }

  requestLocationPermission() async {
    bool serviceEnabled = false;

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    while (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        FlashMessage.errorFlash(
            'Location permissions are permanently denied, we cannot request permissions.');
        Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        FlashMessage.errorFlash('Location permissions are denied');
        Future.error('Location permissions are denied');
      }
    }
  }

  setCurrentLocation() async {
    try {
      await requestLocationPermission();
      currentLocation = await geoLocatorService.getCurrentLocation();
      update();
    } catch (e) {
      FlashMessage.errorFlash(e);
    }
  }
}
