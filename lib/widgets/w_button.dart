import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isEnabled;

  const WidgetButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isEnabled
            ? Text(label)
            : const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
              ),
      ),
    );
  }
}
