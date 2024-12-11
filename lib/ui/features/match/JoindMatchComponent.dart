

import 'package:flutter/material.dart';
import 'package:project_flutter_football/models/fucking_match_model/JoinedMatch.dart';
import 'package:project_flutter_football/models/match_model.dart';

import '../../../constaints.dart';

// Widget SingleMatchCardX(BuildContext context, JointedMatch jointedMatch, Function() onClick) {
//   final match = jointedMatch.toJointedMatchUiCompoonent();
//   final dateTime = parseDate(match.date);
//
//   return Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     color: match.isAccepted ? const Color(0xFFDFF8E1) : const Color(0xFFFBEAEF),
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 match.isAccepted ? "Accepted" : "Pending",
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: match.isAccepted ? const Color(0xFF388E3C) : const Color(0xFFD32F2F),
//                 ),
//               ),
//               const SizedBox(height: 4.0),
//               Text(
//                 "Date: ${dateTime['date']}",
//                 style: const TextStyle(fontSize: 14.0, color: Colors.grey),
//               ),
//               Text(
//                 "Time: ${dateTime['time']}",
//                 style: const TextStyle(fontSize: 14.0, color: Colors.grey),
//               ),
//             ],
//           ),
//           Text(
//             "Players: ${match.playersCount}",
//             style: const TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

class JoinedMatchComponentCard extends StatefulWidget {
  final JoinedMatchModel joinedMatchModel;

  const JoinedMatchComponentCard({super.key, required this.joinedMatchModel});

  @override
  State<JoinedMatchComponentCard> createState() => _JoinedMatchComponentState();
}

class _JoinedMatchComponentState extends State<JoinedMatchComponentCard> {
  @override
  Widget build(BuildContext context) {
    final dateTime = parseDate(widget.joinedMatchModel.match.date.toString());
     return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    color: widget.joinedMatchModel.isAccepted ? const Color(0xFFDFF8E1) : const Color(0xFFFBEAEF),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.joinedMatchModel.isAccepted ? "Accepted" : "Pending",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: widget.joinedMatchModel.isAccepted ? const Color(0xFF388E3C) : const Color(0xFFD32F2F),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                "Date: ${dateTime['date']}",
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              Text(
                "Time: ${dateTime['time']}",
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
          Text(
            "Players: ${widget.joinedMatchModel.match.playersOfMatch.length + 1}",
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );

  }
}




class JoinedMatchUIModel {
  final bool isAccepted;
  final String date;
  final int playersCount;

  JoinedMatchUIModel({
    required this.isAccepted,
    required this.date,
    required this.playersCount,
  });
}