import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Capture {
  Future<String> capture(GlobalKey globalKey) async {
    print("START CAPTURE");
    Completer<String> completer = Completer<String>();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        var renderObject = globalKey.currentContext?.findRenderObject();
        if (renderObject is RenderRepaintBoundary) {
          var boundary = renderObject;
          ui.Image image = await boundary.toImage();
          final directory = await getTemporaryDirectory();
          String imagePath = '${directory.path}/screenshot.png';
          File imgFile = File(imagePath);
          Uint8List? pngBytes = await image
              .toByteData(format: ui.ImageByteFormat.png)
              .then((byteData) => byteData?.buffer.asUint8List());
          await imgFile.writeAsBytes(pngBytes!);
          print("FINISH CAPTURE $imagePath");
          completer.complete(imagePath);
        } else {
          completer.completeError("Could not capture the image.");
        }
      } catch (error) {
        completer.completeError("Error capturing the image: $error");
      }
    });
    return completer.future;
  }
}
