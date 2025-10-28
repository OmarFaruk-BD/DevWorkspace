import 'package:flutter/material.dart';
import 'package:workspace/map/map_page.dart';
import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_button.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
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
            onTap: () => AppNavigator.push(context, const MapPage()),
          ),
          const SizedBox(height: 20),
          AppButton(
            radius: 50,
            text: 'Go To Route Map Page',
            onTap: () => AppNavigator.push(context, const MapPage()),
          ),
        ],
      ),
    );
  }
}
