import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../widgets/photo_card.dart';
import '../widgets/drawer.dart';
import 'detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Photo> _photos = [
    Photo(
      id: '1',
      title: 'PREWEDDING',
      imageUrl: 'assets/images/prewedding.jpeg',
      description:
          'This is a detailed description of Studio Photo 1, including various features and highlights of the studio.',
    ),
    Photo(
      id: '2',
      title: 'PERSONAL',
      imageUrl: 'assets/images/personal.jpeg',
      description:
          'This is a detailed description of Studio Photo 2, including various features and highlights of the studio.',
    ),
    Photo(
      id: '3',
      title: 'MATERNITY',
      imageUrl: 'assets/images/maternity.jpeg',
      description:
          'This is a detailed description of Studio Photo 3, including various features and highlights of the studio.',
    ),
    Photo(
      id: '4',
      title: 'GRADUATION',
      imageUrl: 'assets/images/graduation.jpeg',
      description:
          'This is a detailed description of Studio Photo 4, including various features and highlights of the studio.',
    ),
    Photo(
      id: '5',
      title: 'ENGAGEMENT',
      imageUrl: 'assets/images/engagement.jpg',
      description:
          'This is a detailed description of Studio Photo 5, including various features and highlights of the studio.',
    ),
    Photo(
      id: '6',
      title: 'GROUP',
      imageUrl: 'assets/images/group.jpeg',
      description:
          'This is a detailed description of Studio Photo 6, including various features and highlights of the studio.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori'),
      ),
      drawer: AppDrawer(
        userRole: 'customer',
      ),
      body: ListView.builder(
        itemCount: _photos.length,
        itemBuilder: (ctx, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.green[100], // Warna hijau
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: PhotoCard(
              photo: _photos[index],
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DetailScreen(photo: _photos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
