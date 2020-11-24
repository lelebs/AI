import 'package:ai_ui/services/router.service.dart';
import 'package:ai_ui/utils/scanner.utils.dart';
import 'package:ai_ui/utils/text_detector_painter.dart';
import 'package:camera/camera.dart' as defaultCamera;
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../constants.dart' as Constants;

typedef HandleDetection = Future<dynamic> Function(FirebaseVisionImage image);

class TextRecognizerPage extends StatefulWidget {
  @override
  _TextRecognizerState createState() => _TextRecognizerState();
}

class _TextRecognizerState extends State<TextRecognizerPage> {
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  defaultCamera.CameraController _camera;

  bool _isDetecting = false;

  VisionText _textScanResults;

  final TextRecognizer _textRecognizer =
      FirebaseVision.instance.textRecognizer();

  void _initializeCamera() async {
    var cameras = await defaultCamera.availableCameras();

    final defaultCamera.CameraDescription description = cameras
        .where((element) =>
            element.lensDirection == defaultCamera.CameraLensDirection.back)
        .first;

    _camera = defaultCamera.CameraController(
        description, defaultCamera.ResolutionPreset.high);

    await _camera.initialize();

    _camera.startImageStream((defaultCamera.CameraImage image) {
      if (_isDetecting) return;

      setState(() {
        _isDetecting = true;
      });
      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
        (results) {
          setState(() {
            if (results != null) {
              setState(() {
                _textScanResults = results;
              });
            }
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Future<VisionText> Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _textRecognizer.processImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _camera == null
              ? Container(
                  color: Colors.black,
                )
              : Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: CameraPreview(_camera)),
          _buildResults(_textScanResults),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _camera = null;
          var prefs = FlutterSecureStorage();
          await prefs.write(key: Constants.LastRead, value: _textScanResults.text);
          await GetIt.instance<NavigationService>().navigateTo(Constants.TextConfirmationPage);
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _buildResults(VisionText scanResults) {
    CustomPainter painter;
    print(scanResults);
    if (scanResults != null) {
      final Size imageSize = Size(
        _camera.value.previewSize.height - 100,
        _camera.value.previewSize.width,
      );
      painter = TextDetectorPainter(imageSize, scanResults);

      return CustomPaint(
        painter: painter,
      );
    } else {
      return Container();
    }
  }
}
