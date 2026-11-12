import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            // Leading Icon
            Icon(
              icon,
              size: 22,
              color: ColorConstants.textHeadline.withValues(alpha: 0.85),
            ),
            const SizedBox(width: 16),

            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textHeadline,
                ),
              ),
            ),

            // Trailing Chevron
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: ColorConstants.textLight,
            ),
          ],
        ),
      ),
    );
  }
}

