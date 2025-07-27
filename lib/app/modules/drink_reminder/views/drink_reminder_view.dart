import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/drink_reminder_controller.dart';

class DrinkReminderView extends GetView<DrinkReminderController> {
  const DrinkReminderView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengingat Minum'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressCard(context),
            const SizedBox(height: 20),
            _buildActionButtons(context),
            const SizedBox(height: 20),
            _buildSettingsCard(context),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProgressCard(BuildContext context) {
    return Obx(() => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.water_drop,
                color: Colors.blue,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Progress Hari Ini',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${controller.currentIntake.value}/${controller.waterGoal.value} gelas',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(controller.currentIntake.value * controller.glassSize.value)}ml dari ${(controller.waterGoal.value * controller.glassSize.value)}ml',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              CircularProgressIndicator(
                value: controller.progressPercentage,
                backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 6,
              ),
            ],
          ),
          if (controller.remainingGlasses > 0) ...[
            const SizedBox(height: 12),
            Text(
              'Sisa ${controller.remainingGlasses} gelas lagi untuk mencapai target!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    ));
  }
  
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.addWater,
            icon: const Icon(Icons.add),
            label: const Text('Minum 1 Gelas'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: controller.removeWater,
          icon: const Icon(Icons.remove),
          label: const Text('Kurangi'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSettingsCard(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengaturan',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSettingItem(
                      context,
                      'Target Harian',
                      '${controller.waterGoal.value} gelas',
                      Icons.flag,
                      () => _showGoalDialog(context),
                    ),
                    _buildSettingItem(
                      context,
                      'Ukuran Gelas',
                      '${controller.glassSize.value}ml',
                      Icons.local_drink,
                      () => _showGlassSizeDialog(context),
                    ),
                    _buildSettingItem(
                      context,
                      'Interval Pengingat',
                      '${controller.reminderInterval.value} menit',
                      Icons.schedule,
                      () => _showIntervalDialog(context),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => SwitchListTile(
                      title: Text('Aktifkan Pengingat'),
                      subtitle: Text(
                        controller.isReminderActive.value 
                            ? 'Pengingat aktif'
                            : 'Pengingat nonaktif',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      value: controller.isReminderActive.value,
                      onChanged: (value) => controller.toggleReminder(),
                      activeColor: Colors.blue,
                      contentPadding: EdgeInsets.zero,
                    )),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: controller.resetDaily,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset Progress Harian'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSettingItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.chevron_right,
            size: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ],
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
  
  void _showGoalDialog(BuildContext context) {
    RxInt tempGoal = controller.waterGoal.value.obs;
    
    Get.dialog(
      AlertDialog(
        title: const Text('Target Harian'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pilih target gelas per hari (1-20):'),
            const SizedBox(height: 16),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: tempGoal.value > 1 ? () {
                    tempGoal.value--;
                  } : null,
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '${tempGoal.value} gelas',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: tempGoal.value < 20 ? () {
                    tempGoal.value++;
                  } : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              controller.updateWaterGoal(tempGoal.value);
              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
  
  void _showGlassSizeDialog(BuildContext context) {
    RxInt tempSize = controller.glassSize.value.obs;
    
    Get.dialog(
      AlertDialog(
        title: const Text('Ukuran Gelas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pilih ukuran gelas (100-1000ml):'),
            const SizedBox(height: 16),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: tempSize.value > 100 ? () {
                    tempSize.value -= 50;
                  } : null,
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '${tempSize.value}ml',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: tempSize.value < 1000 ? () {
                    tempSize.value += 50;
                  } : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              controller.updateGlassSize(tempSize.value);
              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
  
  void _showIntervalDialog(BuildContext context) {
    RxInt tempInterval = controller.reminderInterval.value.obs;
    
    Get.dialog(
      AlertDialog(
        title: const Text('Interval Pengingat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pilih interval pengingat (15-300 menit):'),
            const SizedBox(height: 16),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: tempInterval.value > 15 ? () {
                    tempInterval.value -= 15;
                  } : null,
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  '${tempInterval.value} menit',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: tempInterval.value < 300 ? () {
                    tempInterval.value += 15;
                  } : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              controller.updateReminderInterval(tempInterval.value);
              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
