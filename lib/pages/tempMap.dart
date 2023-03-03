import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../globals.dart';

class TempMap extends StatefulWidget {
  const TempMap({super.key});

  @override
  State<TempMap> createState() => _TempMapState();
}

class _TempMapState extends State<TempMap> {
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: const MapLatLng(18.5177542, 73.8148826),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(200, 254, 251, 1),
        // border: Border.all(color: COLOR_THEME['primary']!, width: 2)
      ),
      child: SfMaps(
        layers: <MapLayer>[
          MapTileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            initialFocalLatLng: const MapLatLng(18.5074213, 73.7871069),
            initialZoomLevel: 10,
            initialMarkersCount: 1,
            zoomPanBehavior: _zoomPanBehavior,
            markerBuilder: (BuildContext context, int index) {
              return const MapMarker(
                latitude: 18.5177542,
                longitude: 73.8148826,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 20,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
