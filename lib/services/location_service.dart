import 'package:geolocator/geolocator.dart';

import '../core/errors/exceptions.dart';

class LocationService{

 static Future<Position> getCurrentUserLocation()async{
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationDeniedException();
    }


    return await Geolocator.getCurrentPosition();
  }
}

