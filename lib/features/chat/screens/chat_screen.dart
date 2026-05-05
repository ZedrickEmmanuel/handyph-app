import 'package:flutter/material.dart';
import 'package:handyph_app/shared/widgets/placeholder_screen.dart';
import 'package:handyph_app/core/theme/app_colors.dart';

/// Chat — Chat Screen (Placeholder)
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Chat',
      icon: Icons.chat_rounded,
      accentColor: AppColors.primary,
    );
  }
}
