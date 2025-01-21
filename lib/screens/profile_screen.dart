import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_kalender_jawa/screens/welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "Pengguna"; // Replace with actual user name from profile
  final String userEmail = "email@user.com"; // Replace with actual email from profile
  final String birthDate = "1995-08-15";

  const ProfileScreen({super.key}); // Replace with actual user's birth date
  
  // Dummy function to simulate fetching Javanese calendar info for a specific date
  String getJavaneseCalendarInfo(DateTime date) {
    final formatter = DateFormat('EEEE, d MMMM y');
    return "Tanggal: ${formatter.format(date)}\nPasaran: Legi\nWeton: Selasa Pon";
  }

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime birthDateParsed = DateTime.parse(birthDate);
    final String birthDateInfo = getJavaneseCalendarInfo(birthDateParsed);
    final String todayDateInfo = getJavaneseCalendarInfo(today);

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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Profil', style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // Implement navigation to settings page
                },
              ),
            ],
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
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/profile.png'), // Replace with actual profile image
                        ),
                        const SizedBox(height: 12),
                        Text(
                          userName,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userEmail,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 30),
                        // Birth Date Info Card
                        _buildInfoCard(
                          title: 'Informasi Penanggalan Jawa (Tanggal Lahir)',
                          info: birthDateInfo,
                          onShare: () {
                            // Implement share functionality
                          },
                        ),
                        const SizedBox(height: 20),
                        // Today's Date Info Card
                        _buildInfoCard(
                          title: 'Penanggalan Jawa (Hari Ini)',
                          info: todayDateInfo,
                          onShare: () {
                            // Implement share functionality
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => WelcomeScreen()),
                              (Route<dynamic> route) => false,
                              );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                          ),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
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

  Widget _buildInfoCard({required String title, required String info, required VoidCallback onShare}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              info,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: onShare,
                  icon: Icon(Icons.share, size: 20, color: Colors.white),
                  label: Text('Share'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
