import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_places.dart';
import '../Provider/new_item_provider.dart';
import '../Widget/places_list.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addplace = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(11),
        ),
        title: const Text('Your Places'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AddPlaces()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: PlacesList(places: addplace),
    );
  }
}
