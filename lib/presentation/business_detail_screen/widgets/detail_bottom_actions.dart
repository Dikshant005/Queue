import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';
import '../../queue_success_screen/queue_success_screen.dart';

class DetailBottomActions extends StatelessWidget {
  const DetailBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DimenConstants.screenHorizontalPadding,
        vertical: DimenConstants.spacingSmall + 2,
      ),
      decoration: BoxDecoration(
        color: ColorConstants.scaffoldBackground,
        border: const Border(
          top: BorderSide(
            color: ColorConstants.subtleBorder,
            width: 1.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.shadowColor.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // "Join Queue" (Dark Navy Pill Button)
            Expanded(
              child: SizedBox(
                height: DimenConstants.buttonHeight - 4,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const QueueSuccessScreen(),
                      ),
                    );
                    // TODO: Call backend Queue API to generate live token and add user to queue
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.darkButtonBackground,
                    foregroundColor: ColorConstants.textWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DimenConstants.radiusPill,
                      ),
                    ),
                  ),
                  child: const Text(
                    TextConstants.joinQueueButton,
                    style: TextStyle(
                      fontSize: DimenConstants.fontSizeBody,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: DimenConstants.spacingMedium - 2),

            // "Book Appointment" (Outlined Blue Pill Button)
            Expanded(
              child: SizedBox(
                height: DimenConstants.buttonHeight - 4,
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Open Appointment Booking calendar & time slot picker
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening appointment scheduler...'),
                        backgroundColor: ColorConstants.primaryBlue,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: ColorConstants.scaffoldBackground,
                    side: const BorderSide(
                      color: ColorConstants.primaryBlue,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DimenConstants.radiusPill,
                      ),
                    ),
                  ),
                  child: const Text(
                    TextConstants.bookAppointmentButton,
                    style: TextStyle(
                      fontSize: DimenConstants.fontSizeBody,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.primaryBlue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

