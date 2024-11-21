import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/shadow.dart';

class RecentConversations extends StatelessWidget {
  const RecentConversations({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 350,
        ),
        child: Container(
          padding: const EdgeInsets.all(standardSpacing),
          decoration: BoxDecoration(
            color: Colors.white, // Optional: Background color
            borderRadius: BorderRadius.circular(standardSpacing),
            boxShadow: [standardShadow],
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Shrink the column to fit its children
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Conversaciones Recientes',
                    style: TextStyle(
                        fontSize: standardSpacing, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Ver todo')),
                ],
              ),

              // Conversations List
              const SizedBox(height: standardSpacing),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // Number of conversations
                  itemBuilder: (context, index) {
                    return _ConversationItem(
                      avatarUrl:
                          'https://avatar.iran.liara.run/public', // Placeholder avatar
                      name: 'User Name $index',
                      lastMessageTime: '24 Jan 2023 | 04:00 PM',
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class _ConversationItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String lastMessageTime;

  const _ConversationItem({
    required this.avatarUrl,
    required this.name,
    required this.lastMessageTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: smallSpacing),
      child: Row(
        children: [
          // User Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 12),

          // Conversation Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  lastMessageTime,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // More Options
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
