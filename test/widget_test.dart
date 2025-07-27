import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/app/routes/app_pages.dart';
import 'package:my_app/app/modules/settings/controllers/theme_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUpAll(() async {
    await GetStorage.init();
  });

  testWidgets('Reminder App shows 4 reminder menus', (WidgetTester tester) async {
    // Initialize ThemeController
    Get.put(ThemeController());
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        title: "Reminder App",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.black,
        ),
      ),
    );

    // Wait for the page to load
    await tester.pumpAndSettle();

    // Verify that the app title is displayed
    expect(find.text('Reminder App'), findsOneWidget);

    // Verify that all 4 reminder menus are displayed
    expect(find.text('Pengingat Minum'), findsOneWidget);
    expect(find.text('Pengingat Makan'), findsOneWidget);
    expect(find.text('Pengingat Berdiri'), findsOneWidget);
    expect(find.text('Pengingat Istirahat'), findsOneWidget);

    // Verify that the settings icon is displayed
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('Settings navigation works', (WidgetTester tester) async {
    // Initialize ThemeController
    Get.put(ThemeController());
    
    // Build our app
    await tester.pumpWidget(
      GetMaterialApp(
        title: "Reminder App",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );

    await tester.pumpAndSettle();

    // Tap the settings icon
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    // Verify that we navigated to settings page
    expect(find.text('Pengaturan'), findsOneWidget);
    expect(find.text('Mode Gelap'), findsOneWidget);
  });
}
