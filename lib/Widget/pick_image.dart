import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _selectedimage;

  takeapicture() async {
    final imagepiker = ImagePicker();
    final pickedimage = await imagepiker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedimage == null) return;

    setState(() {
      //Here you convert the Xfile to file?
      _selectedimage = File(pickedimage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = GestureDetector(
      onTap: takeapicture,
      child: TextButton.icon(
        onPressed: takeapicture,
        label: const Text('Take a picture'),
        icon: const Icon(Icons.camera),
      ),
    );
    if (_selectedimage != null) {
      content = Image.file(
        _selectedimage!,
        fit: BoxFit.contain,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
