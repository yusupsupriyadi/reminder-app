import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DrinkReminderController extends GetxController {
  final storage = GetStorage();

  // Observable variables
  final waterGoal = 8.obs; // Default 8 glasses per day
  final currentIntake = 0.obs;
  final glassSize = 250.obs; // ml per glass
  final reminderInterval = 60.obs; // minutes
  final isReminderActive = false.obs;

  // Progress percentage
  double get progressPercentage => currentIntake.value / waterGoal.value;

  // Remaining glasses
  int get remainingGlasses => waterGoal.value - currentIntake.value;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    try {
      saveData();
    } catch (e) {}
    super.onClose();
  }

  void loadData() {
    waterGoal.value = storage.read('water_goal') ?? 8;
    currentIntake.value = storage.read('current_intake') ?? 0;
    glassSize.value = storage.read('glass_size') ?? 250;
    reminderInterval.value = storage.read('reminder_interval') ?? 60;
    isReminderActive.value = storage.read('is_reminder_active') ?? false;
  }

  void saveData() {
    storage.write('water_goal', waterGoal.value);
    storage.write('current_intake', currentIntake.value);
    storage.write('glass_size', glassSize.value);
    storage.write('reminder_interval', reminderInterval.value);
    storage.write('is_reminder_active', isReminderActive.value);
  }

  void addWater() {
    if (currentIntake.value < waterGoal.value) {
      currentIntake.value++;
      saveData();

      if (currentIntake.value >= waterGoal.value) {
        Get.snackbar(
          'Selamat! 🎉',
          'Anda telah mencapai target minum air hari ini!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary.withOpacity(0.1),
          colorText: Get.theme.colorScheme.primary,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  void removeWater() {
    if (currentIntake.value > 0) {
      currentIntake.value--;
      saveData();
    }
  }

  void resetDaily() {
    currentIntake.value = 0;
    saveData();
    Get.snackbar(
      'Reset Berhasil',
      'Progress harian telah direset',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void updateWaterGoal(int newGoal) {
    if (newGoal > 0 && newGoal <= 20) {
      waterGoal.value = newGoal;
      saveData();
    }
  }

  void updateGlassSize(int newSize) {
    if (newSize >= 100 && newSize <= 1000) {
      glassSize.value = newSize;
      saveData();
    }
  }

  void updateReminderInterval(int newInterval) {
    if (newInterval >= 15 && newInterval <= 300) {
      reminderInterval.value = newInterval;
      saveData();
    }
  }

  void toggleReminder() {
    isReminderActive.value = !isReminderActive.value;
    saveData();

    Get.snackbar(
      'Pengingat ${isReminderActive.value ? 'Aktif' : 'Nonaktif'}',
      isReminderActive.value
          ? 'Pengingat minum akan muncul setiap ${reminderInterval.value} menit'
          : 'Pengingat minum telah dinonaktifkan',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
