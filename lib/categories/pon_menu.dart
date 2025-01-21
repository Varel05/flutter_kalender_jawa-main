import 'package:flutter/material.dart';
import 'package:flutter_kalender_jawa/models/pon_data.dart';
import 'package:intl/intl.dart';


class PonMenuScreen extends StatefulWidget {
  const PonMenuScreen({super.key});

  @override
  _PonMenuScreenState createState() => _PonMenuScreenState();
}

class _PonMenuScreenState extends State<PonMenuScreen> {
  DateTime? _selectedDate;
  String _informasiPon = 'Pilih tanggal untuk melihat informasi Pon.';

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    setState(() {
      _selectedDate = pickedDate;
      _fetchPonData();
    });
    }

  void _fetchPonData() {
    if (_selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      PonData? pon = PonData.getPonList().firstWhere(
        (data) => data.tanggal == formattedDate,
        orElse: () => PonData(tanggal: formattedDate, informasi: "Tidak ada data untuk tanggal ini."),
      );
      setState(() {
        _informasiPon = pon.informasi;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pon')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickDate,
            child: Text('Pilih Tanggal'),
          ),
          const SizedBox(height: 20),
          Text(_informasiPon),
        ],
      ),
    );
  }
}