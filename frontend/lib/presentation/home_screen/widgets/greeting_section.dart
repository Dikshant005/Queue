import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Dynamically format greeting (Good morning/afternoon/evening) based on device clock
    // TODO: Fetch user's first name from auth profile (e.g. "Good evening, Alex 👋")
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextConstants.greetingEvening,
          style: TextStyle(
            fontSize: DimenConstants.fontSizeHeadline,
            fontWeight: FontWeight.w800,
            color: ColorConstants.textHeadline,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: DimenConstants.spacingExtraSmall + 2),
        Text(
          TextConstants.greetingSubtitle,
          style: TextStyle(
            fontSize: DimenConstants.fontSizeSubtitle,
            fontWeight: FontWeight.w400,
            color: ColorConstants.textBody,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

