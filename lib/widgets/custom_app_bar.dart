import 'package:flutter/material.dart';

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
            Color(0xFF7B61FF), // Start color of gradient
            Color(0xFF4263EB), // End color of gradient
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Spacer to center the logo
            const Spacer(),

            // Logo
            Image.asset(
              'assets/images/coach_logo.png',
              height: 50,
            ),

            // User Avatar
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(userAvatarUrl),
                radius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(80); // Adjust height as needed
}
