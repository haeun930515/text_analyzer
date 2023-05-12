import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextFromImageProvider with ChangeNotifier {
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.korean);
  String inputTxt = "";

  String get getTxtInput => inputTxt;

  getImageFromGallery() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    var inputImage = InputImage.fromFilePath(image!.path);

    String inputText = "";

    TextLine line;
    final recognizedText = await _textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (line in block.lines) {
        inputText += line.text;
      }
    }
    inputTxt = inputText;
    notifyListeners();
    print(inputTxt);
  }
}
