// homepage.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'pages.dart';

//import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
//import 'package:flutter_emoji/flutter_emoji.dart'; // Import flutter_emoji

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: const [
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Container(
                color: const Color.fromARGB(255, 121, 134, 203),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 20, bottom: 20),
                  child: GNav(
                    duration: const Duration(milliseconds: 500),
                    backgroundColor: const Color.fromARGB(255, 121, 134, 203),
                    color: const Color.fromARGB(255, 117, 67, 67),
                    activeColor: const Color.fromARGB(255, 121, 134, 203),
                    tabBackgroundColor: Colors.white,
                    gap: 10,
                    selectedIndex: currentIndex,
                    onTabChange: (index) {
                      if (kDebugMode) {
                        print(index);
                      }
                      setState(() {
                        currentIndex = index;
                      });
                      _pageController.jumpToPage(index);
                    },
                    padding: const EdgeInsets.all(7),
                    tabs: const [
                      GButton(
                        icon: Icons.vertical_split_rounded,
                        text: "Feed",
                      ),
                      GButton(
                        icon: Icons.add_circle_rounded,
                        text: "Nuovo Stronzo",
                      ),
                      GButton(
                        icon: Icons.trending_up_rounded,
                        text: "Classifica",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
