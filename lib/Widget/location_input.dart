import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:places/Model/place.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
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

    log(locationData.longitude.toString());
    log(locationData.latitude.toString());
  }

  @override
  void initState() {
    super.initState();
    getCurrenLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location on Map'), centerTitle: true),
      body: FlutterMap(
        mapController: mapController,
        options: const MapOptions(initialZoom: 13),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
            subdomains: ['a', 'b', 'c', 'd'],
            userAgentPackageName: 'com.example.app',
          ),

          if (_locationPLace != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(
                    _locationPLace!.latitude,
                    _locationPLace!.longitude,
                  ),
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
              TextSourceAttribution(
                '© CARTO, © OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://www.carto.com/')),
              ),
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
