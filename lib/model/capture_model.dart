import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Capture {
  Future<String> capture(GlobalKey globalKey) async {
    print("START CAPTURE");
    Completer<String> completer = Completer<String>();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        var renderObject = globalKey.currentContext?.findRenderObject();
        try {
          // var boundary = renderObject;
          // ui.Image image = await boundary.toImage();
          // final directory = await getTemporaryDirectory();
          // String imagePath = '${directory.path}/screenshot.png';
          // File imgFile = File(imagePath);
          // Uint8List? pngBytes = await image
          //     .toByteData(format: ui.ImageByteFormat.png)
          //     .then((byteData) => byteData?.buffer.asUint8List());
          // await imgFile.writeAsBytes(pngBytes!);
          // print("FINISH CAPTURE $imagePath");
          // completer.complete(imagePath);
        } catch (error) {
          print("Error capture : $error");
        }
      } catch (error) {
        completer.completeError("Error capturing the image: $error");
      }
    });
    return completer.future;
  }
}
