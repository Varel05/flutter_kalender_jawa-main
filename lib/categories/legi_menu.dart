import 'package:flutter/material.dart';
import '../helpers/javanese_date_converter.dart';

class LegiMenuScreen extends StatefulWidget {
  const LegiMenuScreen({super.key});

  @override
  _LegiMenuScreenState createState() => _LegiMenuScreenState();
}

class _LegiMenuScreenState extends State<LegiMenuScreen> {
  DateTime? selectedDate;
  Map<String, String>? javaneseDateInfo;
  List<Map<String, String>> history = [];
  DateTime? selectedDate;
  Map<String, String>? javaneseDateInfo;
  List<Map<String, String>> history = [];

  // Fungsi untuk mendapatkan informasi kalender Jawa secara asinkron
  Future<void> _getJavaneseCalendarInfo(DateTime date) async {
    final result = await JavaneseDateConverter.convertToJavaneseDate(date);
    setState(() {
      javaneseDateInfo = result;
      history.add({
        'tanggal': result['masehi']!,
        'info': "${result['pasaran']} ${result['tanggal']} ${result['bulan']} ${result['tahun']}",
      });
    });
  // Fungsi untuk mendapatkan informasi kalender Jawa secara asinkron
  Future<void> _getJavaneseCalendarInfo(DateTime date) async {
    final result = await JavaneseDateConverter.convertToJavaneseDate(date);
    setState(() {
      javaneseDateInfo = result;
      history.add({
        'tanggal': result['masehi']!,
        'info': "${result['pasaran']} ${result['tanggal']} ${result['bulan']} ${result['tahun']}",
      });
    });
  }

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      await _getJavaneseCalendarInfo(picked);
      await _getJavaneseCalendarInfo(picked);
    }
  }

  // Fungsi untuk menghapus histori
  void _deleteHistory(int index) {
    setState(() {
      history.removeAt(index);
      history.removeAt(index);
    });
  }

  // Fungsi untuk mengedit histori
  Future<void> _editHistory(int index) async {
  Future<void> _editHistory(int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final result = await JavaneseDateConverter.convertToJavaneseDate(picked);
      final result = await JavaneseDateConverter.convertToJavaneseDate(picked);
      setState(() {
        history[index] = {
          'tanggal': result['masehi']!,
          'info': "${result['pasaran']} ${result['tanggal']} ${result['bulan']} ${result['tahun']}",
        history[index] = {
          'tanggal': result['masehi']!,
          'info': "${result['pasaran']} ${result['tanggal']} ${result['bulan']} ${result['tahun']}",
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legi Menu')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Pilih Tanggal'),
          ),
          const SizedBox(height: 20),
          if (javaneseDateInfo != null)
          if (javaneseDateInfo != null)
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
                      "${javaneseDateInfo!['pasaran']} ${javaneseDateInfo!['tanggal']} ${javaneseDateInfo!['bulan']} ${javaneseDateInfo!['tahun']}",
                      "${javaneseDateInfo!['pasaran']} ${javaneseDateInfo!['tanggal']} ${javaneseDateInfo!['bulan']} ${javaneseDateInfo!['tahun']}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 20),
          const Divider(thickness: 2),
          const Text(
            'Histori Input Tanggal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                final item = history[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: ListTile(
                    title: Text(item['tanggal']!),
                    subtitle: Text(item['info']!),
                    title: Text(item['tanggal']!),
                    subtitle: Text(item['info']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editHistory(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteHistory(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
