import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool getlocation = false;

  Future<void> getCurrenLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      getlocation = true;
    });
    locationData = await location.getLocation();
    setState(() {
      getlocation = false;
    });

    log(locationData.longitude.toString());
    log(locationData.latitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    Widget ischosenLocation = const Center(
      child: Text('No Location Added Yet'),
    );
    if (getlocation) {
      ischosenLocation = const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: ischosenLocation,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrenLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Add Your location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('chose your location on map'),
            ),
          ],
        ),
      ],
    );
  }
}
