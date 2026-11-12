import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';

class ActivityHeader extends StatelessWidget {
  const ActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 12),
      child: Text(
        TextConstants.myAppointments,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: ColorConstants.textHeadline,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

