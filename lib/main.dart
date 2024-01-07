import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:flutter/services.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

void main() async {
  await onStart();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color.fromARGB(255, 121, 134, 203), // navigation bar color
    statusBarColor: Color.fromARGB(255, 231, 231, 231), // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

void startCamera() async {
  var cameras = await availableCameras();
  var cameraController = CameraController(
    cameras[0],
    ResolutionPreset.high,
    enableAudio: false,
  );
  await cameraController.initialize().then((value) {}).catchError((e) {
    print('error');
  });
}

onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  startCamera();
  print('setup complete');
}
