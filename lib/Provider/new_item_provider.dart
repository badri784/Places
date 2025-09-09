import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/Model/place.dart';

class UserPlaceNotifire extends StateNotifier<List<Place>> {
  UserPlaceNotifire() : super([]);

  void addNewUser(String title) {
    final newplace = Place(title: title);
    state = [newplace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifire, List<Place>>(
  (ref) {
    return UserPlaceNotifire();
  },
);
