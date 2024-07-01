// lib/widgets/photo_card.dart
import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTap;

  PhotoCard({required this.photo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(photo.imageUrl), // Use Image.asset for local images
        title: Text(photo.title),
        subtitle: Text(photo.description),
        onTap: onTap,
      ),
    );
  }
}
