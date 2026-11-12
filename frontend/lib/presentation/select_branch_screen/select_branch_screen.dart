import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../select_services_screen/select_services_screen.dart';

class BranchItem {
  final String title;
  final String location;
  final String status;
  final String imageAsset;

  const BranchItem({
    required this.title,
    required this.location,
    required this.status,
    required this.imageAsset,
  });
}

class SelectBranchScreen extends StatefulWidget {
  final String businessName;

  const SelectBranchScreen({
    super.key,
    this.businessName = TextConstants.sampleBusinessName,
  });

  @override
  State<SelectBranchScreen> createState() => _SelectBranchScreenState();
}

class _SelectBranchScreenState extends State<SelectBranchScreen> {
  final List<BranchItem> _branches = const [
    BranchItem(
      title: TextConstants.branchMainTitle,
      location: TextConstants.branchMainLocation,
      status: TextConstants.branchHoursOpen,
      imageAsset: 'assets/images/clinic_waiting.jpg',
    ),
    BranchItem(
      title: TextConstants.branchCityCenterTitle,
      location: TextConstants.branchCityCenterLocation,
      status: TextConstants.branchHoursOpen,
      imageAsset: 'assets/images/reception_counter.jpg',
    ),
    BranchItem(
      title: TextConstants.branchPremiumTitle,
      location: TextConstants.branchPremiumLocation,
      status: TextConstants.branchHoursOpen,
      imageAsset: 'assets/images/clinic_room.jpg',
    ),
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0; // Default to Main Branch matching mockup
  }

  void _onContinue() {
    final selectedBranch = _branches[_selectedIndex];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SelectServicesScreen(
          businessName: '${widget.businessName} (${selectedBranch.title})',
        ),
      ),
    );
  }

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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Car/Ambulance Icon Graphic
              _buildTopGraphic(),
              const SizedBox(height: 16),

              // Title
              const Text(
                TextConstants.selectBranchTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),

              // Subtitle
              const Text(
                TextConstants.selectBranchSubtitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Branch Radio Cards
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _branches.length,
                  itemBuilder: (context, index) {
                    final branch = _branches[index];
                    final isSelected = index == _selectedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedIndex = index);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? ColorConstants.primaryBlue
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 1.6 : 1.0,
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
                                branch.imageAsset,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => Container(
                                  width: 56,
                                  height: 56,
                                  color: const Color(0xFFEFF6FF),
                                  child: const Icon(
                                    Icons.business_rounded,
                                    color: ColorConstants.primaryBlue,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),

                            // Branch Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    branch.title,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstants.textHeadline,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    branch.location,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF16A34A),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        branch.status,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF16A34A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Radio Indicator
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? ColorConstants.primaryBlue
                                      : const Color(0xFFCBD5E1),
                                  width: isSelected ? 6.0 : 1.5,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // "Continue" Primary Action Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B132B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    TextConstants.continueButton,
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

  Widget _buildTopGraphic() {
    return Container(
      width: 58,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(
          Icons.airport_shuttle_rounded,
          color: ColorConstants.primaryBlue,
          size: 26,
        ),
      ),
    );
  }
}

