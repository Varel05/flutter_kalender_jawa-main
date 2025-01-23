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

  /// Fungsi untuk menghitung hari pasaran berdasarkan selisih hari
  static String calculatePasaran(DateTime masehiDate) {
    // Tanggal patokan (24 Maret 1936 = Pon)
    final DateTime patokan = DateTime(1936, 3, 24);

    // Hitung selisih hari dari patokan
    int selisihHari = masehiDate.difference(patokan).inDays;

    // Hitung pasaran (modulus 5)
    int indexPasaran = selisihHari % 5;
    if (indexPasaran < 0) {
      // Jika selisih hari negatif, tambahkan 5 untuk menghindari nilai negatif
      indexPasaran += 5;
    }
    return pasaran[indexPasaran];
  }

  /// Fungsi untuk konversi tanggal Masehi ke kalender Jawa
  static Future<Map<String, String>> convertToJavaneseDate(
      DateTime masehiDate) async {
    // Inisialisasi formatter lokal
    final formatter = DateFormat('EEEE, d MMMM y', 'id_ID');

    // Tanggal patokan Jawa (24 Maret 1936 Masehi)
    final DateTime patokan = DateTime(1936, 3, 24);

    // Hitung selisih hari dari tanggal patokan
    int jarakHari = masehiDate.difference(patokan).inDays + 1;

    // Hitung jumlah windu
    int windu = jarakHari ~/ 2835;
    int sisaHari = jarakHari % 2835;

    // Hitung angka tahun Jawa
    int warsa = 0;
    while (sisaHari > umurTahun[warsa]) {
      sisaHari -= umurTahun[warsa];
      warsa++;
    }
    int tahunJawa = warsa + (windu * 8) + 1867;

    // Tentukan jumlah hari di bulan Besar (tahun kabisat)
    List<int> umurBulanCopy = List.from(umurBulan);
    if (warsa == 1 || warsa == 3 || warsa == 7) {
      umurBulanCopy[11] = 30; // Tahun kabisat
    }

    // Hitung angka bulan Jawa
    int wulan = 0;
    while (sisaHari > umurBulanCopy[wulan]) {
      sisaHari -= umurBulanCopy[wulan];
      wulan++;
    }
    int tanggalJawa = sisaHari;

    // Format tanggal lengkap dalam lokal
    String masehiFormatted = formatter.format(masehiDate);

    // Hitung hari pasaran
    String hariPasaran = calculatePasaran(masehiDate);

    // Simulasi proses asinkron
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