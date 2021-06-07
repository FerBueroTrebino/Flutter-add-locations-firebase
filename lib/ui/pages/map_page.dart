import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_add_locations_firebase/ui/widgets/weather_widget.dart';

class MapPage extends StatelessWidget {
  final String text;
  final Geoposition geoposition;

  MapPage({required this.text, required this.geoposition}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: WeatherWidget(),
          ),
          Center(
            child: Text('Ubicacion actual: ${geoposition.coords}'),
          ),
        ],
      ),
    );
  }
}
