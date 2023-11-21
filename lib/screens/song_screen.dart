import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liturgi_ibadah/data/data_song.dart';
import 'package:liturgi_ibadah/widgets/search_bar.dart';
import 'package:liturgi_ibadah/models/song.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _suggestions = [];
  int currentIndex = 0;

  double originalFontSize = 32.0; // Original font size
  double currentScale = 0.5; // Current scale
  final double maxScale = 2.7; // Upper limit for scaling
  final double minScale = 1.0; // Lower limit for scaling

  @override
  void initState() {
    super.initState();
    _suggestions.addAll(dummySong.map((song) => song.judul));
  }

  void _changeSong(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  Song? _findSongByTitle(String title) {
    return dummySong.firstWhereOrNull((song) => song.judul == title);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liturgi Ibadah',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Lagu Pujian',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                final selectedValue = await showSearch(
                  context: context,
                  delegate: SearchBarDelegate(_suggestions),
                );
                if (selectedValue != null) {
                  final selectedSong = _findSongByTitle(selectedValue);
                  if (selectedSong != null) {
                    _changeSong(dummySong.indexOf(selectedSong));
                  }
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onScaleStart: (details) {
                    originalFontSize = currentScale * 16.0;
                  },
                  onScaleUpdate: (details) {
                    double newScale = currentScale * details.scale;
                    if (newScale > maxScale) {
                      newScale = maxScale;
                    } else if (newScale < minScale) {
                      newScale = minScale;
                    }
                    setState(() {
                      currentScale = newScale;
                    });
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 16.0,
                        ),
                        child: Text(
                          dummySong[currentIndex].judul,
                          style: TextStyle(
                            fontSize: originalFontSize * currentScale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          dummySong[currentIndex].lagu,
                          style: TextStyle(
                            fontSize: originalFontSize * currentScale,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}