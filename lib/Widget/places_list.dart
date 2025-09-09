import 'package:flutter/material.dart';
import 'package:places/Model/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({required this.places, super.key});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(
        child: Text(
          'NO item added yet',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(
          places[index].title,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
      ),
    );
  }
}
