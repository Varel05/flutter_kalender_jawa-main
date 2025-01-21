import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LegiMenuScreen extends StatefulWidget {
  const LegiMenuScreen({super.key});

  @override
  _LegiMenuScreenState createState() => _LegiMenuScreenState();
}

class _LegiMenuScreenState extends State<LegiMenuScreen> {
  DateTime? _selectedDate;
  String _javaneseCalendarInfo = '';
  List<Map<String, dynamic>> _history = [];

  // Fungsi simulasi info kalender Jawa
  String _getJavaneseCalendarInfo(DateTime date) {
    final formatter = DateFormat('EEEE, d MMMM y', 'id_ID');
    return "Tanggal: ${formatter.format(date)}\nPasaran: Legi\nWeton: Selasa Pon";
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
      setState(() {
        _selectedDate = picked;
        _javaneseCalendarInfo = _getJavaneseCalendarInfo(picked);
        _history.add({
          'tanggal': DateFormat('d MMMM y', 'id_ID').format(picked),
          'info': _javaneseCalendarInfo,
        });
      });
    }
  }

  // Fungsi untuk menghapus histori
  void _deleteHistory(int index) {
    setState(() {
      _history.removeAt(index);
    });
  }

  // Fungsi untuk mengedit histori
  void _editHistory(int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        final infoBaru = _getJavaneseCalendarInfo(picked);
        _history[index] = {
          'tanggal': DateFormat('d MMMM y', 'id_ID').format(picked),
          'info': infoBaru,
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
          if (_selectedDate != null)
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
                      _javaneseCalendarInfo,
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
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: ListTile(
                    title: Text(item['tanggal']),
                    subtitle: Text(item['info']),
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
