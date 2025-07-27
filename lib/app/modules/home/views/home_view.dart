import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Reminder App',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Wrap(
              spacing: 16,
              runSpacing: 16,
              children: controller.reminderMenus.asMap().entries.map((entry) {
                final index = entry.key;
                final menu = entry.value;
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 48) / 2, // 48 = padding (16*2) + spacing (16)
                  child: _buildMenuCard(context, menu, index),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> menu, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => controller.onMenuTapped(index),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIcon(menu['icon'] as String),
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
              const SizedBox(height: 12),
              Text(
                menu['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 6),
              Text(
                menu['description'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.87),
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'water_drop':
        return Icons.water_drop;
      case 'restaurant':
        return Icons.restaurant;
      case 'accessibility':
        return Icons.accessibility;
      case 'bed':
        return Icons.bed;
      default:
        return Icons.home;
    }
  }
}
