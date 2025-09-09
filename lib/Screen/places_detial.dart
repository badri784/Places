import 'package:flutter/material.dart';
import 'package:places/Model/place.dart';

class PlacesDetialScreen extends StatelessWidget {
  const PlacesDetialScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [Center(child: Text(place.title))]),
      ),
    );
  }
}
