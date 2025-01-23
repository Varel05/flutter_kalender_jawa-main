import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/javanese_date_converter.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? selectedDate;
  String javaneseCalendarInfo = "Belum ada data";

  // Fungsi untuk mendapatkan informasi kalender Jawa
  Future<void> fetchJavaneseCalendarInfo(DateTime date) async {
    try {
      debugPrint("Mengonversi tanggal: $date");
      // Simulasi logika JavaneseDateConverter
      final javaneseDate = await JavaneseDateConverter.convertToJavaneseDate(date);

      // Format tanggal Masehi
      final formatter = DateFormat('EEEE, d MMMM y', 'id');
      final formattedDate = formatter.format(date);

      setState(() {
        javaneseCalendarInfo = "Tanggal Masehi: $formattedDate\n"
            "Tanggal Jawa: ${javaneseDate['tanggal']} ${javaneseDate['bulan']} ${javaneseDate['tahun']}\n"
            "Hari Pasaran: ${javaneseDate['pasaran']}";
      });

      debugPrint("Hasil Konversi: $javaneseCalendarInfo");
    } catch (e) {
      setState(() {
        javaneseCalendarInfo = "Terjadi kesalahan saat mengonversi tanggal: $e";
      });
      debugPrint("Error: $e");
    }
  }

  // Picker Tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        javaneseCalendarInfo = "Mengonversi data...";
      });
      await fetchJavaneseCalendarInfo(picked); // Panggil fungsi konversi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Kalender Jawa',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              // White Container
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Pilih Tanggal',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _selectDate(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 12.0),
                            backgroundColor: Colors.blue.shade800,
                          ),
                          child: Text(
                            selectedDate == null
                                ? 'Pilih Tanggal'
                                : 'Ubah Tanggal',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Informasi Kalender Jawa',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                javaneseCalendarInfo,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}