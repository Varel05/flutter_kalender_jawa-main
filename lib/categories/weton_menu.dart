import 'package:flutter/material.dart';
import 'package:flutter_kalender_jawa/models/weton_data.dart';
import 'package:intl/intl.dart';


class WetonMenuScreen extends StatefulWidget {
  const WetonMenuScreen({super.key});

  @override
  _WetonMenuScreenState createState() => _WetonMenuScreenState();
}

class _WetonMenuScreenState extends State<WetonMenuScreen> {
  DateTime? _selectedDate;
  String _informasiWeton = 'Pilih tanggal untuk melihat informasi Weton.';

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    setState(() {
      _selectedDate = pickedDate;
      _fetchWetonData();
    });
    }

  void _fetchWetonData() {
    if (_selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      WetonData? weton = WetonData.getWetonList().firstWhere(
        (data) => data.tanggal == formattedDate,
        orElse: () => WetonData(tanggal: formattedDate, informasi: "Tidak ada data untuk tanggal ini."),
      );
      setState(() {
        _informasiWeton = weton.informasi;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weton')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickDate,
            child: Text('Pilih Tanggal'),
          ),
          const SizedBox(height: 20),
          Text(_informasiWeton),
        ],
      ),
    );
  }
}