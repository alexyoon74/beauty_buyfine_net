import 'package:flutter/material.dart';

class PublicFunc {
  Widget loadingBar({
    required BuildContext context,
    required String label,
  }) {
    // debugPrint(
    //     '${MediaQuery.of(context).size.height} / ${MediaQuery.of(context).padding.top} / ${MediaQuery.of(context).padding.bottom}');
    return SizedBox(
      height: MediaQuery.of(context).padding.top > 0 ||
              MediaQuery.of(context).padding.bottom > 0
          ? MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              190
          : MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16.0),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String getPathStr({
    required String str,
  }) {
    int uid = int.parse(str);
    String fileName = uid.toString().padLeft(7, '0');
    int filePath1 = uid % 5;
    String filePath2 = fileName.substring(0, 2);
    String filePath3 = fileName.substring(2, 4);
    String filePath = "/$filePath1/$filePath2/$filePath3/";

    return filePath;
  }
}
