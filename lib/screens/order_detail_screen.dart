import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'dart:io';

class OrderDetailScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String eventDate;
  final String bookingDate;
  final String eventTime;
  final String selectedPackage;
  final String category;
  final File? imagePath;

  OrderDetailScreen({
    required this.name,
    required this.email,
    required this.phone,
    required this.eventDate,
    required this.bookingDate,
    required this.eventTime,
    required this.selectedPackage,
    required this.category,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    print('Received image: ${imagePath?.path}'); // Debug print
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Name: $name'),
              Text('Email: $email'),
              Text('Phone: $phone'),
              Text('Event Date: $eventDate'),
              Text('Booking Date: $bookingDate'),
              Text('Event Time: $eventTime'),
              Text('Package: $selectedPackage'),
              Text('Category: $category'),
              SizedBox(height: 16),
              Text(
                'Transfer Screenshot:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              imagePath == null
                  ? Text('No image selected.')
                  : Image.file(imagePath!,
                      height: 200, width: 200, fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}
