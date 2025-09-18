import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String title;
  final String id;
  final File image;
  final LocationPLace locationPLace;

  Place({
    String? id,
    required this.title,
    required this.image,
    required this.locationPLace,
  }) : id = id ?? uuid.v4();
}

class LocationPLace {
  final double longitude;
  final double latitude;

  const LocationPLace({required this.latitude, required this.longitude});
}
