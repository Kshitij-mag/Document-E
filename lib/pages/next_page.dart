import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  // This is the file that will be used to store the image
  Uint8List? _image;
  final _picker = ImagePicker();

  Future<Uint8List?> galleryImagePicker() async {
    XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (file != null) return await file.readAsBytes(); // convert into Uint8List.
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Extract App'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(children: [
              Center(
                // this button is used to open the image picker
                child: ElevatedButton(
                  onPressed: () async {
                    final Uint8List? image = await galleryImagePicker();

                    if (image != null) {
                     _image = image;
                    setState(() {});
                    }
                  },
                  child: const Text('Select An Image'),
                ),
              ),
              const SizedBox(height: 35),
              // The picked image will be displayed here
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: _image != null
                    ? Image.memory(_image!,
                    fit: BoxFit.cover) :
                    const Text('Add an image')
              )
            ]),
          ),
        ));
    }
}