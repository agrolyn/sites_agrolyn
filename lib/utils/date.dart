import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<String> formatRelativeTime(String inputDate) async {
  try {
    // Inisialisasi locale
    await initializeDateFormatting('id_ID', null);

    // Parsing string tanggal ke DateTime
    DateFormat dateFormat =
        DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", "en_US");
    DateTime parsedDate = dateFormat.parseUTC(inputDate);

    DateTime now = DateTime.now();

    // Hitung selisih waktu
    Duration difference = now.difference(parsedDate);

    if (difference.inDays >= 1) {
      // Jika lebih dari 1 hari, format: 13 November 2024
      return DateFormat('d MMMM yyyy', 'id_ID').format(parsedDate);
    } else if (difference.inHours >= 1) {
      // Jika lebih dari 1 jam tapi kurang dari 1 hari
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes >= 1) {
      // Jika lebih dari 1 menit tapi kurang dari 1 jam
      return '${difference.inMinutes} menit yang lalu';
    } else {
      // Jika kurang dari 1 menit
      return 'Baru saja';
    }
  } catch (e) {
    print('Error parsing date: $e');
    return '0000-00-00';
  }
}

void main() async {
  String inputDate = "Wed, 13 Nov 2024 21:53:54 GMT";
  String result = await formatRelativeTime(inputDate);
  print(result);
}
