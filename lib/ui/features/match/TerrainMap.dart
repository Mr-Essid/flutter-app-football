import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_flutter_football/utils/LatLngWapper.dart';


class TerrainMap extends StatefulWidget {
  // refactor(addMatchScreen, MatchScreen)


  final List<LatLongWapper> listOfLatLong;

  const TerrainMap({super.key, required this.listOfLatLong});

  @override
  State<TerrainMap> createState() => _TerrainMapState();
}

class _TerrainMapState extends State<TerrainMap> {

  late CameraPosition  cameraPosition;

  @override
  Widget build(BuildContext context) {

    final firstLongLat = widget.listOfLatLong.firstOrNull;
    cameraPosition = CameraPosition(target: firstLongLat?.getLatLng() ?? const LatLng(33, 9.4), zoom: (firstLongLat == null) ? 5 : 15 ) ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terrains Position"),
        leading: IconButton(onPressed: () {
          context.pop();

        }, icon: const Icon(Icons.arrow_back)),
      ),
      body: GoogleMap(
          initialCameraPosition: cameraPosition,
          markers: widget.listOfLatLong.asMap().entries.map((e) =>
               Marker(position: e.value.getLatLng(), markerId: MarkerId(e.value.id_), onTap: () {

                if(widget.listOfLatLong.length > 1) {
                   // this means we are in the addMatch Screen And The Previous screen waiting for id of Match
                    context.pop(e.value.id_);
                }

               })
            ).toSet(),
      ),
    );
  }
}


