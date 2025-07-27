# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter calculator application built **exclusively with GetX ecosystem** using Get CLI for code generation and project structure. The project follows GetX's MVC (Model-View-Controller) architecture pattern with complete dependency injection, reactive state management, and advanced routing. The project is configured for multi-platform deployment (Android, iOS, Web, Windows, macOS, Linux).

**IMPORTANT**: This project uses GetX for ALL development aspects - never use other state management, routing, or dependency injection solutions. All features must leverage GetX's comprehensive ecosystem.

## Development Commands

### Get CLI Commands (Primary Development Tool)

```bash
# Install Get CLI globally
flutter pub global activate get_cli

# Create new modules/pages
get create page:settings          # Create complete module with controller, view, binding
get create screen:profile         # Clean architecture variant
get create controller:theme       # Create controller only
get create view:calculator        # Create view only

# Generate models from JSON
get generate model on home with assets/models/user.json

# Generate localization files
get generate locales assets/locales

# Package management
get install http                  # Install dependencies
get remove dio                    # Remove packages
get update                        # Update Get CLI

# Code organization
get sort                          # Organize imports and code structure
```

### Standard Flutter Commands

```bash
# Install dependencies
flutter pub get

# Run the app in debug mode
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d android         # Android
flutter run -d ios             # iOS

# Build for release
flutter build apk              # Android APK
flutter build ios              # iOS
flutter build web              # Web
flutter build windows          # Windows

# Code analysis and linting
flutter analyze

# Run tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Generate coverage report
flutter test --coverage

# Clean build files
flutter clean
```

## Architecture

### GetX Complete Ecosystem

**Three Core Pillars:**
1. **State Management**: Reactive programming with `.obs` variables, automatic UI updates
2. **Route Management**: Context-free navigation with `Get.to()`, `Get.back()`, named routes
3. **Dependency Injection**: Automatic memory management with `Get.put()`, `Get.find()`

**GetX MVC Pattern:**
- **Models**: Data structures and business logic with GetX reactive variables
- **Views**: UI components extending `GetView<Controller>` with `Obx()` for reactivity
- **Controllers**: State management extending `GetxController` with lifecycle methods
- **Bindings**: Dependency injection extending `Bindings` for automatic controller management

**Additional GetX Features Used:**
- **GetStorage**: Local storage solution
- **GetConnect**: HTTP client with interceptors
- **Get.defaultDialog()**: Modal dialogs without context
- **Get.snackbar()**: Toast notifications
- **GetResponsive**: Responsive design utilities
- **GetPlatform**: Platform detection
- **Get.theme**: Theme management
- **Get.locale**: Internationalization support

### Project Structure
```
lib/
├── app/
│   ├── modules/
│   │   └── home/
│   │       ├── bindings/home_binding.dart
│   │       ├── controllers/home_controller.dart
│   │       └── views/home_view.dart
│   └── routes/
│       ├── app_pages.dart
│       └── app_routes.dart
└── main.dart
```

### Current Implementation Status
- **HomeController**: Complete calculator logic with arithmetic operations (+, -, ×, ÷, %)
- **HomeView**: Basic scaffold template (needs calculator UI implementation)
- **Routes**: Configured with GetX routing system
- **Bindings**: Dependency injection setup for HomeController

## Key Dependencies

**GetX Ecosystem (Primary):**
- **get**: ^4.7.2 - Complete GetX framework (state management, routing, dependency injection)
- **get_storage**: Local storage (when needed)
- **get_cli**: Code generation and project scaffolding

**UI & Development:**
- **hugeicons**: ^0.0.11 - Icon library for UI elements
- **flutter_lints**: ^5.0.0 - Dart/Flutter linting rules optimized for GetX

**Note**: This project exclusively uses GetX solutions. Do not add other state management libraries (Provider, Bloc, Riverpod), routing libraries (go_router), or dependency injection frameworks.

## Code Quality & Linting

The project uses comprehensive linting rules optimized for GetX development:

- **Error Prevention**: `avoid_print`, `prefer_const_constructors`, `prefer_final_fields`
- **GetX Best Practices**: Type inference preferred, reactive programming patterns
- **Code Metrics**: Maximum cyclomatic complexity: 20, nesting level: 5
- **Excluded Files**: Generated files (*.g.dart, *.freezed.dart, platform-specific code)

