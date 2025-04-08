import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Helper/logger.dart';
import '../models/chats_model.dart';
import '../models/conversation_model.dart';

class ChatsRepository {
  final SupabaseClient _client;

  ChatsRepository() : _client = Supabase.instance.client;

  // Find existing conversation between users
  Future<ConversationModel?> getConversation(
      String userId1, String userId2) async {
    try {
      // Query database if not in cache
      final response = await _client
          .from('conversations')
          .select()
          .or('user1.eq.$userId1,user2.eq.$userId1')
          .or('user1.eq.$userId2,user2.eq.$userId2')
          .limit(1);

      if (response.isNotEmpty) {
        // Store in cache for future use
        final conversation = ConversationModel.fromJson(response[0]);
        Log.i(response);
        return conversation;
      }

      return null;
    } catch (e) {
      Log.e('Error finding conversation: $e');
      return null;
    }
  }

  // Create a new conversation
  Future<ConversationModel?> createConversation(
      String userId1, String userId2) async {
    try {
      final newConversation = {
        'user1': userId1,
        'user2': userId2,
        'is_group': false,
        'is_seen': false,
        'is_typing': false,
        'user1_role': 'user',
        'user2_role': 'driver',
      };

      final response =
          await _client.from('conversations').insert(newConversation).select();

      if (response.isNotEmpty) {
        final conversation = ConversationModel.fromJson(response[0]);
        Log.i(response);
        return conversation;
      }

      return null;
    } catch (e) {
      Log.e('Error creating conversation: $e');
      return null;
    }
  }

  // Get or create conversation
  // Future<String?> getOrCreateConversationId(
  //     String userId1, String userId2) async {
  //   // Find existing conversation
  //   final existingConversation = await findConversation(userId1, userId2);
  //   if (existingConversation != null && existingConversation.id != null) {
  //     return existingConversation.id;
  //   }
  //
  //   // Create new conversation if none exists
  //   final newConversation = await createConversation(userId1, userId2);
  //   return newConversation?.id;
  // }
  //

  /// Fetch messages for a conversation
  Future<List<ChatModel>> fetchMessages(String conversationId) async {
    try {
      final response = await _client
          .from('messages')
          .select()
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: true);

      Log.i(response);
      return (response as List).map((msg) => ChatModel.fromJson(msg)).toList();
    } catch (e) {
      Log.e('Error fetching messages: $e');
      return [];
    }
  }

  // Send a message
  Future<bool> sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String? content,
    List<String>? fileUrls,
  }) async {
    try {
      if (conversationId.isEmpty || senderId.isEmpty || receiverId.isEmpty) {
        Log.e(
            '❌ Error: One or more UUIDs are empty.  \nConversationId: $conversationId  SenderId: $senderId ReceiverId: $receiverId');

        return false;
      }

      // Prepare message data
      final newMessage = {
        'conversation_id': conversationId,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'content': content,
        'is_read': false,
        'file_urls': fileUrls ?? [],
      };

      // Insert message
      await _client.from('messages').insert(newMessage);

      // if (response != null && response.isNotEmpty) {
      //   // Update last message in conversation
      //   await _client
      //       .from('conversations')
      //       .update({
      //     'last_message': content,
      //     'updated_at': DateTime.now().toUtc().toIso8601String(),
      //     'is_seen': false,
      //   })
      //       .eq('id', conversationId);
      //
      //   return ChatModel.fromJson(response[0]);
      // }

      return true;
    } catch (e) {
      Log.e('Error sending message: $e');
      return false;
    }
  }

  // Mark messages as read
  Future<bool> markMessagesAsRead({
    required String conversationId,
    required String receiverId,
  }) async {
    try {
      // Update message read status
      await _client.from('messages').update({'is_read': true}).match({
        'conversation_id': conversationId,
        'receiver_id': receiverId,
        'is_read': false,
      });

      // Update conversation seen status
      await _client
          .from('conversations')
          .update({'is_seen': true}).eq('id', conversationId);

      return true;
    } catch (e) {
      Log.e('Error marking messages as read: $e');
      return false;
    }
  }

  // Set typing status
  Future<bool> setTypingStatus({
    required String conversationId,
    required bool isTyping,
  }) async {
    try {
      await _client
          .from('conversations')
          .update({'is_typing': isTyping}).eq('id', conversationId);

      return true;
    } catch (e) {
      Log.e('Error setting typing status: $e');
      return false;
    }
  }

  // Upload file to storage
  Future<List<String>> uploadFiles(
      List<dynamic> files, String conversationId) async {
    List<String> uploadedUrls = [];

    try {
      for (var file in files) {
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
        final filePath = 'chat_files/$conversationId/$fileName';

        final response =
            await _client.storage.from('chat_files').upload(filePath, file);

        if (response.isNotEmpty) {
          final fileUrl =
              _client.storage.from('chat_files').getPublicUrl(filePath);

          uploadedUrls.add(fileUrl);
        }
      }
    } catch (e) {
      Log.e('Error uploading files: $e');
    }

    return uploadedUrls;
  }
}
