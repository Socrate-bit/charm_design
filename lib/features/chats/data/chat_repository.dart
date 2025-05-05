import '../domain/chat.dart';

class ChatRepository {
  List<ChatConversation> getConversations() {
    return [
      ChatConversation(
        id: 'chat1',
        userId: 'user1',
        userName: 'John Smith',
        userAvatar: 'https://i.pravatar.cc/150?img=1',
        lastMessage: 'Thanks for the advice! I\'ll give it a try.',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        isUnread: true,
        isOnline: true,
      ),
      ChatConversation(
        id: 'chat2',
        userId: 'user2',
        userName: 'Sarah Johnson',
        userAvatar: 'https://i.pravatar.cc/150?img=3',
        lastMessage: 'How\'s your fitness journey going so far?',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        isUnread: true,
        isOnline: false,
      ),
      ChatConversation(
        id: 'chat3',
        userId: 'user3',
        userName: 'Michael Brown',
        userAvatar: 'https://i.pravatar.cc/150?img=4',
        lastMessage: 'I hit my goal weight this month!',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
        isUnread: false,
        isOnline: true,
      ),
      ChatConversation(
        id: 'chat4',
        userId: 'user4',
        userName: 'Emma Wilson',
        userAvatar: 'https://i.pravatar.cc/150?img=9',
        lastMessage: 'Could you recommend a good protein powder?',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        isUnread: false,
        isOnline: false,
      ),
      ChatConversation(
        id: 'chat5',
        userId: 'user5',
        userName: 'David Chen',
        userAvatar: 'https://i.pravatar.cc/150?img=7',
        lastMessage: 'Let\'s catch up this weekend for a run!',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
        isUnread: false,
        isOnline: false,
      ),
    ];
  }

  List<ChatMessage> getMessagesForChat(String chatId) {
    // Mock implementation - would normally filter by chatId
    return [
      ChatMessage(
        id: 'msg1',
        senderId: 'user1', // not current user
        content: 'Hey, how are you doing with your wellness goals?',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
      ),
      ChatMessage(
        id: 'msg2',
        senderId: 'current_user',
        content: 'I\'ve been doing pretty well! Lost 5 pounds this month.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 45)),
        isRead: true,
      ),
      ChatMessage(
        id: 'msg3',
        senderId: 'user1',
        content: 'That\'s amazing progress! What\'s been your strategy?',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 30)),
        isRead: true,
      ),
      ChatMessage(
        id: 'msg4',
        senderId: 'current_user',
        content: 'Mostly portion control and walking 10,000 steps a day. It\'s been challenging but worth it!',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
        isRead: true,
      ),
      ChatMessage(
        id: 'msg5',
        senderId: 'user1',
        content: 'I should try that approach too. Been struggling with consistency lately.',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        isRead: true,
      ),
      ChatMessage(
        id: 'msg6',
        senderId: 'current_user',
        content: 'Start small and build up! Maybe aim for 5,000 steps first?',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      ChatMessage(
        id: 'msg7',
        senderId: 'user1',
        content: 'That sounds doable. Thanks for the advice! I\'ll give it a try.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),
    ];
  }
} 