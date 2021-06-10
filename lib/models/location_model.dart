import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  LocationModel({required this.nombre, required this.latlong});

  LocationModel.fromJson(Map<String, Object?> json)
      : this(
          nombre: json['nombre']! as String,
          latlong: json['latlong']! as GeoPoint,
        );

  final String nombre;
  final GeoPoint latlong;

  LocationModel copyWith({required String nombre, required GeoPoint latlong}) {
    return LocationModel(
      nombre: nombre,
      latlong: latlong,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'nombre': nombre,
      'latlong': latlong,
    };
  }
}
