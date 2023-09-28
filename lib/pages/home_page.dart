import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_camera/pages/camera_page.dart';
import 'package:flutter_app_camera/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería',
          style: TextStyle(
          color: Color.fromARGB(255, 239, 245, 247),
          fontFamily: 'Mooli',
          fontWeight: FontWeight.bold,
          fontSize: 35
        ),),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.4, 0.8],
            colors: [
              Color.fromARGB(255, 248, 131, 42),
              Color.fromARGB(255, 10, 174, 244)
            ],
          ),
        ),
        child: FutureBuilder(
          future: getPicturesInfo(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.all(15),
                    elevation: 15,
                    shadowColor: Colors.black,
                    color: const Color.fromARGB(255, 10, 174, 244),
                    child: Column(                          
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.file(
                          File(snapshot.data?[index]['url']),
                          width: MediaQuery.sizeOf(context).width,
                        ),
                        const SizedBox(height: 5),
                        const Text('DETALLES:',
                        style: TextStyle(
                        color: Color.fromARGB(255, 239, 245, 247),
                        fontFamily: 'Mooli',
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),),
                      const SizedBox(height: 5),
                        Text('Imagen No.$index',
                        style: const TextStyle(
                        color: Color.fromARGB(255, 239, 245, 247),
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                      ),),
                        Text('URL: ${snapshot.data?[index]['url']}',
                        style: const TextStyle(
                        color: Color.fromARGB(255, 239, 245, 247),
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                      ),),
                        Text('Timestamp: ${snapshot.data![index]['timestamp'].toDate()}',
                        style: const TextStyle(
                        color: Color.fromARGB(255, 239, 245, 247),
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                      ),),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 242, 119, 25) ,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CameraPage()));
        },
        label: const Text(
          'Take Photo',
            style: TextStyle(
            color: Color.fromARGB(255, 239, 245, 247),
            fontFamily: 'QuickSand',
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
        icon: const Icon(Icons.photo_camera_rounded),
      ),
    );
  }
}