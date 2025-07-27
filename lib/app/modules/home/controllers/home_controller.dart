import 'package:get/get.dart';

class HomeController extends GetxController {
  // Reminder menu items
  final reminderMenus = <Map<String, dynamic>>[
    {
      'title': 'Pengingat Minum',
      'description': 'Atur waktu minum air putih secara teratur',
      'icon': 'water_drop',
      'color': 0xFF2196F3, // Blue
    },
    {
      'title': 'Pengingat Makan',
      'description': 'Atur jadwal makan harian yang sehat',
      'icon': 'restaurant',
      'color': 0xFF4CAF50, // Green
    },
    {
      'title': 'Pengingat Berdiri',
      'description': 'Ingatkan untuk berdiri dan bergerak',
      'icon': 'accessibility',
      'color': 0xFFFF9800, // Orange
    },
    {
      'title': 'Pengingat Istirahat',
      'description': 'Waktu istirahat dan relaksasi',
      'icon': 'bed',
      'color': 0xFF9C27B0, // Purple
    },
  ].obs;

  void onMenuTapped(int index) {
    final menu = reminderMenus[index];
    Get.snackbar(
      menu['title'] as String,
      'Fitur ${menu['title']} akan segera hadir!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
