import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import 'providers/location_provider.dart';

class SelectLocationScreen extends ConsumerStatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  ConsumerState<SelectLocationScreen> createState() =>
      _SelectLocationScreenState();
}

class _SelectLocationScreenState extends ConsumerState<SelectLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  late String _tempSelectedLocation;

  @override
  void initState() {
    super.initState();
    _tempSelectedLocation = ref.read(locationProvider);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onConfirmLocation() {
    ref.read(locationProvider.notifier).setLocation(_tempSelectedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = ref.watch(locationProvider);
    final popularLocations = ref.watch(popularLocationsProvider);

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
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetConstants.logo,
              height: 28,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.waves_rounded,
                color: ColorConstants.primaryBlue,
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              TextConstants.appName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: ColorConstants.textHeadline,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Search Location Bar
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F8FC),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF94A3B8),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.textHeadline,
                        ),
                        decoration: const InputDecoration(
                          hintText: TextConstants.searchLocationHint,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            setState(() => _tempSelectedLocation = value.trim());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // "Current Location" Section Header
              const Text(
                TextConstants.currentLocationTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 12),

              // Current Location Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x080F172A),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Blue Location Pin Badge
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.location_on,
                          color: ColorConstants.primaryBlue,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Current Location Text
                    Expanded(
                      child: Text(
                        _tempSelectedLocation.isNotEmpty
                            ? _tempSelectedLocation
                            : currentLocation,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.textHeadline,
                        ),
                      ),
                    ),

                    // "Change" Action Button
                    TextButton(
                      onPressed: () {
                        // Focus on search input to change location
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: const Text(
                        TextConstants.changeButton,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // "Popular Locations" Section Header
              const Text(
                TextConstants.popularLocationsTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 12),

              // Popular Locations List
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: popularLocations.length,
                  separatorBuilder: (_, _) => const Divider(
                    color: Color(0xFFF1F5F9),
                    height: 1,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final location = popularLocations[index];
                    final isSelected = location == _tempSelectedLocation;

                    return InkWell(
                      onTap: () {
                        setState(() => _tempSelectedLocation = location);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: isSelected
                                  ? ColorConstants.primaryBlue
                                  : const Color(0xFF64748B),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                location,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? ColorConstants.primaryBlue
                                      : ColorConstants.textHeadline,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: ColorConstants.primaryBlue,
                                size: 18,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // "Select Location" Primary Capsule Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _onConfirmLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B132B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    TextConstants.selectLocationButton,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

