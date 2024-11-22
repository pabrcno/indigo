import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/spacings.dart';
import 'package:indigo/presentation/widgets/plans_card.dart';
import 'package:indigo/presentation/widgets/recent_conversation.dart';
import 'package:indigo/presentation/widgets/task_card.dart';
import 'package:indigo/presentation/widgets/view_users_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(standardSpacing),
        child: isWideScreen
            ? const Row(
                key: Key('homeScreenMainRow'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      key: Key('homeScreenLeftColumn'),
                      children: [
                        TaskCard(),
                        SizedBox(height: standardSpacing),
                        ViewUsersWidget(),
                        SizedBox(height: standardSpacing),
                        Expanded(
                          child: RecentConversations(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: standardSpacing),
                  PlansCard(),
                ],
              )
            : ListView(
                key: const Key('homeScreenListView'),
                children: const [
                  TaskCard(),
                  SizedBox(height: standardSpacing),
                  ViewUsersWidget(),
                  SizedBox(height: standardSpacing),
                  RecentConversations(),
                  SizedBox(height: standardSpacing),
                  PlansCard(),
                ],
              ),
      ),
    );
  }
}
