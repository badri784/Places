import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:places/Model/place.dart';
import 'package:places/Provider/new_item_provider.dart';
import 'package:places/Widget/location_input.dart';
import 'package:places/Widget/pick_image.dart';

class AddPlaces extends ConsumerStatefulWidget {
  const AddPlaces({super.key});

  @override
  ConsumerState<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
  bool getlocation = false;

  LocationPLace? locationplace;
  File? _selectedimage;
  final titleController = TextEditingController();
  Future<void> navscreen() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            LocationInput(passlocation: (loc) => locationplace = loc),
      ),
    );
  }

  void onsave() {
    final String text = titleController.text;
    if (text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('Error title'),
          content: Text('something was wrong please try agine later'),
        ),
      );
    }

    if (_selectedimage == null) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('Error image'),
          content: Text('something was wrong please try agine later'),
        ),
      );
    }

    if (locationplace == null) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('Error location'),
          content: Text('something was wrong please try agine later'),
        ),
      );
    }

    ref
        .read(userPlaceProvider.notifier)
        .addNewUser(text, _selectedimage!, locationplace!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget ischosenLocation = const Center(
      child: Text('No Location Added Yet'),
    );
    if (getlocation) {
      ischosenLocation = const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(11),
        ),
        title: const Text('Add Your Places'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),

        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              onTapOutside: (_) => FocusScope.of(context).unfocus,
              decoration: InputDecoration(
                labelText: 'Title :',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: titleController,
            ),
            const SizedBox(height: 12),
            PickImage(addimage: (File image) => _selectedimage = image),
            const SizedBox(height: 12),
            Column(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                  child: ischosenLocation,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                      label: const Text('Add Your location'),
                    ),
                    TextButton.icon(
                      onPressed: navscreen,
                      icon: const Icon(Icons.map),
                      label: const Text('chose your location on map'),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              onPressed: onsave,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
