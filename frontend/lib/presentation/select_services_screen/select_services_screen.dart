import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../book_appointment_screen/widgets/book_appointment_bottom_sheet.dart';

class ServiceOption {
  final String title;
  final IconData icon;

  const ServiceOption({
    required this.title,
    required this.icon,
  });
}

class SelectServicesScreen extends StatefulWidget {
  final String businessName;

  const SelectServicesScreen({
    super.key,
    this.businessName = TextConstants.sampleBusinessName,
  });

  @override
  State<SelectServicesScreen> createState() => _SelectServicesScreenState();
}

class _SelectServicesScreenState extends State<SelectServicesScreen> {
  final List<ServiceOption> _services = const [
    ServiceOption(
      title: TextConstants.serviceGeneralConsultation,
      icon: Icons.person_outline_rounded,
    ),
    ServiceOption(
      title: TextConstants.serviceDentalCheckup,
      icon: Icons.medical_services_outlined,
    ),
    ServiceOption(
      title: TextConstants.serviceSkinConsultation,
      icon: Icons.face_retouching_natural_outlined,
    ),
    ServiceOption(
      title: TextConstants.serviceEyeCheckup,
      icon: Icons.remove_red_eye_outlined,
    ),
    ServiceOption(
      title: TextConstants.serviceBloodTest,
      icon: Icons.science_outlined,
    ),
    ServiceOption(
      title: TextConstants.serviceOthers,
      icon: Icons.more_horiz_rounded,
    ),
  ];

  late final Set<String> _selectedTitles;

  @override
  void initState() {
    super.initState();
    // Default initial 2 selected items matching mockup
    _selectedTitles = {
      TextConstants.serviceGeneralConsultation,
      TextConstants.serviceDentalCheckup,
    };
  }

  void _toggleService(String title) {
    setState(() {
      if (_selectedTitles.contains(title)) {
        if (_selectedTitles.length > 1) {
          _selectedTitles.remove(title);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select at least one service.'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
            ),
          );
        }
      } else {
        _selectedTitles.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = _selectedTitles.length;

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
              // Top Medical Van / Badge Graphic
              _buildTopGraphic(),
              const SizedBox(height: 16),

              // Title
              const Text(
                TextConstants.selectServicesTitle,
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
                TextConstants.selectServicesSubtitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Services Checklist
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _services.length,
                  itemBuilder: (context, index) {
                    final item = _services[index];
                    final isSelected = _selectedTitles.contains(item.title);

                    return InkWell(
                      onTap: () => _toggleService(item.title),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? ColorConstants.primaryBlue
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 1.5 : 1.0,
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
                            // Leading Icon
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFEFF6FF)
                                    : const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                item.icon,
                                color: isSelected
                                    ? ColorConstants.primaryBlue
                                    : const Color(0xFF64748B),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),

                            // Service Title
                            Expanded(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: ColorConstants.textHeadline,
                                ),
                              ),
                            ),

                            // Checkbox
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorConstants.primaryBlue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isSelected
                                      ? ColorConstants.primaryBlue
                                      : const Color(0xFFCBD5E1),
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // "Continue (X Selected)" Primary Capsule Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    BookAppointmentBottomSheet.show(
                      context,
                      businessName: widget.businessName,
                      selectedServices: _selectedTitles.toList(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B132B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: Text(
                    '${TextConstants.continueButton} ($count Selected)',
                    style: const TextStyle(
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
          Icons.medical_services_rounded,
          color: ColorConstants.primaryBlue,
          size: 26,
        ),
      ),
    );
  }
}

