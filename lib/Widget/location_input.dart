import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:places/Model/place.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationInput extends StatefulWidget {
  final void Function(LocationPLace) passlocation;
  const LocationInput({super.key, required this.passlocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LatLng? locationselected;
  MapController mapController = MapController();
  LocationPLace? _locationPLace;

  Future<void> getCurrenLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;

    if (lat == null || long == null) return;
    setState(() {
      _locationPLace = LocationPLace(latitude: lat, longitude: long);
      mapController.move(LatLng(lat, long), 13);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrenLocation();
  }

  void onsavelocation() {
    if (locationselected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location first!')),
      );
      return;
    }

    log(
      'Saved location: ${locationselected!.latitude}, ${locationselected!.longitude}',
    );

    Navigator.of(context).pop();
    widget.passlocation(_locationPLace!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location on Map'),
        centerTitle: true,
        actions: [
          IconButton.outlined(
            onPressed: onsavelocation,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialZoom: 13,
          onTap: (tapposition, point) {
            setState(() {
              locationselected = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
            subdomains: ['a', 'b', 'c', 'd'],
            userAgentPackageName: 'com.example.app',
          ), //log(locationselected.toString());
          MarkerLayer(
            markers: locationselected == null
                ? []
                : [
                    Marker(
                      point: locationselected!,

                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
          ),

          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'Dev Ahmed elbadri',
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://www.linkedin.com/in/ahmed-elbadri-684178318/',
                  ),
                ),
              ),
              // TextSourceAttribution(
              //   '© CARTO, © OpenStreetMap contributors',
              //   onTap: () => launchUrl(Uri.parse('https://www.carto.com/')),
              // ),
              // TextSourceAttribution(
              //   '© OpenStreetMap contributors',
              //   onTap: () => launchUrl(
              //     Uri.parse('https://www.openstreetmap.org/copyright'),
              //   ),
              // ),
              // TextSourceAttribution(
              //   '© CARTO',
              //   onTap: () => launchUrl(Uri.parse('https://www.carto.com/')),
              // ),
            ],
            showFlutterMapAttribution: false,
          ),
        ],
      ),
    );
  }
}
