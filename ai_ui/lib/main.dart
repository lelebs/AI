import 'package:ai_ui/scanner.utils.dart';
import 'package:camera/camera.dart' as defaultCamera;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

VisionText _textScanResults;

void main() {
  runApp(MyApp());
}

typedef HandleDetection = Future<dynamic> Function(FirebaseVisionImage image);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ));
  }
}