## Calculator Features (HomeController)

The calculator controller implements:
- Basic arithmetic: addition, subtraction, multiplication, division, modulo
- Decimal point support
- Clear (C) and delete (⌫) operations
- Error handling for division by zero
- Display formatting for integers vs decimals

## Testing

- **Framework**: Flutter's built-in testing framework
- **Current Tests**: Basic widget test (needs updating for GetX architecture)
- **Test Location**: `test/widget_test.dart`

## Development Notes

1. **UI Implementation Needed**: The HomeView currently shows placeholder text and needs to be implemented with calculator buttons and display
2. **Test Updates Required**: Widget tests reference non-existent `MyApp` class instead of `GetMaterialApp`
3. **GetX Patterns**: Follow reactive programming with `.obs` variables and `Obx` widgets for UI updates
4. **Icon Usage**: Use HugeIcons package for consistent iconography
5. **State Management**: All business logic should be in controllers, views should be stateless

## Multi-Platform Support

The project is configured for:
- **Android**: Kotlin-based Android app
- **iOS**: Swift-based iOS app  
- **Web**: Progressive Web App
- **Desktop**: Windows, macOS, Linux native apps

## GetX Development Patterns & Best Practices

### Creating New Features (Use Get CLI)

```bash
# Generate complete module structure
get create page:feature_name
```

This creates:
- `controllers/feature_name_controller.dart`
- `views/feature_name_view.dart` 
- `bindings/feature_name_binding.dart`
- Auto-registers route in `app_pages.dart`

### Manual Development Pattern (if needed)

1. **Controller**: Extend `GetxController` with reactive variables
```dart
class FeatureController extends GetxController {
  final count = 0.obs;
  final loading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Initialization logic
  }
  
  @override
  void onClose() {
    // Cleanup logic
    super.onClose();
  }
}
```

2. **Binding**: Manage dependencies
```dart
class FeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatureController>(() => FeatureController());
  }
}
```

3. **View**: Use `GetView<Controller>` with `Obx()`
```dart
class FeatureView extends GetView<FeatureController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Text('Count: ${controller.count}'))
    );
  }
}
```

4. **Route**: Register in `app_pages.dart`
```dart
GetPage(
  name: _Paths.FEATURE,
  page: () => FeatureView(),
  binding: FeatureBinding(),
)
```

### GetX Navigation Patterns

```dart
// Navigate to new page
Get.to(() => NewPage());
Get.toNamed('/new-page');

// Navigate with data
Get.to(() => DetailPage(), arguments: {'id': 123});

// Replace current page
Get.off(() => LoginPage());
Get.offNamed('/login');

// Clear stack and navigate
Get.offAll(() => HomePage());
Get.offAllNamed('/home');

// Navigate back
Get.back();
Get.back(result: 'some_data');
```

### GetX State Management Patterns

```dart
// Reactive variables
final name = 'Initial'.obs;
final user = UserModel().obs;
final list = <String>[].obs;

// Update reactive variables
name.value = 'Updated';
user.update((val) {
  val!.name = 'New Name';
});
list.add('New Item');

// UI updates automatically with Obx()
Obx(() => Text(controller.name.value))
```

### GetX Dependency Injection Patterns

```dart
// Put dependency (immediate)
Get.put(ApiController());

// Lazy put (created when first used)
Get.lazyPut<AuthController>(() => AuthController());

// Permanent (never disposed)
Get.put(DatabaseController(), permanent: true);

// Find dependency
final authController = Get.find<AuthController>();
```

### GetX Dialog & Snackbar Patterns

```dart
// Show dialog
Get.defaultDialog(
  title: 'Alert',
  middleText: 'This is a GetX dialog',
  onConfirm: () => Get.back(),
);

// Show snackbar
Get.snackbar(
  'Success',
  'Operation completed successfully',
  snackPosition: SnackPosition.BOTTOM,
);
```

**MANDATORY RULES:**
- Always use GetX features exclusively
- Use Get CLI for code generation whenever possible
- Never mix with other state management solutions
- Follow GetX naming conventions
- Use reactive programming patterns
- Leverage GetX's automatic memory management