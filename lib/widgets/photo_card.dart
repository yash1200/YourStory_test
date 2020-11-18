import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  PhotoCard({this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: 160,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
