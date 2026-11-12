import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../../cancellation_successful_screen/cancellation_successful_screen.dart';

class CancelQueueDialog extends StatelessWidget {
  final VoidCallback? onConfirmCancel;

  const CancelQueueDialog({
    super.key,
    this.onConfirmCancel,
  });

  static Future<bool?> show(
    BuildContext context, {
    VoidCallback? onConfirmCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => CancelQueueDialog(onConfirmCancel: onConfirmCancel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F0F172A),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Blue Exclamation Ring Icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConstants.primaryBlue,
                  width: 2,
                ),
                color: const Color(0xFFEFF6FF),
              ),
              child: const Center(
                child: Icon(
                  Icons.priority_high_rounded,
                  color: ColorConstants.primaryBlue,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title: "Cancel Queue?"
            const Text(
              TextConstants.cancelQueueTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ColorConstants.textHeadline,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            const Text(
              TextConstants.cancelQueueSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons: Keep Queue | Cancel Queue
            Row(
              children: [
                // Keep Queue
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      child: const Text(
                        TextConstants.keepQueueButton,
                        style: TextStyle(
                          color: ColorConstants.textHeadline,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Cancel Queue
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        onConfirmCancel?.call();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CancellationSuccessfulScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B132B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      child: const Text(
                        TextConstants.confirmCancelQueueButton,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

