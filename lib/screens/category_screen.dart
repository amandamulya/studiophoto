// lib/screens/category_screen.dart
import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../widgets/photo_card.dart';
import '../widgets/drawer.dart';
import 'detail_screen.dart'; // Pastikan import detail_screen

class CategoryScreen extends StatelessWidget {
  final List<Photo> _photos = [
    Photo(
      id: '1',
      title: 'PREWEDDING',
      imageUrl: 'assets/images/prewedding.jpeg',
      description: 'This is a detailed description of Studio Photo 1, including various features and highlights of the studio.',
    ),
    Photo(
      id: '2',
      title: 'PERSONAL',
      imageUrl: 'assets/images/personal.jpg',
      description: 'This is a detailed description of Studio Photo 2, including various features and highlights of the studio.',
    ),
    Photo(
      id: '3',
      title: 'MATERNITY',
      imageUrl: 'assets/images/maternity.jpeg',
      description: 'This is a detailed description of Studio Photo 3, including various features and highlights of the studio.',
    ),
    Photo(
      id: '4',
      title: 'GRADUATION',
      imageUrl: 'assets/images/graduation.jpeg',
      description: 'This is a detailed description of Studio Photo 4, including various features and highlights of the studio.',
    ),
    Photo(
      id: '5',
      title: 'ENGAGEMENT',
      imageUrl: 'assets/images/engagement.jpeg',
      description: 'This is a detailed description of Studio Photo 5, including various features and highlights of the studio.',
    ),
    Photo(
      id: '6',
      title: 'GROUP',
      imageUrl: 'assets/images/group.jpeg',
      description: 'This is a detailed description of Studio Photo 6, including various features and highlights of the studio.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: _photos.length,
        itemBuilder: (ctx, index) {
          return PhotoCard(
            photo: _photos[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => DetailScreen(photo: _photos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
