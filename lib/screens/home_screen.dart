import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'package:liturgi_ibadah/screens/kidung_screen.dart';
import 'package:liturgi_ibadah/screens/liturgi_screen.dart';
import 'package:liturgi_ibadah/screens/song_screen.dart';
import 'package:liturgi_ibadah/widgets/slide_image.dart';
import 'package:liturgi_ibadah/widgets/grid_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Widget image = const CarouselLoading();

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liturgi Ibadah'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16),
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: image,
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: const <Widget>[
                GridItem(
                  screen: SongScreen(),
                  icon: Icons.mic,
                  text: 'Lagu Pujian',
                ),
                GridItem(
                  screen: PDFViewerPage(),
                  icon: Icons.church,
                  text: 'Tata Ibadah',
                ),
                GridItem(
                  screen: KidungScreen(),
                  icon: Icons.book,
                  text: 'Kidung - Kidung'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
