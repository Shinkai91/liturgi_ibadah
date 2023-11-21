import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  const PDFViewerPage ({super.key});
  final String pdfPath = 'assets/documents/sample1.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
        enableSwipe: true, // Enable swipe gestures
        swipeHorizontal: true, // Swipe horizontally
        autoSpacing: false, // Adjust spacing between pages automatically
        pageFling: false, // Enable fling animation
        onPageChanged: (int? page, int? total) {  // Updated type to int?
          if (page != null && total != null) {  // Ensure values are not null
            if (kDebugMode) {
              print('Page $page/$total');
            }
          }
        },
      ),
    );
  }
}