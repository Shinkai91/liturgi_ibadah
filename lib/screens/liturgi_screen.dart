import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class LiturgiScreen extends StatefulWidget {
  const LiturgiScreen({super.key});

  @override
  State<LiturgiScreen> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<LiturgiScreen> {
  late PdfControllerPinch pdfControllerPinch;

  int totalPagesCount = 0;
  int currentPages = 1;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/documents/tata_ibadah.pdf'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liturgi Ibadah",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.white,
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text('$currentPages/$totalPagesCount'),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            pdfControllerPinch.previousPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          } else if (details.primaryVelocity! < 0) {
            pdfControllerPinch.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          }
        },
        child: PdfViewPinch(
          scrollDirection: Axis.horizontal,
          controller: pdfControllerPinch,
          onDocumentLoaded: (document) {
            setState(() {
              totalPagesCount = document.pagesCount;
            });
          },
          onPageChanged: (page) {
            setState(() {
              currentPages =
                  page;
            });
          },
        ),
      ),
    );
  }
}
