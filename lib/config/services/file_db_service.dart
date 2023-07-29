import 'dart:io';
import 'dart:typed_data';

import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileDbService {
  FirebaseStorage storage = FirebaseStorage.instance;
  final BuildContext context;
  FileDbService(this.context);
  Future<String> uploadeimage(String name, File image) async {
    try {
      await storage.ref(name).putFile(image);
      return storage.ref(name).getDownloadURL();
    } on FirebaseException catch (e) {
      showErrorSnackBar(context, e.message!);
      return 'error';
    }
  }

  Future<List<String>?> uploadeimages(List<XFile> files) async {
    List<String> urls = [];
    try {
      for (int i = 0; i < files.length; i++) {
        File file = File(files[i].path);
        String name = files[i].path;
        await storage.ref(name).putFile(file);
        String url = await storage.ref(name).getDownloadURL();
        urls.add(url);
      }
      return urls;
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }

  Future<String> uploadeFile(String name, Uint8List file) async {
    try {
      await storage.ref(name).putData(file);
      return storage.ref(name).getDownloadURL();
    } on FirebaseException catch (e) {
      showErrorSnackBar(context, e.message!);
      return 'error';
    }
  }
}
