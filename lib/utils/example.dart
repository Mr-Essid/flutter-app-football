import 'package:flutter/material.dart';
import 'package:project_flutter_football/ui/features/match/TerrainMap.dart';

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
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Bottom Navigation Bar'),
      ),
      body: const Text(""),
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
