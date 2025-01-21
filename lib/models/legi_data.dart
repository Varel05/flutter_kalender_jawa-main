class LegiData {
  int id; // ID unik untuk setiap data.
  String tanggal;
  String informasi;

  LegiData({
    required this.id,
    required this.tanggal,
    required this.informasi,
  });

  // Data statis awal untuk contoh.
  static List<LegiData> data = [
    LegiData(id: 1, tanggal: '2025-01-01', informasi: 'Informasi Legi untuk 1 Januari 2025'),
    LegiData(id: 2, tanggal: '2025-01-02', informasi: 'Informasi Legi untuk 2 Januari 2025'),
    LegiData(id: 3, tanggal: '2025-01-03', informasi: 'Informasi Legi untuk 3 Januari 2025'),
  ];

  // Create: Tambah data baru.
  static void createLegi(LegiData newLegi) {
    data.add(newLegi);
  }

  // Read: Ambil semua data.
  static List<LegiData> readAll() {
    return data;
  }

  // Update: Perbarui data berdasarkan ID.
  static bool updateLegi(int id, String tanggalBaru, String informasiBaru) {
    for (var legi in data) {
      if (legi.id == id) {
        legi.tanggal = tanggalBaru;
        legi.informasi = informasiBaru;
        return true;
      }
    }
    return false; // ID tidak ditemukan.
  }

  // Delete: Hapus data berdasarkan ID.
  static bool deleteLegi(int id) {
    // Periksa apakah data dengan ID yang sesuai ada.
    final initialLength = data.length;
    data.removeWhere((legi) => legi.id == id);
    return data.length < initialLength; // Berhasil menghapus jika panjang data berkurang.
  }
}
