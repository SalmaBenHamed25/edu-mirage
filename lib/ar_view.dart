import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARViewScreen extends StatefulWidget {
  const ARViewScreen({super.key});

  @override
  _ARViewScreenState createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("عرض المجسم ثلاثي الأبعاد")),
      body: ARView(
        onARViewCreated: onARViewCreated,
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) async {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;

    arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "assets/triangle.png", // تقدري تحذفيه لو مش محتاجاته
      showWorldOrigin: true,
    );
    arObjectManager.onInitialize();

    // إضافة المجسم ثلاثي الأبعاد
    var newNode =ARNode(
  type: NodeType.localGLTF2,
  uri: "assets/models/digestive_system.glb",
  scale: vector.Vector3(0.2, 0.2, 0.2),
  position: vector.Vector3(0.0, 0.0, -1.0),
  rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
);

    

    bool? didAdd = await arObjectManager.addNode(newNode);
    print("تمت إضافة المجسم؟ $didAdd");
  }

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }
}
