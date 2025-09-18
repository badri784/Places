import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/Model/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> opendatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final sql.Database db = await sql.openDatabase(
    path.join(dbpath, 'place.db'),
    onCreate: (db, version) => db.execute(
      'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL)',
    ),
    version: 1,
  );
  return db;
}

class UserPlaceNotifire extends StateNotifier<List<Place>> {
  UserPlaceNotifire() : super([]);
  Future<void> loadplaces() async {
    final sql.Database db = await opendatabase();
    final List<Map<String, Object?>> data = await db.query('user_places');
    final List<Place> place = data
        .map(
          (e) => Place(
            id: e['id'] as String,
            title: e['title'] as String,
            image: File(e['image'] as String),
            locationPLace: LocationPLace(
              latitude: e['lat'] as double,
              longitude: e['lng'] as double,
            ),
          ),
        )
        .toList();

    state = place;
  }

  void addNewUser(String title, File image, LocationPLace locationplace) async {
    final Directory appdir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedimage = await image.copy('${appdir.path}/{$filename}');
    final newplace = Place(
      title: title,
      image: copiedimage,
      locationPLace: locationplace,
    );
    final sql.Database db = await opendatabase();

    db.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path,
      'lat': newplace.locationPLace.latitude,
      'lng': newplace.locationPLace.longitude,
    });
    state = [newplace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifire, List<Place>>(
  (ref) {
    return UserPlaceNotifire();
  },
);
