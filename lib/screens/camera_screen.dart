import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:otus_food/theme_data.dart';

// Экран камеры
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<CameraScreen> createState() => _CameraState();
}

class _CameraState extends State<CameraScreen> {
  late CameraController cameraController;
  late Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.neutralColor6,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.canvasColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.neutralColor6,
      ),
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(cameraController);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "takePicture", // чтобы не было ошибок при переходе на другие экраны с FloatingActionButton
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await cameraController.takePicture();
                if (!mounted) return;
                Navigator.pop(context, image.path);
              } catch (_) {}
            },
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
