import 'package:flutter/material.dart';
import '../models/photo.dart';
import 'booking_screen.dart';

class DetailScreen extends StatelessWidget {
  final Photo photo;

  DetailScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(photo.imageUrl),
            SizedBox(height: 16.0),
            Text(
              photo.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPackageSection('Package A', 'Harga: IDR 200.000, Include: 1 konsep foto, 1 cetak foto 20x30cm, 20 shoot, 20 edit foto.', context, photo.title),
                buildPackageSection('Package B', 'Harga: IDR 350.000, Include: 1 konsep foto, 1 cetak foto 20x30cm, 30 shoot, 30 edit foto.', context, photo.title),
                buildPackageSection('Package C', 'Harga: IDR 500.000, Include: 2 konsep foto, 1 cetak foto 20x30cm, 30 edit foto, bisa request outdoor.', context, photo.title),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageSection(String title, String description, BuildContext context, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookingScreen(selectedPackage: title, category: category),
              ),
            );
          },
          child: Text('Booking Now'),
        ),
      ],
    );
  }
}
