import 'package:flutter/material.dart';
import 'package:indigo/presentation/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userAvatarUrl; // Avatar image URL

  const CustomAppBar({super.key, required this.userAvatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            lightPurple,
            darkPurple,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Logo
            Image.asset(
              'assets/images/coach_logo.png',
              height: 50,
            ),

            // User Avatar
            const CircleAvatar(
              backgroundColor: Colors.white,
              foregroundImage: AssetImage("assets/images/coach.png"),
              radius: 20,
            ),

            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(80); // Adjust height as needed
}
