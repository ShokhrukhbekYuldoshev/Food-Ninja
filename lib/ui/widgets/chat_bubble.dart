import 'package:flutter/material.dart';
import 'package:food_ninja/models/message.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryColor : AppColors().cardColor,
          borderRadius: AppStyles.defaultBorderRadius,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isMe ? Colors.white : AppColors().textColor,
          ),
        ),
      ),
    );
  }
}
