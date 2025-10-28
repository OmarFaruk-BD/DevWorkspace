import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class RouteMapPage extends StatefulWidget {
  const RouteMapPage({super.key});

  @override
  State<RouteMapPage> createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  late MapController controller;

  final GeoPoint dhaka = GeoPoint(latitude: 23.8041, longitude: 90.4152);
  final GeoPoint chittagong = GeoPoint(latitude: 22.3752, longitude: 91.8349);

  @override
  void initState() {
    super.initState();
    controller = MapController(initPosition: dhaka);
  }

  Future<void> _drawRoute() async {
    await controller.addMarker(
      dhaka,
      markerIcon: MarkerIcon(
        icon: Icon(Icons.location_pin, color: Colors.green, size: 48),
      ),
    );

    await controller.addMarker(
      chittagong,
      markerIcon: MarkerIcon(
        icon: Icon(Icons.location_pin, color: Colors.blue, size: 48),
      ),
    );

    await controller.drawRoad(
      dhaka,
      chittagong,
      roadType: RoadType.car,
      roadOption: RoadOption(roadColor: Colors.red, roadWidth: 6),
    );

    await controller.zoomToBoundingBox(
      BoundingBox(
        north: dhaka.latitude,
        east: dhaka.longitude,
        south: chittagong.latitude,
        west: chittagong.longitude,
      ),
      paddinInPixel: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dhaka → Chittagong Route")),
      body: OSMFlutter(
        controller: controller,
        onMapIsReady: (value) async {
          await Future.delayed(const Duration(seconds: 1));
          await _drawRoute();
        },
        osmOption: OSMOption(
          isPicker: false,
          zoomOption: ZoomOption(
            initZoom: 7,
            maxZoomLevel: 18,
            minZoomLevel: 3,
          ),
        ),
      ),
    );
  }
}
