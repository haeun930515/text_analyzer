import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_analyzer/model/capture_model.dart';
import 'package:flutter_share/flutter_share.dart';

class ImageShareProvider extends ChangeNotifier {
  Future<void> imageShare(String imagePath) async {
    await FlutterShare.shareFile(title: '결과 공유하기', filePath: imagePath);
  }
}

class ImageShareButton extends StatelessWidget {
  GlobalKey globalKey;
  ImageShareButton({
    super.key,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    ImageShareProvider imageShareProvider =
        Provider.of<ImageShareProvider>(context, listen: false);
    Capture capture = Capture();
    return InkWell(
        onTap: () async {
          String imagePath = await capture.capture(globalKey);
          await imageShareProvider.imageShare(imagePath);
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.share),
        ));
  }
}
