import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/dimen_constants.dart';
import '../../../constant/text_constants.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            size: 24,
            color: ColorConstants.textLight,
          ),
          const SizedBox(width: DimenConstants.spacingMedium),
          Expanded(
            child: TextField(
              onTap: () {
                // TODO: Navigate to Search & Auto-Suggest screen
              },
              onChanged: (query) {
                // TODO: Send search debounce query to backend business search API
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
    );
  }
}

