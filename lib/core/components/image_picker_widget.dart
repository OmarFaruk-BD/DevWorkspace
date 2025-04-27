import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppImgPicker {
  void pickImage({
    Function(File?)? onImagePick,
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(maxHeight: 150),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 40,
                right: 40,
                bottom: MediaQuery.of(context).padding.bottom + 15,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    text: 'Camera',
                    icon: Icons.camera,
                    onTap: () async {
                      await ImagePicker()
                          .pickImage(source: ImageSource.camera)
                          .then((value) {
                            if (!context.mounted || value == null) return;
                            File? imagePath = File(value.path);
                            onImagePick?.call(imagePath);
                            Navigator.pop(context);
                          });
                    },
                  ),
                  const SizedBox(width: 20),
                  Container(height: 50, width: 1, color: Colors.white),
                  const SizedBox(width: 20),
                  _buildButton(
                    text: 'Gallery',
                    icon: Icons.photo_library,
                    onTap: () async {
                      await ImagePicker()
                          .pickImage(source: ImageSource.gallery)
                          .then((value) {
                            if (!context.mounted || value == null) return;
                            File? imagePath = File(value.path);
                            onImagePick?.call(imagePath);
                            Navigator.pop(context);
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({
    VoidCallback? onTap,
    required String text,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 5),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(text, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
