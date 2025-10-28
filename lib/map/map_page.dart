import 'package:flutter/material.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapInitPage extends StatefulWidget {
  const MapInitPage({super.key});

  @override
  State<MapInitPage> createState() => _MapInitPageState();
}

class _MapInitPageState extends State<MapInitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OSM Flutter")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          AppButton(
            radius: 50,
            text: 'Go To Map Page',
            onTap: () => AppNavigator.push(context, const RouteMapPage()),
          ),
          const SizedBox(height: 20),
          AppButton(
            radius: 50,
            text: 'Go To Route Map Page',
            onTap: () => AppNavigator.push(context, const RouteMapPage()),
          ),
        ],
      ),
    );
  }
}

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
      paddinInPixel: 80,
    );

    await _moveCarAlongRoad();
  }

  Future<void> _moveCarAlongRoad() async {
    RoadInfo roadInfo = await controller.drawRoad(
      dhaka,
      chittagong,
      roadType: RoadType.car,
      roadOption: RoadOption(roadColor: Colors.red, roadWidth: 6),
    );

    List<GeoPoint> points = roadInfo.route;

    await controller.addMarker(
      points.first,
      markerIcon: MarkerIcon(
        icon: Icon(Icons.directions_car, color: Colors.black, size: 45),
      ),
    );
    GeoPoint oldPoint = points.first;

    for (int i = 1; i < points.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      GeoPoint newPoint = points[i];
      await controller.changeLocationMarker(
        oldLocation: oldPoint,
        newLocation: newPoint,
      );
      // await controller.moveTo(newPoint);
      oldPoint = newPoint;
    }
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
