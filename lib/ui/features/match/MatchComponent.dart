import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:project_flutter_football/models/match_model.dart';

import '../../../constaints.dart';


Widget _buildInfoColumn(
    BuildContext context, {
      required IconData icon,
      required String title,
      required String value,
    }) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 24, color: Colors.grey),
      const SizedBox(height: 4),
      Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 14),
      ),
    ],
  );
}
class MatchUIRepresentation {
  final String date;
  final String labelOfTerrain;
  final bool isMine;
  final int playersCount;
  final String price;
  final Function() onClick;

  MatchUIRepresentation({
    required this.date,
    required this.labelOfTerrain,
    required this.isMine,
    required this.playersCount,
    required this.price,
    required this.onClick
  });
}




// Widget MatchCardModel(BuildContext context, OwnMatch matchModel, Function() onClick) {
//   final match = matchModel.toOwnMatchCardModel();
//
//   final dateTime = parseDate(match.date);
//
//   return Card(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//     elevation: 4,
//     clipBehavior: Clip.antiAlias,
//     child: InkWell(
//       onTap: onClick,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 24, color: Colors.grey),
//                     const SizedBox(width: 8),
//                     Text(
//                       match.labelOfTerrain[0].toUpperCase() +
//                           match.labelOfTerrain.substring(1),
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (match.isMine)
//                   Row(
//                     children: [
//                       const Icon(Icons.person_outline, size: 18, color: Colors.grey),
//                       const SizedBox(width: 4),
//                       Text(
//                         "Mine",
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             const Divider(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.access_time,
//                   title: "Time",
//                   value: dateTime['time'] ?? "unset",
//                 ),
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.calendar_month,
//                   title: "Date",
//                   value: dateTime['date'] ?? "unset",
//                 ),
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.people_outline,
//                   title: "Members",
//                   value: "${match.playersCount + 1}",
//                 ),
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.price_check,
//                   title: "Join price",
//                   value: "\$${match.price}",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }






class MatchComponent extends StatefulWidget {
  final MatchUIRepresentation uiRepresentation;

  const MatchComponent({super.key, required this.uiRepresentation});



  @override
  State<MatchComponent> createState() => _MatchComponentState();
}

class _MatchComponentState extends State<MatchComponent> {
  @override
  Widget build(BuildContext context) {


  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: widget.uiRepresentation.onClick,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 24, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      widget.uiRepresentation.labelOfTerrain[0].toUpperCase() +
                          widget.uiRepresentation.labelOfTerrain.substring(1),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (widget.uiRepresentation.isMine)
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "Mine",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(
                  context,
                  icon: Icons.access_time,
                  title: "Time",
                  value: parseDate(widget.uiRepresentation.date)['date'] ?? "unset"
                ),
                _buildInfoColumn(
                  context,
                  icon: Icons.calendar_month,
                  title: "Date",
                  value: parseDate(widget.uiRepresentation.date)['time'] ?? "unset"
                ),
                _buildInfoColumn(
                  context,
                  icon: Icons.people_outline,
                  title: "Members",
                  value: "${widget.uiRepresentation.playersCount + 1}",
                ),
                _buildInfoColumn(
                  context,
                  icon: Icons.price_check,
                  title: "Join price",
                  value: "\$${widget.uiRepresentation.price}",
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  }
}


// Widget MatchCardModelPrimary(BuildContext context, Match matchModel, Function() onClick) {
//   final match = matchModel.toOwnMatchActivities().toOwnMatchCardModel();
//
//   final dateTime = parseDate(match.date);
//
//   return Card(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//     elevation: 4,
//     clipBehavior: Clip.antiAlias,
//     child: InkWell(
//       onTap: onClick,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 24, color: Colors.grey),
//                     const SizedBox(width: 8),
//                     Text(
//                       match.labelOfTerrain[0].toUpperCase() +
//                           match.labelOfTerrain.substring(1),
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (match.isMine)
//                   Row(
//                     children: [
//                       const Icon(Icons.person_outline, size: 18, color: Colors.grey),
//                       const SizedBox(width: 4),
//                       Text(
//                         "Mine",
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             const Divider(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.access_time,
//                   title: "Time",
//                   value: dateTime['time'] ?? "unset",
//                 ),
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.calendar_month,
//                   title: "Date",
//                   value: dateTime['date'] ?? "unset",
//                 ),
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.people_outline,
//                   title: "Members",
//                   value: "${match.playersCount + 1}",
//                 ),
//                 _buildInfoColumn(
//                   context,
//                   icon: Icons.price_check,
//                   title: "Join price",
//                   value: "\$${match.price}",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
