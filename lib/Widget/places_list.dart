import 'package:flutter/material.dart';
import 'package:places/Model/place.dart';
import 'package:places/Screen/places_detial.dart';

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
      itemBuilder: (ctx, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card.outlined(
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: FileImage(places[index].image),
            ),
            title: Text(
              places[index].title,
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PlacesDetialScreen(place: places[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
