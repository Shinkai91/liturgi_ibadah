import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.screen,
    required this.icon,
    required this.text,
  });

  final Widget screen;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 60,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
