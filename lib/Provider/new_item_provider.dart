import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/Model/place.dart';

class UserPlaceNotifire extends StateNotifier<List<Place>> {
  UserPlaceNotifire() : super([]);

  void addNewUser(String title, File image) {
    final newplace = Place(title: title, image: image);
    state = [newplace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifire, List<Place>>(
  (ref) {
    return UserPlaceNotifire();
  },
);
