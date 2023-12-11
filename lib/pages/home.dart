import 'package:flutter/material.dart';
import 'package:image_extract/pages/next_page.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _progess = 0.0;
  int _counter2 = 100;

  File? _image;

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _increaseProgess() async {
    for (int i=0; i<5; i++) {
      setState(() {
        _progess = _progess + 0.2;
      });
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void _decrementCounter() {
    setState(() {
      _counter2--;
      if (_counter2 == 98) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Oh Snap'),
          )
        );
      }
    });
  }

  @override
  void initState() {
    _progess = 0.0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Image Tokens:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '$_counter2',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextButton(onPressed: _decrementCounter, child: const Text('Click this')),
            TextButton(onPressed: _increaseProgess, child: const Text('Click to load')),
            LinearProgressIndicator(
              value: _progess,
              semanticsLabel: 'Linear progress indicator',
            ),
            FloatingActionButton.extended(onPressed: () {_navigateToNextScreen(context);},
              label: const Text('Next Page'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NextPage()));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Document App Prototype',
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 37,
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}