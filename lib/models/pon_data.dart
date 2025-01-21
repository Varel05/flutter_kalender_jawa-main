class PonData {
  final String tanggal;
  final String informasi;

  PonData({required this.tanggal, required this.informasi});

  static List<PonData> getPonList() {
    return [
      PonData(tanggal: "2024-12-05", informasi: "Hari Pon: Baik untuk menyelesaikan konflik."),
      PonData(tanggal: "2024-12-06", informasi: "Hari Pon: Kurang baik untuk perjalanan jauh."),
      PonData(tanggal: "2024-12-07", informasi: "Hari Pon: Waktu yang baik untuk beristirahat."),
      PonData(tanggal: "2024-12-08", informasi: "Hari Pon: Baik untuk mengadakan acara."),
    ];
  }
}