import 'package:flutter/material.dart';
import 'package:workspace/core/components/app_popup.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> location(BuildContext context) async {
    final permissionStatus = await Permission.locationWhenInUse.status;
    if (permissionStatus.isDenied) {
      await Permission.locationWhenInUse.request();
    } else if (permissionStatus.isPermanentlyDenied) {
      if (!context.mounted) return false;
      AppPopup().approval(
        context: context,
        title: 'Location Permission',
        description: 'Please enable location permission to use this feature.',
        onApprove: () {
          openAppSettings();
          Navigator.of(context).pop();
        },
      );
      return false;
    }
    return permissionStatus.isGranted;
  }

  Future<bool> storage(BuildContext context) async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      if (!context.mounted) return false;
      AppPopup().approval(
        context: context,
        title: 'Storage Permission',
        description: 'Please enable storage permission to use this feature.',
        onApprove: () {
          openAppSettings();
          Navigator.of(context).pop();
        },
      );
      return false;
    }
    return status.isGranted;
  }
}
