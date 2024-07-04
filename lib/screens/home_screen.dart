// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  final String userRole;

  HomeScreen({required this.userRole});

  final List<String> imageUrls = [
    'assets/images/prewedding.jpeg',
    'assets/images/personal.jpg',
    'assets/images/maternity.jpeg',
    'assets/images/graduation.jpeg',
    'assets/images/engagement.jpeg',
    'assets/images/group.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(
        userRole: userRole,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang di Heira Studio Foto!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Studio foto kami menawarkan berbagai layanan fotografi yang dapat memenuhi kebutuhan Anda. '
                'Mulai dari sesi foto prewedding, personal, maternity, graduation, engagement, hingga group photos. '
                'Dengan tim profesional dan peralatan terbaik, kami berkomitmen untuk memberikan hasil foto terbaik '
                'yang dapat menjadi kenangan indah bagi Anda dan keluarga.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Koleksi Foto:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
              SizedBox(height: 20),
              Container(
                color: Colors.grey.shade300,
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Jl. RS DKT Kodim Jalan Raya Pagongan, Bakulan, Pepedan, Kabupaten Tegal, Jawa Tengah',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
