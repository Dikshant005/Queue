import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';

class NotificationsTopBar extends StatelessWidget {
  const NotificationsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Padding(
      padding: EdgeInsets.only(
        left: canPop ? 8 : 20,
        right: 20,
        top: 14,
        bottom: 8,
      ),
      child: Row(
        children: [
          if (canPop)
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 30,
                color: ColorConstants.textHeadline,
              ),
              splashRadius: 24,
            ),
          const Text(
            TextConstants.notificationsTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: ColorConstants.textHeadline,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

