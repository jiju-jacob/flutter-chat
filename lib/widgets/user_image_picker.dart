import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({required this.imagePickFn, Key? key})
      : super(key: key);

  final void Function(File pickedImage) imagePickFn;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
      if (_image != null) {
        widget.imagePickFn(_image!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: (_image != null) ? FileImage(_image!) : null,
      ),
      FlatButton.icon(
        onPressed: () {
          _pickImage();
        },
        icon: Icon(Icons.image),
        label: Text('Add image'),
      ),
    ]);
  }
}
