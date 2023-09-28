import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future uploadImage(File image) async {
  final String nameFile = image.path.split("/").last;
  final Reference imageReference =  storage.ref().child("images").child(nameFile);
  imageReference.putFile(image);
}