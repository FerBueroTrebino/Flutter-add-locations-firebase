import 'package:flutter/material.dart';

//TODO: Implement Weather widget
class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.green,
        child: Text('El tiempo'),
      ),
    );
  }
}
