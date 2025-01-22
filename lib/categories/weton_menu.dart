import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WetonMenuScreen extends StatefulWidget {
  const WetonMenuScreen({super.key});

  @override
  _WetonMenuScreenState createState() => _WetonMenuScreenState();
}

class _WetonMenuScreenState extends State<WetonMenuScreen> {
  DateTime? _selectedDate;
  String _wetonInfo = '';
  List<Map<String, dynamic>> _history = [];

  String _getWetonInfo(DateTime date) {
    final formatter = DateFormat('EEEE, d MMMM y', 'id_ID');
    return "Tanggal: ${formatter.format(date)}\nWeton: Minggu Kliwon";
  }

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
        _wetonInfo = _getWetonInfo(picked);
        _history.add({
          'tanggal': DateFormat('d MMMM y', 'id_ID').format(picked),
          'info': _wetonInfo,
        });
      });
    }
  }

  void _deleteHistory(int index) {
    setState(() {
      _history.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weton')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Pilih Tanggal'),
          ),
          if (_selectedDate != null)
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_wetonInfo),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Card(
                  child: ListTile(
                    title: Text(item['tanggal']),
                    subtitle: Text(item['info']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteHistory(index),
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
