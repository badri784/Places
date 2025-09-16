/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:places/Model/place.dart';

class FlutterMapScreen extends StatelessWidget {
  final LocationPLace locationPLace;

  const FlutterMapScreen({super.key, required this.locationPLace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location on Map'), centerTitle: true),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            locationPLace.latitude,
            locationPLace.longitude,
          ),
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
            subdomains: const ['a', 'b', 'c', 'd'],
            userAgentPackageName: 'com.example.app',
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(locationPLace.latitude, locationPLace.longitude),
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
                'Made by Dev badri',
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://www.linkedin.com/in/ahmed-elbadri-684178318/',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/
