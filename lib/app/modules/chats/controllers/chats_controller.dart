import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../Helper/logger.dart';
import '../../../../Utils/global_snackbar.dart';
import '../../../models/chats_model.dart';
import '../../../models/conversation_model.dart';
import '../../../repository/supabase_chats_repository.dart';
import '../../../repository/supabase_repository.dart';
import '../../home/controllers/home_controller.dart';

class ChatsController extends GetxController {
  //TODO: Implement ChatsController
  final SupabaseRepository _repository = SupabaseRepository();
  final supabase = Supabase.instance.client;
  final _chatRepository = ChatsRepository();
  final textController = TextEditingController();
  final selectedXFile = Rxn<XFile?>(null);
  final isSelectingFile = false.obs;

  final sender = Get.find<HomeController>().user.value;
  late String receiverName = "";
  late String receiverId;
  final messages = <ChatModel>[].obs;
  var isLoading = false.obs;
  final isFileSending = false.obs;
  final Rx<ConversationModel?> conversation = Rx<ConversationModel?>(null);
  final conversationId = "".obs;

  Future<void> fetchConversation(String user1, String user2) async {
    try {
      isLoading.value = true;
      final response = await _chatRepository.getConversation(user1, user2);
      if (response != null) {
        conversationId.value = response.id!;
        conversation.value = response;
        final msg = await _chatRepository.fetchMessages(conversationId.value);
        messages.value = msg;
        listenToMessages(conversationId.value);
      } else {
        conversationId.value = "";
        conversation.value = response;
        Log.w('Conversation is not found!');
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Log.e(e);
    }
  }

  void listenToMessages(String conversationId) async {
    supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        // .eq('conversation_id', conversationId) // Filter by conversation
        .order('created_at')
        .listen((event) {
          final newMessages =
              event.map((msg) => ChatModel.fromJson(msg)).toList();
          messages.assignAll(newMessages);
        });
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
    XFile? file,
  }) async {
    try {
      ///   check is conversation exists or not
      if (conversationId.value.isEmpty) {
        isLoading.value = true;
        final response =
            await _chatRepository.createConversation(senderId, receiverId);
        if (response == null) {
          isLoading.value = false;
          conversation.value = response;
          conversationId.value = "";
          globalSnackBar(
              durationInSeconds: 3,
              textColor: Colors.red,
              title: "Error!",
              message: "Something went wrong. Please try again later");
          return;
        } else {
          conversationId.value = response.id!;
          conversation.value = response;
          listenToMessages(conversationId.value);
          isLoading.value = false;
        }
      }

      List<String>? fileUrls = [];
      if (file != null) {
        isFileSending.value = true;
        final url = await _repository.uploadImage(
            xFile: file, folder: "messages_image");
        if (url != null && url.isNotEmpty) {
          fileUrls.add(url);
        } else {
          globalSnackBar(
              durationInSeconds: 5,
              textColor: Colors.red,
              title: "Fail to upload file!",
              message:
                  "Your selected file uploading fail. Something went wrong. Please try again.");
        }
      }

      final isMessageSent = await _chatRepository.sendMessage(
          conversationId: conversationId.value,
          senderId: senderId,
          receiverId: receiverId,
          content: message,
          fileUrls: fileUrls);

      if (isMessageSent == false) {
        Log.e("The message wasn't sent");
      }
      isFileSending.value = false;
    } catch (e) {
      isFileSending.value = false;
      Log.e(e);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['receiver_id'] != null) {
      receiverId = Get.arguments['receiver_id'];
      receiverName = Get.arguments['receiver_name'] ?? "Customer Name";
      fetchConversation(sender.id!, receiverId);
    } else {
      Log.e("Receiver id is null");
    }

    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
