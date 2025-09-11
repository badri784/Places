import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String title;
  final String id;
  final File image;

  Place({required this.image, required this.title}) : id = uuid.v4();
}
