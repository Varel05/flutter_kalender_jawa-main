class WetonData {
  final String tanggal;
  final String informasi;

  WetonData({required this.tanggal, required this.informasi});

  static List<WetonData> getWetonList() {
    return [
      WetonData(tanggal: "2024-12-05", informasi: "Weton Kliwon: Hari keberuntungan."),
      WetonData(tanggal: "2024-12-06", informasi: "Weton Legi: Hari baik untuk berbelanja."),
      WetonData(tanggal: "2024-12-07", informasi: "Weton Pahing: Hari kurang baik untuk bertemu orang baru."),
      WetonData(tanggal: "2024-12-08", informasi: "Weton Pon: Baik untuk memulai hubungan baru."),
    ];
  }
}