import 'package:flutter/material.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/text_constants.dart';
import '../../appointment_booked_screen/appointment_booked_screen.dart';
import '../book_appointment_screen.dart';

class BookAppointmentBottomSheet extends StatefulWidget {
  final String businessName;
  final List<String> selectedServices;

  const BookAppointmentBottomSheet({
    super.key,
    this.businessName = TextConstants.sampleBusinessName,
    this.selectedServices = const [
      TextConstants.serviceGeneralConsultation,
      TextConstants.serviceDentalCheckup,
    ],
  });

  static Future<void> show(
    BuildContext context, {
    String businessName = TextConstants.sampleBusinessName,
    List<String> selectedServices = const [
      TextConstants.serviceGeneralConsultation,
      TextConstants.serviceDentalCheckup,
    ],
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BookAppointmentBottomSheet(
        businessName: businessName,
        selectedServices: selectedServices,
      ),
    );
  }

  @override
  State<BookAppointmentBottomSheet> createState() =>
      _BookAppointmentBottomSheetState();
}

class _BookAppointmentBottomSheetState
    extends State<BookAppointmentBottomSheet> {
  final List<DateOption> _dates = const [
    DateOption(dayName: 'Mon', dateNumber: '24', fullDateString: 'Mon, 24 Oct'),
    DateOption(dayName: 'Tue', dateNumber: '25', fullDateString: 'Tue, 25 Oct'),
    DateOption(dayName: 'Wed', dateNumber: '26', fullDateString: 'Wed, 26 Oct'),
    DateOption(dayName: 'Thu', dateNumber: '27', fullDateString: 'Thu, 27 Oct'),
    DateOption(dayName: 'Fri', dateNumber: '28', fullDateString: 'Fri, 28 Oct'),
  ];

  final List<String> _slots = const [
    '9:00 AM',
    '9:15 AM',
    '9:30 AM',
    '9:45 AM',
    '10:00 AM',
    '10:15 AM',
  ];

  late int _selectedDateIndex;
  late String _selectedSlot;

  @override
  void initState() {
    super.initState();
    _selectedDateIndex = 2; // Wed 26 default
    _selectedSlot = '10:00 AM';
  }

  void _onContinue() {
    final chosenDate = _dates[_selectedDateIndex].fullDateString;
    final scheduledDateTime = '$chosenDate • $_selectedSlot';

    // Close bottom sheet first
    Navigator.of(context).pop();

    // Navigate to AppointmentBookedScreen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppointmentBookedScreen(
          businessName: widget.businessName,
          appointmentDateTime: scheduledDateTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Top Drag Handle
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Row: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  TextConstants.bookAppointmentTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.textHeadline,
                    letterSpacing: -0.4,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF64748B),
                    size: 22,
                  ),
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Horizontal Date Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_dates.length, (index) {
                final date = _dates[index];
                final isSelected = index == _selectedDateIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedDateIndex = index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 58,
                    height: 72,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorConstants.primaryBlue
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? ColorConstants.primaryBlue
                            : const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                      boxShadow: isSelected
                          ? [
                              const BoxShadow(
                                color: Color(0x331D61F2),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ]
                          : const [
                              BoxShadow(
                                color: Color(0x060F172A),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          date.dayName,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.9)
                                : const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          date.dateNumber,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isSelected
                                ? Colors.white
                                : ColorConstants.textHeadline,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 28),

            // Section: Available Slots
            const Text(
              TextConstants.availableSlotsTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: ColorConstants.textHeadline,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 14),

            // Slots Grid
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _slots.map((slot) {
                final isSelected = slot == _selectedSlot;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedSlot = slot);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: (MediaQuery.of(context).size.width - 64) / 3,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEFF6FF)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? ColorConstants.primaryBlue
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 1.8 : 1.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x060F172A),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        slot,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: isSelected
                              ? ColorConstants.primaryBlue
                              : ColorConstants.textHeadline,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // Continue Button
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

