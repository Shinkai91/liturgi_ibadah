import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liturgi_ibadah/data/kidung_songs.dart';
import 'package:liturgi_ibadah/data/pkj_songs.dart';
import 'package:liturgi_ibadah/data/nkb_songs.dart';
import 'package:liturgi_ibadah/widgets/search_bar.dart';
import 'package:liturgi_ibadah/models/song.dart';

class KidungScreen extends StatefulWidget {
  const KidungScreen({super.key});

  @override
  State<KidungScreen> createState() => _KidungScreenState();
}

class _KidungScreenState extends State<KidungScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _suggestions = [];
  int currentIndex = 0;

  double originalFontSize = 32.0;
  double currentScale = 0.5;
  final double maxScale = 2.7;
  final double minScale = 1.0;

  List<Song> _currentSongList = []; // Initialize with an empty list
  
  @override
  void initState() {
    super.initState();
    _updateSuggestions(kJSongs);
    _currentSongList.addAll(kJSongs);
    _currentSongList = kJSongs;
  }

  void _updateSuggestions(List<Song> songs) {
    _suggestions.clear();
    _suggestions.addAll(songs.map((song) => song.judul));
  }

  void _changeSong(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  Song? _findSongByTitle(String title) {
    return _currentSongList.firstWhereOrNull((song) => song.judul == title);
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
            'Kidung Pujian',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            DropdownButton<String>(
              value: _currentSongList == kJSongs
                  ? 'KJ'
                  : _currentSongList == pKJSongs
                      ? 'PKJ'
                      : 'NKB',
              onChanged: (value) {
                setState(() {
                  switch (value) {
                    case 'KJ':
                      _currentSongList = kJSongs;
                      break;
                    case 'PKJ':
                      _currentSongList = pKJSongs;
                      break;
                    case 'NKB':
                      _currentSongList = nKBSongs;
                      break;
                  }
                  currentIndex = 0;
                  _updateSuggestions(_currentSongList);
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'KJ',
                  child: Text(
                    'KJ',
                    style: TextStyle(color: Colors.black), // Set text color to white
                  ),
                ),
                DropdownMenuItem(
                  value: 'PKJ',
                  child: Text(
                    'PKJ',
                    style: TextStyle(color: Colors.black), // Set text color to white
                  ),
                ),
                DropdownMenuItem(
                  value: 'NKB',
                  child: Text(
                    'NKB',
                    style: TextStyle(color: Colors.black), // Set text color to white
                  ),
                ),
              ],
            ),
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
                    _changeSong(_currentSongList.indexOf(selectedSong));
                  }
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.grey[200], // Ganti warna latar belakang
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
                          _currentSongList[currentIndex].judul,
                          style: TextStyle(
                            fontSize: originalFontSize * currentScale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _currentSongList[currentIndex].lagu,
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