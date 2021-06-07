import 'package:flutter/material.dart';

class AddLocationPage extends StatelessWidget {
  final int number;

  AddLocationPage({required this.number}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('My number is: $number'),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width - 40.0,
              height: 200,
              child: Column(
                children: [
                  TextFormField(),
                  TextFormField(),
                  TextFormField(),
                  TextButton(onPressed: () {}, child: Text('Guardad Lugar'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
