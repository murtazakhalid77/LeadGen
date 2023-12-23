import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  List<XFile>? _images = [];

  Future<void> _uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final List<XFile>? pickedImages = await _picker.pickMultiImage();
                if (pickedImages != null && pickedImages.isNotEmpty) {
                  setState(() {
                    _images = [...?_images, ...pickedImages];
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  setState(() {
                    _images = [...?_images, pickedImage];
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _uploadImage,
            child: const Text('Upload Image'),
          ),
          _images != null && _images!.isNotEmpty
              ? Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: _images!.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(_images![index].path),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
