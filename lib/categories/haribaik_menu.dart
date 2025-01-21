import 'package:flutter/material.dart';
import 'package:flutter_kalender_jawa/models/haribaik_data.dart';
import 'package:intl/intl.dart';


class HariBaikMenuScreen extends StatefulWidget {
  const HariBaikMenuScreen({super.key});

  @override
  _HariBaikMenuScreenState createState() => _HariBaikMenuScreenState();
}

class _HariBaikMenuScreenState extends State<HariBaikMenuScreen> {
  DateTime? _selectedDate;
  String _informasiHariBaik = 'Pilih tanggal untuk melihat informasi Hari Baik.';

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    setState(() {
      _selectedDate = pickedDate;
      _fetchHariBaikData();
    });
    }

  void _fetchHariBaikData() {
    if (_selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      HariBaikData? hariBaik = HariBaikData.getHariBaikList().firstWhere(
        (data) => data.tanggal == formattedDate,
        orElse: () => HariBaikData(tanggal: formattedDate, informasi: "Tidak ada data untuk tanggal ini."),
      );
      setState(() {
        _informasiHariBaik = hariBaik.informasi;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hari Baik')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickDate,
            child: Text('Pilih Tanggal'),
          ),
          const SizedBox(height: 20),
          Text(_informasiHariBaik),
        ],
      ),
    );
  }
}