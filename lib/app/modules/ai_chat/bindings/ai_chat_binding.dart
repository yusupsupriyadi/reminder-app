import 'package:get/get.dart';

import '../controllers/ai_chat_controller.dart';

class AiChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiChatController>(
      () => AiChatController(),
    );
  }
}
