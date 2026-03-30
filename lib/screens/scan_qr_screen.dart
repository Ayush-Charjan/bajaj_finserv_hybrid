// import 'package:flutter/material.dart';
// import '../utils/app_colors.dart';

// class ScanQRScreen extends StatelessWidget {
//   const ScanQRScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title:
//             const Text('Scan QR Code', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.flash_on, color: Colors.white),
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Flash toggled')),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 280,
//                     height: 280,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: AppColors.accent, width: 3),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Stack(
//                       children: [
//                         // Corner decorations
//                         Positioned(
//                           top: 0,
//                           left: 0,
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               border: Border(
//                                 top: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                                 left: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 0,
//                           right: 0,
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               border: Border(
//                                 top: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                                 right: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                                 left: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                                 right: BorderSide(
//                                     color: AppColors.accent, width: 5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Center icon
//                         Center(
//                           child: Icon(
//                             Icons.qr_code_scanner,
//                             size: 80,
//                             color: Colors.white.withOpacity(0.5),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   const Text(
//                     'Position QR code within the frame',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Bottom Actions
//           Container(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Upload from gallery')),
//                     );
//                   },
//                   icon: const Icon(Icons.photo_library),
//                   label: const Text('Upload QR from Gallery'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: AppColors.primary,
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../utils/app_colors.dart';

class ScanQRScreen extends StatelessWidget {
  const ScanQRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // CAMERA
          MobileScanner(
            controller: MobileScannerController(),
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              final code = barcode.rawValue;
              if (code != null) {
                print(code);
              }
            },
          ),

          // DARK OVERLAY WITH CUTOUT
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),

                // Transparent scanning area
                Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BORDER
          Center(
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.accent, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // TEXT
          const Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Text(
              'Position QR code within the frame',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
