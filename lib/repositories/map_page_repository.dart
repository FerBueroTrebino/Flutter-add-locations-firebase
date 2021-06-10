import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPageRepository {
  LatLng _userLocation = new LatLng(31.42796133580664, -122.085749655962);

  Future<void> getUserLocation() async {
    var currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      print("locationLatitude: ${currentLocation.latitude}");
      print("locationLongitude: ${currentLocation.longitude}");
      _userLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    } on Exception {
      currentLocation = null;
    }
  }

  LatLng get data => _userLocation;
}
