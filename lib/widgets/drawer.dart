import 'package:flutter/material.dart';
import 'package:studiophoto/screens/home_screen.dart';
import 'package:studiophoto/screens/order_detail_screen.dart';
import 'package:studiophoto/screens/category_screen.dart';
import 'package:studiophoto/screens/account_screen.dart';
import 'package:studiophoto/screens/data_category_screen.dart';
import 'package:studiophoto/screens/data_pesanan_screen.dart';
import 'package:studiophoto/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final String userRole;

  AppDrawer({required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              userRole == 'admin' ? 'Admin' : 'Customer',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            decoration: BoxDecoration(color: Color.fromARGB(255, 38, 138, 55)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(userRole: userRole),
                ),
              );
            },
          ),
          if (userRole == 'customer') ...[
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Kategori'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('My Booking'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(
                      name: 'Cassandra Sheryl Lee',
                      email: 'cassandraSL@gmail.com',
                      phone: '1234567890',
                      eventDate: '2023-07-05',
                      bookingDate: '2023-07-04',
                      eventTime: '10.00',
                      selectedPackage: 'Package A',
                      category: 'GROUP',
                      imagePath: null,
                      userRole: 'customer', // Pass the userRole here
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('My Account'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AccountScreen(),
                  ),
                );
              },
            ),
          ] else if (userRole == 'admin') ...[
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Data Kategori'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DataCategoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Data Pesanan'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DataPesananScreen(),
                  ),
                );
              },
            ),
          ],
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('userRole');
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
