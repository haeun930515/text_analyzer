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
      var renderObject = globalKey.currentContext?.findRenderObject();
      if (renderObject is RenderRepaintBoundary) {
        var boundary = renderObject;
        ui.Image image = await boundary.toImage();
        final directory = (await getApplicationDocumentsDirectory()).path;
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List? pngBytes = byteData?.buffer.asUint8List();
        print(pngBytes);
        File imgFile = File('$directory/screenshot.png');
        imgFile.writeAsBytes(pngBytes!);
        print("FINISH CAPTURE ${imgFile.path}");
        completer.complete(imgFile.path);
      } else {
        completer.completeError("Could not capture the image.");
      }
    });
    return completer.future;
  }
}
