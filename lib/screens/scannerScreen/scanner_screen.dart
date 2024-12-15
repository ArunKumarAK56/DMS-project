// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
//
//
//
//
// class ScannerScreen extends StatefulWidget {
//   const ScannerScreen({super.key});
//
//   @override
//   State<ScannerScreen> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<ScannerScreen> {
//   String barcode = 'Tap  to scan';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('QR Scanner')),
//       body: MobileScanner(
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           for (final barcode in barcodes) {
//             debugPrint('QR Code Found: ${barcode.rawValue}');
//           }
//         },
//       ),
//     );
//
//
//
//
//     Scaffold(
//       appBar: AppBar(
//         title: const Text(' Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               child: const Text('Scan Barcode'),
//               onPressed: () async {
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => AiBarcodeScanner(
//                       onDispose: () {
//                         /// This is called when the barcode scanner is disposed.
//                         /// You can write your own logic here.
//                         debugPrint("Barcode scanner disposed!");
//                       },
//                       hideGalleryButton: false,
//                       controller: MobileScannerController(
//                         detectionSpeed: DetectionSpeed.noDuplicates,
//                       ),
//                       onDetect: (BarcodeCapture capture) {
//                         /// The row string scanned barcode value
//                         final String? scannedValue =
//                             capture.barcodes.first.rawValue;
//                         debugPrint("Barcode scanned: $scannedValue");
//
//                         /// The `Uint8List` image is only available if `returnImage` is set to `true`.
//                         final Uint8List? image = capture.image;
//                         debugPrint("Barcode image: $image");
//
//                         /// row data of the barcode
//                         final Object? raw = capture.raw;
//                         debugPrint("Barcode raw: $raw");
//
//                         /// List of scanned barcodes if any
//                         final List<Barcode> barcodes = capture.barcodes;
//                         debugPrint("Barcode list: $barcodes");
//                       },
//                       validator: (value) {
//                         if (value.barcodes.isEmpty) {
//                           return false;
//                         }
//                         if (!(value.barcodes.first.rawValue
//                             ?.contains('flutter.dev') ??
//                             false)) {
//                           return false;
//                         }
//                         return true;
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Text(barcode),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _qrData; // To store the scanned QR data

  @override
  void initState() {
    super.initState();

    // Animation controller for scan line movement
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Time for the line to move
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // QR Scanner
          MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final String? qrData = barcodes.first.rawValue;

              if (qrData != null && qrData.isNotEmpty) {
                setState(() {
                  _qrData = qrData; // Store the scanned QR data
                });
              }
            },
          ),
          _buildOverlay(),
          if (_qrData != null && _qrData!.isNotEmpty)
            Positioned(
              bottom: 40,
              left: 50,
              right: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _qrData); // Return the scanned data
                },
                child: Text('Back with QR Data'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        Center(
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2,),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.transparent,
            ),
          ),
        ),
        // Moving scan line
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: ScanLinePainter(
                  position: _animation.value,
                  areaHeight: 400,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Custom painter for the moving scan line
class ScanLinePainter extends CustomPainter {
  final double position;
  final double areaHeight;

  ScanLinePainter({required this.position, required this.areaHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    // Calculate the y position of the scan line based on the animation value
    final y = size.height / 2 - areaHeight / 2 + position * areaHeight;

    // Draw the scan line
    canvas.drawLine(
      Offset(size.width / 2 - 200, y), // Line start (adjust for width)
      Offset(size.width / 2 + 200, y), // Line end
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
