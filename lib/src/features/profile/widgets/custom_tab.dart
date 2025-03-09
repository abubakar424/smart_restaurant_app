import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/app_colors.dart';

class UserReviewItem extends StatelessWidget {
  final String avatarImageUrl;
  final String title;
  final VoidCallback onTap;

  const UserReviewItem({
    Key? key,
    required this.avatarImageUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.tabColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Circle Avatar for Image
            CircleAvatar(
              radius: 24,
              child: SvgPicture.asset(avatarImageUrl),
            ),
            const SizedBox(width: 12),
            // Text for Title
            Expanded(
              child: Text(
                title,
                 style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                color: AppColors.textColor),
                ),
              ),
                Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.iconColor,
            ),
            
            // Right Arrow Icon
           
          ],
        ),
      ),
    );
  }
}
