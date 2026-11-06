import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../providers/profile_provider.dart';

class ProfileUserCard extends ConsumerWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Circular Avatar
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                profile.avatarInitial,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.primaryBlue,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // User Name & Email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                profile.email,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textBody,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

