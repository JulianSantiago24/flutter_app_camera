import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore dataBase = FirebaseFirestore.instance;

Future<List> getPicturesInfo() async {
  List pictures = [];
  CollectionReference collectionReferencePictures = dataBase.collection('pictures');
  QuerySnapshot queryPictures = await collectionReferencePictures.get();

  queryPictures.docs.forEach((document) { 
    pictures.add(document.data());
  });
  
  return pictures;
}

Future<void> addPicturesInfo(String url, Timestamp timestamp) async {
  await dataBase.collection('pictures').add({ "url": url, "timestamp": timestamp });
}
