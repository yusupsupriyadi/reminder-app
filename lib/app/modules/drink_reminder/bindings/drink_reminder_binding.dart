import 'package:get/get.dart';

import '../controllers/drink_reminder_controller.dart';

class DrinkReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DrinkReminderController>(
      DrinkReminderController(),
    );
  }
}
