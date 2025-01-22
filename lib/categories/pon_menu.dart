import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PonMenuScreen extends StatefulWidget {
  const PonMenuScreen({super.key});

  @override
  _PonMenuScreenState createState() => _PonMenuScreenState();
}

class _PonMenuScreenState extends State<PonMenuScreen> {
  DateTime? _selectedDate;
  String _ponInfo = '';
  List<Map<String, dynamic>> _history = [];

  String _getPonInfo(DateTime date) {
    final formatter = DateFormat('EEEE, d MMMM y', 'id_ID');
    return "Tanggal: ${formatter.format(date)}\nPasaran: Pon\nWeton: Kamis Pon";
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
        _ponInfo = _getPonInfo(picked);
        _history.add({
          'tanggal': DateFormat('d MMMM y', 'id_ID').format(picked),
          'info': _ponInfo,
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
      appBar: AppBar(title: const Text('Pasaran Pon')),
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
                child: Text(_ponInfo),
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
