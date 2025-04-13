import 'package:flutter/material.dart';
import '../../../data/repositories/chat_repository.dart';
import '../../../domain/models/chat.dart';
import '../../../utils/date_utils.dart';

class CommunityChatTab extends StatelessWidget {
  const CommunityChatTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversations = ChatRepository().getConversations();
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchField(context),
          const SizedBox(height: 16),
          _buildOnlineFriends(context),
          const SizedBox(height: 16),
          _buildConversationsList(context, conversations),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start new conversation
        },
        heroTag: 'chatFAB',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.message),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Search in messages',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineFriends(BuildContext context) {
    final onlineFriends = ChatRepository().getConversations().where((conv) => conv.isOnline).toList();
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Online Now',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: onlineFriends.length,
              itemBuilder: (context, index) {
                final friend = onlineFriends[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(friend.userAvatar),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        friend.userName.split(' ')[0],
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsList(BuildContext context, List<ChatConversation> conversations) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Messages',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: conversations.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              indent: 76,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            ),
            itemBuilder: (context, index) {
              return _buildConversationItem(context, conversations[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConversationItem(BuildContext context, ChatConversation conversation) {
    return InkWell(
      onTap: () {
        // Open conversation
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(conversation.userAvatar),
                ),
                if (conversation.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conversation.userName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: conversation.isUnread ? FontWeight.bold : FontWeight.normal,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        _formatTime(conversation.lastMessageTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: conversation.isUnread
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: conversation.isUnread ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (conversation.isUnread)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inDays > 0) {
      if (difference.inDays > 7) {
        return DateFormatter.formatPostDate(time);
      } else {
        return '${difference.inDays}d';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
} 