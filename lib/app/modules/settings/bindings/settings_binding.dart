import 'package:get/get.dart';

import 'package:my_app/app/modules/settings/controllers/theme_controller.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
