import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

XFile? file;
final _picker = ImagePicker();

Future<String?> uploadImage(image) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('http://10.0.2.2:8000/image/upload'));
  request.files.add(await http.MultipartFile.fromPath('file',
    image,
  ));
  final res = await http.Response.fromStream(await request.send());
  return res.reasonPhrase;
}

Future<Uint8List?> galleryImagePicker() async {
  final file = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 90,
  );
  if (file != null) {
    uploadImage(file.path);
    return file.readAsBytes();
  }
  return null;
}