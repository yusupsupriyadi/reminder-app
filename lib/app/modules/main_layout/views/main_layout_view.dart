import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ai_chat/views/ai_chat_view.dart';
import '../../home/views/home_view.dart';
import '../../settings/views/settings_view.dart';
import '../controllers/main_layout_controller.dart';

class MainLayoutView extends GetView<MainLayoutController> {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [const HomeView(), const AiChatView(), const SettingsView()];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => IndexedStack(index: controller.currentIndex, children: pages)),
      extendBody: true,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          icons: const [
            Icons.home_rounded,
            Icons.smart_toy,
            Icons.settings,
          ],
          activeIndex: controller.currentIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          onTap: controller.changeIndex,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.surface
              : Colors.white,
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          splashRadius: 20,
          shadow: BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ),
      ),
    );
  }
}
