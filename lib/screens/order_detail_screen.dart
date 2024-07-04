import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'dart:io';

class OrderDetailScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/bukti_transfer.jpg',
  ];
  final String name;
  final String email;
  final String phone;
  final String eventDate;
  final String bookingDate;
  final String eventTime;
  final String selectedPackage;
  final String category;
  final File? imagePath;
  final String userRole;

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
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    print('Received image: ${imagePath?.path}'); // Debug print
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      drawer: AppDrawer(
        userRole: userRole, // Pass the userRole here
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/thanks.png'), // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: imageUrls.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          child: Image.asset(
                            imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
