import 'package:flutter/material.dart';

class ApprovalWidget extends StatelessWidget {
  const ApprovalWidget({
    super.key,
    this.title,
    this.description,
    required this.onApprove,
  });
  final String? title;
  final String? description;
  final VoidCallback onApprove;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.black),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title ?? '',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (title != null) const SizedBox(height: 15),
              if (description != null) Text(description ?? ''),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: onApprove,
                    child: const Text('Yes'),
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
