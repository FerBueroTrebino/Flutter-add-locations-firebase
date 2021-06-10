import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_add_locations_firebase/blocs/bottom_navigation/bottom_navigation_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_add_locations_firebase/generated/l10n.dart';

import 'package:flutter_add_locations_firebase/models/location_model.dart';

class AddLocationPage extends StatefulWidget {
  final LatLng userLocation;

  AddLocationPage({required this.userLocation}) : super();

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController latitudeInputController = TextEditingController();
  final TextEditingController longitudeInputController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LatLng _lastMapPosition = LatLng(19.81022017392787, 3.0496522039175034);

  final lugarRef = FirebaseFirestore.instance
      .collection('lugares')
      .withConverter<LocationModel>(
        fromFirestore: (snapshot, _) =>
            LocationModel.fromJson(snapshot.data()!),
        toFirestore: (lugar, _) => lugar.toJson(),
      );

  Future<void> addNewLocation(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Row(
          children: [
            Text('Guardando Lugar'),
            SizedBox(width: 20.0),
            CircularProgressIndicator(),
          ],
        )));

    await lugarRef.add(
      LocationModel(
        nombre: nameInputController.text,
        latlong: GeoPoint(
          double.parse(latitudeInputController.text),
          double.parse(longitudeInputController.text),
        ),
      ),
    );

    nameInputController.clear();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Lugar Guardado con Exito')));
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    latitudeInputController.text = _lastMapPosition.latitude
        .toString()
        .substring(0, _lastMapPosition.latitude.toString().length - 6);
    longitudeInputController.text = _lastMapPosition.longitude
        .toString()
        .substring(0, _lastMapPosition.longitude.toString().length - 6);
  }

  @override
  void initState() {
    super.initState();
    latitudeInputController.text = widget.userLocation.latitude.toString();
    longitudeInputController.text = widget.userLocation.latitude.toString();
  }

  @override
  void dispose() {
    latitudeInputController.dispose();
    longitudeInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.userLocation.latitude,
                          widget.userLocation.longitude),
                      zoom: 11.0),
                  onCameraMove: _onCameraMove,
                ),
                //TODO: Improve the pointer selection, is not exactly the one displaying
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: new Icon(Icons.person_pin_circle, size: 40.0),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            height: 240,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    controller: nameInputController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).locationName),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      }
                      return null;
                    },
                    onChanged: (input) {},
                    onSaved: (input) {
                      nameInputController.text = input!;
                    },
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Lat'),
                        Container(
                          width: 120.0,
                          child: TextFormField(
                            controller: latitudeInputController,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text('Lon'),
                        Container(
                          width: 120.0,
                          child: TextFormField(
                            controller: longitudeInputController,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addNewLocation(context);
                      }
                    },
                    child: Text(AppLocalizations.of(context).addLocation),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
