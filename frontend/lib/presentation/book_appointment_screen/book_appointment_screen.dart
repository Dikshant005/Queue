import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../appointment_booked_screen/appointment_booked_screen.dart';

class DateOption {
  final String dayName;
  final String dateNumber;
  final String fullDateString;

  const DateOption({
    required this.dayName,
    required this.dateNumber,
    required this.fullDateString,
  });
}

class BookAppointmentScreen extends StatefulWidget {
  final String businessName;
  final List<String> selectedServices;

  const BookAppointmentScreen({
    super.key,
    this.businessName = TextConstants.sampleBusinessName,
    this.selectedServices = const [
      TextConstants.serviceGeneralConsultation,
      TextConstants.serviceDentalCheckup,
    ],
  });

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
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
    // Default to Wednesday 26 at 10:00 AM matching mockup
    _selectedDateIndex = 2;
    _selectedSlot = '10:00 AM';
  }

  void _onContinue() {
    final chosenDate = _dates[_selectedDateIndex].fullDateString;
    final scheduledDateTime = '$chosenDate • $_selectedSlot';

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
          TextConstants.bookAppointmentTitle,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Horizontal Date Picker Row
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
              const SizedBox(height: 36),

              // "Available Slots" Section Title
              const Text(
                TextConstants.availableSlotsTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 18),

              // Time Slots Grid (2 rows of 3)
              Wrap(
                spacing: 12,
                runSpacing: 14,
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

              const Spacer(),

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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

