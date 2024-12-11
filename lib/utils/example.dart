import 'package:flutter/material.dart';

import '../ui/features/match/MatchComponent.dart';


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("MatchCard Example")),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: MatchCard(
//             match: OwnMatch(
//               date: "2023-12-08T18:00:00",
//               labelOfTerrain: "soccer field",
//               isMine: true,
//               playersCount: 10,
//               price: 50.0,
//             ),
//             onClick: () {
//               // Handle onClick
//               print("MatchCard clicked!");
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
class AnimatedBottomNavigationBarExample extends StatefulWidget {
  @override
  _AnimatedBottomNavigationBarExampleState createState() =>
      _AnimatedBottomNavigationBarExampleState();
}

class _AnimatedBottomNavigationBarExampleState
    extends State<AnimatedBottomNavigationBarExample> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Bottom Navigation Bar'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildAnimatedPage(Colors.red, 'Home'),
          _buildAnimatedPage(Colors.blue, 'Search'),
          _buildAnimatedPage(Colors.green, 'Profile'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut, // Smooth animation curve
          );
          // setState(() {
          //   _currentIndex = index;
          // });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildAnimatedPage(Color color, String label) {
    return Container(
      color: color,
      child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
    );
  }
}
