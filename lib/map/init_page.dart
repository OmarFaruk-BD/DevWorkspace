import 'package:flutter/material.dart';
import 'package:workspace/map/map_page.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_button.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:workspace/core/components/app_snack_bar.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  final GeoPoint initPosition = GeoPoint(latitude: 23.8041, longitude: 90.4152);
  GeoPoint? startPoint;
  GeoPoint? endPoint;

  String get buttonText {
    if (startPoint == null) return "Pick Start Point";
    if (endPoint == null) return "Pick End Point";
    return "Go To Map Page";
  }

  Future<void> handleTap() async {
    if (startPoint == null) {
      final result = await showSimplePickerLocation(
        radius: 12,
        context: context,
        isDismissible: true,
        title: 'Pick Start Point',
        textConfirmPicker: 'Pick',
        initPosition: initPosition,
        zoomOption: const ZoomOption(initZoom: 12),
      );
      if (result != null) setState(() => startPoint = result);
    } else if (endPoint == null) {
      final result = await showSimplePickerLocation(
        radius: 12,
        context: context,
        isDismissible: true,
        title: 'Pick End Point',
        textConfirmPicker: 'Pick',
        initPosition: initPosition,
        zoomOption: const ZoomOption(initZoom: 12),
      );
      if (result != null) setState(() => endPoint = result);
    } else {
      if (startPoint == null || endPoint == null) {
        AppSnackBar.show(context, 'Please select start and end point');
        return;
      }
      AppNavigator.push(
        context,
        MapPage(startPoint: startPoint!, endPoint: endPoint!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Street Map'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Pick start and end point to go to map page',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          if (startPoint != null) ...[
            Text(
              'Start: ${startPoint!.latitude}, ${startPoint!.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],

          if (endPoint != null) ...[
            Text(
              'End: ${endPoint!.latitude}, ${endPoint!.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
          AppButton(radius: 50, text: buttonText, onTap: handleTap),
        ],
      ),
    );
  }
}

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 23.8041, longitude: 90.4152),
  );

  GeoPoint? pickedPoint;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text('Pick Location', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Expanded(
              child: OSMFlutter(
                controller: controller,
                osmOption: OSMOption(
                  zoomOption: const ZoomOption(
                    initZoom: 7,
                    minZoomLevel: 3,
                    maxZoomLevel: 18,
                  ),
                ),
                onGeoPointClicked: (geoPoint) {
                  setState(() => pickedPoint = geoPoint);
                  controller.addMarker(
                    geoPoint,
                    markerIcon: const MarkerIcon(
                      icon: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 56,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      radius: 50,
                      vPadding: 10,
                      text: 'Cancel',
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppButton(
                      radius: 50,
                      vPadding: 10,
                      text: 'Pick',
                      onTap: () => Navigator.pop(context, pickedPoint),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
