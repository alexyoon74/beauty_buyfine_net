import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<dynamic> loadingBar({
  required String label,
  bool barrierDismissible = false,
  Color? loadingColor,
  Color? barrierColor,
}) {
  loadingColor ??= Colors.orange[900];
  barrierColor ??= Colors.black.withOpacity(0.3);
  return Get.dialog(
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: loadingColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(label),
          ],
        ),
      ),
    ),
  );
}
