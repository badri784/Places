import 'package:flutter/material.dart';

class AddPlaces extends StatefulWidget {
  const AddPlaces({super.key});

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  final titleController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            TextFieldTapRegion(
              child: TextField(
                onTapOutside: (_) => FocusScope.of(context).unfocus,
                decoration: InputDecoration(
                  labelText: 'Title :',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: titleController,
              ),
            ),
            const SizedBox(height: 12),
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
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
            // MaterialButton(
            //   onPressed: () {},
            //   color: Colors.black,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(Icons.add, color: Colors.white),
            //       SizedBox(width: 7),
            //       Text('Add Place', style: TextStyle(color: Colors.white)),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
