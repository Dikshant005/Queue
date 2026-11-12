import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../appointment_cancelled_screen/appointment_cancelled_screen.dart';

class CancelAppointmentScreen extends StatefulWidget {
  final String serviceTitle;
  final String clinicName;
  final String appointmentDateTime;

  const CancelAppointmentScreen({
    super.key,
    this.serviceTitle = TextConstants.dentalConsultationTitle,
    this.clinicName = TextConstants.sampleBusinessName,
    this.appointmentDateTime = 'Wed, 26 Nov • 10:00 AM',
  });

  @override
  State<CancelAppointmentScreen> createState() =>
      _CancelAppointmentScreenState();
}

class _CancelAppointmentScreenState extends State<CancelAppointmentScreen> {
  String? _selectedReason;
  final TextEditingController _notesController = TextEditingController();

  final List<String> _reasons = const [
    'Change of plans',
    'Booked by mistake',
    'Found another provider',
    'Doctor not available',
    'Personal emergency',
    'Other reason',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _onConfirmCancellation() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppointmentCancelledScreen(
          serviceTitle: widget.serviceTitle,
          clinicName: widget.clinicName,
          appointmentDateTime: widget.appointmentDateTime,
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
        title: const Text(
          TextConstants.cancelAppointmentTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: ColorConstants.textHeadline,
            letterSpacing: -0.4,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Calendar Icon with Red Cross Badge Illustration
              _buildCancellationIllustration(),
              const SizedBox(height: 20),

              // Headline
              const Text(
                TextConstants.cancelConfirmationHeadline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  height: 1.3,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),

              // Warning Caption
              const Text(
                TextConstants.actionCannotBeUndone,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 20),

              // Appointment Mini Preview Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFDBEAFE),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Tooth / Medical Icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.medical_services_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.serviceTitle,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.textHeadline,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.appointmentDateTime,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            widget.clinicName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section: Reason for Cancellation (Optional)
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  TextConstants.cancellationReasonLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textHeadline,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedReason,
                    hint: const Text(
                      TextConstants.selectReasonHint,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF64748B),
                    ),
                    items: _reasons.map((r) {
                      return DropdownMenuItem(
                        value: r,
                        child: Text(
                          r,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.textHeadline,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _selectedReason = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Multiline Text Box
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: TextField(
                  controller: _notesController,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorConstants.textHeadline,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: TextConstants.tellUsMoreHint,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Bottom Action Buttons
              Row(
                children: [
                  // Go Back
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFCBD5E1),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          TextConstants.goBackButton,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.textHeadline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Cancel Appointment
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _onConfirmCancellation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B132B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          TextConstants.cancelAppointmentButton,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCancellationIllustration() {
    return SizedBox(
      width: 110,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft blue glow
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
          ),
          // Calendar Icon
          const Icon(
            Icons.calendar_month_rounded,
            color: ColorConstants.primaryBlue,
            size: 58,
          ),
          // Red Cross Badge
          Positioned(
            right: 14,
            bottom: 12,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.2,
                ),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

