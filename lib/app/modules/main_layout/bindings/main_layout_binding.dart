import 'package:get/get.dart';

import '../controllers/main_layout_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../ai_chat/controllers/ai_chat_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../settings/controllers/theme_controller.dart';

class MainLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLayoutController>(
      () => MainLayoutController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AiChatController>(
      () => AiChatController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.lazyPut<ThemeController>(
      () => ThemeController(),
    );
  }
}
