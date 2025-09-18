import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_places.dart';
import '../Provider/new_item_provider.dart';
import '../Widget/places_list.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
  ConsumerState<Places> createState() => _PlacesState();
}

class _PlacesState extends ConsumerState<Places> {
  late Future<void> _placesfuture;
  @override
  void initState() {
    super.initState();
    _placesfuture = ref.read(userPlaceProvider.notifier).loadplaces();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _placesfuture,
        builder: (context, AsyncSnapshot<void> asyncSnapshot) =>
            asyncSnapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CupertinoActivityIndicator())
            : PlacesList(places: addplace),
      ),
    );
  }
}
