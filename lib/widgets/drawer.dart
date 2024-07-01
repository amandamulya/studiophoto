// lib/widgets/drawer.dart
import 'package:flutter/material.dart';
import 'package:studiophoto/screens/order_detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/account_screen.dart';
import 'package:studiophoto/screens/login_screen.dart'; // Assuming you have an account screen

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Customer',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            decoration: BoxDecoration(
                color: Colors.brown), // Set your coffee color here
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Kategori'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('My Booking'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => OrderDetailScreen(
                    name: 'Cassandra Sheryl Lee',
                    email: 'default@example.com',
                    phone: '1234567890',
                    eventDate: '2023-01-01',
                    bookingDate: '2023-01-01',
                    eventTime: '10.00',
                    selectedPackage: 'Default Package',
                    category: 'Default Category',
                    imagePath: null, // Use placeholder data
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('My Account'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AccountScreen()),

                // Make sure you have this screen
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Navigasi ke LoginScreen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
