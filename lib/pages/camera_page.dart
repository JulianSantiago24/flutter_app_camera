import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_camera/pages/home_page.dart';
import 'package:flutter_app_camera/services/firestore_service.dart';
import 'package:flutter_app_camera/services/upload_image_service.dart';
import 'package:flutter_app_camera/utils/file_utils.dart';
import 'package:camerawesome/camerawesome_plugin.dart';


class CameraPage extends StatelessWidget {
  const CameraPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photoAndVideo(
            photoPathBuilder: () => path(CaptureMode.photo),
            videoPathBuilder: () => path(CaptureMode.video),
            initialCaptureMode: CaptureMode.photo,
          ),
          enablePhysicalButton: true,
          filter: AwesomeFilter.AddictiveRed,
          flashMode: FlashMode.auto,
          aspectRatio: CameraAspectRatios.ratio_16_9,
          previewFit: CameraPreviewFit.fitWidth,
          onMediaTap: (mediaCapture) async {
            await uploadImage(File(mediaCapture.filePath));
            addPicturesInfo(mediaCapture.filePath, Timestamp.fromDate(DateTime.now()));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
    );
  }
}
