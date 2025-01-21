import 'package:flutter_kalender_jawa/models/legi_data.dart';

class LegiController {
  // Create
  void tambahData(String tanggal, String informasi) {
    int newId = LegiData.data.isEmpty ? 1 : LegiData.data.last.id + 1;
    LegiData.createLegi(LegiData(id: newId, tanggal: tanggal, informasi: informasi));
  }

  // Read
  List<LegiData> ambilSemuaData() {
    return LegiData.readAll();
  }

  // Update
  bool perbaruiData(int id, String tanggalBaru, String informasiBaru) {
    return LegiData.updateLegi(id, tanggalBaru, informasiBaru);
  }

  // Delete
  bool hapusData(int id) {
    return LegiData.deleteLegi(id);
  }
}
