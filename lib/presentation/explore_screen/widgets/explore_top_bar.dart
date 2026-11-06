import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class ExploreTopBar extends StatelessWidget {
  const ExploreTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Input Field
        Expanded(
          child: Container(
            height: DimenConstants.inputHeight - 4,
            decoration: BoxDecoration(
              color: ColorConstants.inputBackground,
              borderRadius: BorderRadius.circular(DimenConstants.radiusLarge),
              border: Border.all(
                color: ColorConstants.inputBorder.withValues(alpha: 0.9),
                width: 1.1,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstants.spacingMedium,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 22,
                  color: ColorConstants.textLight,
                ),
                const SizedBox(width: DimenConstants.spacingSmall + 2),
                Expanded(
                  child: TextField(
                    onChanged: (query) {
                      // TODO: Send debounce search query to backend API
                    },
                    style: const TextStyle(
                      fontSize: DimenConstants.fontSizeBody,
                      color: ColorConstants.textHeadline,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: TextConstants.searchBusinessesHint,
                      hintStyle: TextStyle(
                        fontSize: DimenConstants.fontSizeBody,
                        color: ColorConstants.textLight,
                        fontWeight: FontWeight.w400,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: DimenConstants.spacingSmall + 2),

        // Filter Action Button (Sliders / Tune Icon)
        InkWell(
          onTap: () {
            // TODO: Open Filter & Sort Bottom Sheet (Distance, Rating, Wait Time, Open Status)
          },
          borderRadius: BorderRadius.circular(DimenConstants.radiusMedium),
          child: Container(
            width: DimenConstants.inputHeight - 4,
            height: DimenConstants.inputHeight - 4,
            decoration: BoxDecoration(
              color: ColorConstants.inputBackground,
              borderRadius: BorderRadius.circular(DimenConstants.radiusMedium),
              border: Border.all(
                color: ColorConstants.inputBorder.withValues(alpha: 0.9),
                width: 1.1,
              ),
            ),
            child: const Icon(
              Icons.tune_rounded,
              size: 22,
              color: ColorConstants.textHeadline,
            ),
          ),
        ),
      ],
    );
  }
}

