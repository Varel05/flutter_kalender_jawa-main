import 'package:flutter/material.dart';

// Import the category screens
import 'package:flutter_kalender_jawa/categories/haribaik_menu.dart';
import 'package:flutter_kalender_jawa/categories/legi_menu.dart';
import 'package:flutter_kalender_jawa/categories/pon_menu.dart';
import 'package:flutter_kalender_jawa/categories/weton_menu.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Make scaffold transparent
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hi, Pengguna',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Anda memiliki 4 hari penting dalam Kalender Jawa minggu ini',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informasi Hari Ini',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Hari ini adalah hari keberuntunga!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  'Lihat detail',
                                  style: TextStyle(
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '4 Hari Penting dalam Kalender Jawa',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildEventCard(context, 'Legi', 'Pasaran', '1d:10Hr', Colors.purple),
                            _buildEventCard(context, 'Hari Baik', 'Pasaran', '2d:5Hr', Colors.orange),
                            _buildEventCard(context, 'Pon', 'Pasaran', '3d:8Hr', Colors.green),
                            _buildEventCard(context, 'Weton', 'Pasaran', '4d:3Hr', Colors.red),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Subjek',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          children: [
                            _buildSubjectChip('Primbon', Colors.blue),
                            _buildSubjectChip('Weton', Colors.red),
                            _buildSubjectChip('Pasaran', Colors.orange),
                            _buildSubjectChip('Hari Baik', Colors.green),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, String title, String subtitle, String timeLeft, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding screen based on the tapped card
        switch (title) {
          case 'Legi':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LegiMenuScreen()),
            );
            break;
          case 'Hari Baik':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HariBaikMenuScreen()),
            );
            // Implement navigation to Pahing menu if needed
            break;
          case 'Pon':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PonMenuScreen()),
            );
            // Implement navigation to Pon menu if needed
            break;
          case 'Weton':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WetonMenuScreen()),
            );
            // Implement navigation to Wage menu if needed
            break;
        }
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: color),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  timeLeft,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
    );
  }
}
