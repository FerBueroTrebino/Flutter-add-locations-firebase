import 'package:flutter/material.dart';
import 'package:flutter_add_locations_firebase/generated/l10n.dart';

class AddLocationPage extends StatelessWidget {
  final int number;

  AddLocationPage({required this.number}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('Lugares: $number'),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: AddLocationForm(),
          )
        ],
      ),
    );
  }
}

class AddLocationForm extends StatelessWidget {
  const AddLocationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: MediaQuery.of(context).size.width - 40.0,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: AppLocalizations.of(context).locationName),
            textAlign: TextAlign.center,
          ),
          Container(
            child: Row(
              children: [
                Text('Lat'),
                SizedBox(width: 5.0),
                Flexible(
                  child: TextFormField(),
                ),
                SizedBox(width: 5.0),
                Text('Lon'),
                SizedBox(width: 5.0),
                Flexible(child: TextField()),
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.teal,
              onSurface: Colors.grey,
            ),
            onPressed: () {},
            child: Text(AppLocalizations.of(context).addLocation),
          )
        ],
      ),
    );
  }
}
