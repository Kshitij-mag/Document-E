import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_extract/utils/image_util.dart';


class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  // This is the file that will be used to store the image
  Uint8List? _image;

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