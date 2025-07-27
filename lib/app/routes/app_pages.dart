import 'package:get/get.dart';

import '../modules/ai_chat/bindings/ai_chat_binding.dart';
import '../modules/ai_chat/views/ai_chat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main_layout/bindings/main_layout_binding.dart';
import '../modules/main_layout/views/main_layout_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN_LAYOUT;

  static final routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage<dynamic>(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.AI_CHAT,
      page: () => const AiChatView(),
      binding: AiChatBinding(),
    ),
    GetPage<dynamic>(
      name: _Paths.MAIN_LAYOUT,
      page: () => const MainLayoutView(),
      binding: MainLayoutBinding(),
    ),
  ];
}
