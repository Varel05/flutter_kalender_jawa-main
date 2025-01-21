class HariBaikData {
  final String tanggal;
  final String informasi;

  HariBaikData({required this.tanggal, required this.informasi});

  static List<HariBaikData> getHariBaikList() {
    return [
      HariBaikData(tanggal: "2024-12-05", informasi: "Hari baik untuk menikah."),
      HariBaikData(tanggal: "2024-12-06", informasi: "Hari baik untuk memulai usaha."),
      HariBaikData(tanggal: "2024-12-07", informasi: "Hari baik untuk pindah rumah."),
      HariBaikData(tanggal: "2024-12-08", informasi: "Hari baik untuk berdamai dengan keluarga."),
    ];
  }
}