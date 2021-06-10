import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_add_locations_firebase/ui/widgets/weather_widget.dart';

class MapPage extends StatelessWidget {
  final LatLng userLocation;

  MapPage({required this.userLocation}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapSample(
            userLocation: userLocation,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: WeatherWidget(),
          ),
        ],
      ),
    );
  }
}

class MapSample extends StatelessWidget {
  MapSample({required this.userLocation}) : super();

  final LatLng userLocation;

  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Set<Marker> _creatMarkers(listaDocs) {
    List<Marker> mMarkers = [];
    mMarkers.add(Marker(
      markerId: MarkerId('user'),
      position: userLocation,
    ));
    listaDocs.map((document) {
      mMarkers.add(
        Marker(
          markerId: MarkerId(document.id),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(title: document['nombre']),
          position: LatLng(
              document['latlong'].latitude, document['latlong'].longitude),
        ),
      );
    }).toList();

    return mMarkers.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('lugares').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return new GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          initialCameraPosition: CameraPosition(
            target: userLocation,
            zoom: 11.0,
          ),
          markers: _creatMarkers(snapshot.data!.docs),
        );
      },
    );
  }
}
