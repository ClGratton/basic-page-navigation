import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

int currentIndex = 1;
double opacityLevel = 1.0;

Future<void> checkPermission(Permission permission) async {
  final status = await permission.request();
  if (status == true) {
  } else {}
}

class BelloStronzoPage extends StatelessWidget {
  const BelloStronzoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bello Stronzo!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Lo stronzo è stato pubblicato',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 231, 231, 231),
      child: const Center(
        child: Text('Coming soon'),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final TextEditingController titleController = TextEditingController();
  String? formattedTime;
  double rating = 0;
  File? _selectedImage; // Define _selectedImage of type File

  @override
  void initState() {
    super.initState();
    formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      body: AnimatedOpacity(
        opacity: opacityLevel,
        duration: Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedTime!,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
              ),
              const SizedBox(height: 50), //distance of title from status bar
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 121, 134, 203),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: titleController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Titolo della tua opera (opzionale)',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 50), // Increased spacing between Titolo and Rating
              Center(
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 48.0,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 121, 134, 203),
                  ),
                  onRatingUpdate: (ratingValue) {
                    setState(() {
                      rating = ratingValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8.0), // Added spacing
              const Center(
                child: Text(
                  'Dimensione',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 121, 134, 203),
                  ),
                ),
              ),
              const SizedBox(
                  height: 80), // Increased spacing before the photo input area
              Center(
                child: GestureDetector(
                  onTap: () async {
                    print('entering');

                    // Check for available cameras
                    List<CameraDescription> cameras = await availableCameras();
                    if (cameras.isEmpty) {
                      print('No cameras available.');
                      return;
                    }

                    try {
                      // Use the ImagePicker to pick an image from the camera
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      // Handle the picked file as needed
                      if (pickedFile != null) {
                        // Update _selectedImage with the picked image file
                        setState(() {
                          _selectedImage = File(pickedFile.path);
                        });
                        print('Image path: ${pickedFile.path}');
                      } else {
                        print('No image selected.');
                      }
                    } catch (e) {
                      print('Error picking image: $e');
                    }

                    print('exiting');
                  },
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          BorderRadius.circular(15.0), // Rounded corners
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(
                                  _selectedImage!), // Use FileImage to load image from File
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _selectedImage == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 80.0,
                            color: Colors.grey,
                          )
                        : null, // Removed Image.file widget
                  ),
                ),
              ),
              const SizedBox(height: 40), // Added spacing
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    print('Pubblica Stronzo button pressed');

                    // Start the fade out animation by setting the opacity to 0
                    setState(() {
                      opacityLevel = 0.0;
                    });

                    // Delay to show the other page for 5 seconds
                    await Future.delayed(
                        const Duration(milliseconds: 500), () {});

                    // Navigate to the BelloStronzoPage
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BelloStronzoPage(),
                      ),
                    );

                    // Restore the opacity to 1 after navigating to the new page
                    setState(() {
                      opacityLevel = 1.0;
                    });

                    // Delay to show BelloStronzoPage for 5 seconds
                    await Future.delayed(const Duration(seconds: 3), () {});

                    // Navigate back to the original page
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(255, 121, 134, 203), // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), // Button border radius
                    ),
                  ),
                  child: const Text(
                    'Pubblica Stronzo',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 231, 231, 231),
      child: const Center(
        child: Text('Coming soon'),
      ),
    );
  }
}
