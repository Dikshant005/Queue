import 'package:flutter/material.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../business_detail_screen/business_detail_screen.dart';

class FavoriteBusiness {
  final String name;
  final String subtitle;
  final String imageAsset;
  final bool isFavorite;

  const FavoriteBusiness({
    required this.name,
    required this.subtitle,
    required this.imageAsset,
    this.isFavorite = true,
  });
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTabIndex = 0; // 0: Businesses, 1: Services

  final List<FavoriteBusiness> _businesses = [
    const FavoriteBusiness(
      name: TextConstants.sampleBusinessName,
      subtitle: '1.2 km • ★ 4.8',
      imageAsset: AssetConstants.lobbyReception,
    ),
    const FavoriteBusiness(
      name: TextConstants.sampleSalonName,
      subtitle: TextConstants.sampleSalonSubtitle,
      imageAsset: AssetConstants.lobbyReception,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
            color: ColorConstants.textHeadline,
          ),
          splashRadius: 24,
        ),
        title: const Text(
          TextConstants.favoritesTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: ColorConstants.textHeadline,
            letterSpacing: -0.4,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Tab Selector: Businesses | Services
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildTab(0, TextConstants.tabBusinesses),
                  const SizedBox(width: 24),
                  _buildTab(1, TextConstants.tabFavoritesServices),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 16),

            // Content List
            Expanded(
              child: _selectedTabIndex == 0
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _businesses.length,
                      itemBuilder: (context, index) {
                        final item = _businesses[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const BusinessDetailScreen(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x060F172A),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Thumbnail Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    item.imageAsset,
                                    width: 58,
                                    height: 58,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, stack) =>
                                        Container(
                                      width: 58,
                                      height: 58,
                                      color: const Color(0xFFEFF6FF),
                                      child: const Icon(
                                        Icons.storefront_rounded,
                                        color: ColorConstants.primaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Business Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.textHeadline,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.subtitle,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Red Heart Favorite Icon
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _businesses.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.favorite_rounded,
                                    color: Color(0xFFEF4444),
                                    size: 22,
                                  ),
                                  splashRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No favorite services yet.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? ColorConstants.primaryBlue
                  : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 2.5,
            width: 48,
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorConstants.primaryBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
