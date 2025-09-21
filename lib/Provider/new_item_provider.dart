import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/Model/place.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> opendatabase() async {
  /*
  هنا عشان تقدر تفتح الداتا بيز لازم تجيب الباس ف اول خطوه بعد كدا هتعمل 
  sql.openDatebase 
  تعمل join 
  ل الباس بتاعك والنهايه بتاعتك زي مثلا 
  place.db 
  وبعد كدا بتعمل ال 
  oncreate مره واحده بس وخلي بالك من الحروف ف الكتابه 
  */
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
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
    final place = data
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
    final String filename = path.basename(image.path);
    final File copiedimage = await image.copy('${appdir.path}/$filename');
    final newplace = Place(
      title: title,
      image: copiedimage,
      locationPLace: locationplace,
    );
    final sql.Database db = await opendatabase();

    await db.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path,
      'lat': newplace.locationPLace.latitude,
      'lng': newplace.locationPLace.longitude,
    });
    state = [...state, newplace];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifire, List<Place>>(
  (ref) {
    return UserPlaceNotifire();
  },
);
