import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constant/asset_constants.dart';
import '../../../constant/color_constants.dart';
import '../providers/business_detail_provider.dart';

class DetailHeaderImage extends ConsumerWidget {
  final String? imageAsset;

  const DetailHeaderImage({
    super.key,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(businessFavoriteProvider);

    return Stack(
      children: [
        // Clinic Header Photo
        Container(
          height: 250,
          width: double.infinity,
          color: ColorConstants.lightBlueBackground,
          child: Image.asset(
            imageAsset ?? AssetConstants.lobbyReception,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.storefront_rounded,
                  size: 60,
                  color: ColorConstants.textLight,
                ),
              );
            },
          ),
        ),

        // Floating Action Buttons (Back, Favorite, Share)
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Circular Back Button
                _buildCircleButton(
                  onTap: () => Navigator.of(context).pop(),
                  icon: Icons.chevron_left_rounded,
                  iconSize: 26,
                ),

                // Trailing Action Buttons
                Row(
                  children: [
                    // Favorite / Heart Button
                    _buildCircleButton(
                      onTap: () {
                        ref.read(businessFavoriteProvider.notifier).toggle();
                      },
                      icon: isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      iconColor: isFavorite
                          ? Colors.redAccent
                          : ColorConstants.textHeadline,
                    ),

                    const SizedBox(width: 10),

                    // Share Button
                    _buildCircleButton(
                      onTap: () {
                        // TODO: Trigger native system share sheet with business referral link
                      },
                      icon: Icons.share_outlined,
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleButton({
    required VoidCallback onTap,
    required IconData icon,
    Color iconColor = ColorConstants.textHeadline,
    double iconSize = 22,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorConstants.cardBackground.withValues(alpha: 0.95),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: ColorConstants.shadowColor,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

