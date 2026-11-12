import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/color_constants.dart';
import '../../edit_profile_screen/edit_profile_screen.dart';
import '../providers/profile_provider.dart';

class ProfileUserCard extends ConsumerWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EditProfileScreen(
              initialName: profile.name,
              initialEmail: profile.email,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
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
            Expanded(
              child: Column(
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
            ),

            // Edit Profile Icon
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFCBD5E1),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

