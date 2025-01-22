import 'package:intl/intl.dart';

class JavaneseDateConverter {
  static const List<String> bulanJawa = [
    "Sura",
    "Sapar",
    "Mulud",
    "Bakmulud",
    "Jumadilawal",
    "Jumadilakir",
    "Rejeb",
    "Ruwah",
    "Pasa",
    "Sawal",
    "Sela",
    "Besar"
  ];

  static const List<int> umurBulan = [
    30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29
  ];

  static const List<int> umurTahun = [
    354, 355, 354, 355, 354, 354, 354, 355
  ];

  static const List<String> pasaran = [
    "Pon",
    "Wage",
    "Kliwon",
    "Legi",
    "Pahing"
  ];

  /// Fungsi untuk menghitung hari pasaran
  static String calculatePasaran(DateTime masehiDate) {
    final DateTime patokan = DateTime(1936, 3, 24); // 24 Maret 1936 = Pon
    int selisihHari = masehiDate.difference(patokan).inDays;
    int indexPasaran = selisihHari % 5;
    if (indexPasaran < 0) {
      indexPasaran += 5;
    }
    return pasaran[indexPasaran];
  }

  /// Fungsi untuk mengonversi tanggal Masehi ke kalender Jawa
  static Future<Map<String, String>> convertToJavaneseDate(
      DateTime masehiDate) async {
    final formatter = DateFormat('EEEE, d MMMM y', 'id_ID');
    final DateTime patokan = DateTime(1936, 3, 24);
    int jarakHari = masehiDate.difference(patokan).inDays + 1;

    int windu = jarakHari ~/ 2835;
    int sisaHari = jarakHari % 2835;

    int warsa = 0;
    while (sisaHari > umurTahun[warsa]) {
      sisaHari -= umurTahun[warsa];
      warsa++;
    }
    int tahunJawa = warsa + (windu * 8) + 1867;

    List<int> umurBulanCopy = List.from(umurBulan);
    if (warsa == 1 || warsa == 3 || warsa == 7) {
      umurBulanCopy[11] = 30;
    }

    int wulan = 0;
    while (sisaHari > umurBulanCopy[wulan]) {
      sisaHari -= umurBulanCopy[wulan];
      wulan++;
    }
    int tanggalJawa = sisaHari;

    String masehiFormatted = formatter.format(masehiDate);
    String hariPasaran = calculatePasaran(masehiDate);

    await Future.delayed(const Duration(milliseconds: 500));

    return {
      "tanggal": tanggalJawa.toString(),
      "bulan": bulanJawa[wulan],
      "tahun": tahunJawa.toString(),
      "pasaran": hariPasaran,
      "masehi": masehiFormatted,
    };
  }
}
