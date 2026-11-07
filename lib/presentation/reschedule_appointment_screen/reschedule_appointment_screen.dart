import 'package:flutter/material.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';

class RescheduleDateItem {
  final String dayName;
  final String dateNumber;
  final String monthName;

  const RescheduleDateItem({
    required this.dayName,
    required this.dateNumber,
    required this.monthName,
  });
}

class RescheduleAppointmentScreen extends StatefulWidget {
  final String clinicName;
  final String rating;
  final String location;

  const RescheduleAppointmentScreen({
    super.key,
    this.clinicName = TextConstants.sampleBusinessName,
    this.rating = TextConstants.sampleBusinessRating,
    this.location = TextConstants.branchMainLocation,
  });

  @override
  State<RescheduleAppointmentScreen> createState() =>
      _RescheduleAppointmentScreenState();
}

class _RescheduleAppointmentScreenState
    extends State<RescheduleAppointmentScreen> {
  final List<RescheduleDateItem> _dates = const [
    RescheduleDateItem(dayName: 'Mon', dateNumber: '24', monthName: 'Nov'),
    RescheduleDateItem(dayName: 'Tue', dateNumber: '25', monthName: 'Nov'),
    RescheduleDateItem(dayName: 'Wed', dateNumber: '26', monthName: 'Nov'),
    RescheduleDateItem(dayName: 'Thu', dateNumber: '27', monthName: 'Nov'),
    RescheduleDateItem(dayName: 'Fri', dateNumber: '28', monthName: 'Nov'),
  ];

  final List<String> _slots = const [
    '9:00 AM – 9:15 AM',
    '9:15 AM – 9:30 AM',
    '9:30 AM – 9:45 AM',
    '9:45 AM – 10:00 AM',
    '10:00 AM – 10:15 AM',
  ];

  late int _selectedDateIndex;
  late int _selectedSlotIndex;

  @override
  void initState() {
    super.initState();
    _selectedDateIndex = 2; // Wed 26 default
    _selectedSlotIndex = 1; // 9:15 AM – 9:30 AM default matching mockup
  }

  void _onConfirm() {
    final selectedDate = _dates[_selectedDateIndex];
    final selectedSlot = _slots[_selectedSlotIndex];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Appointment rescheduled to ${selectedDate.dayName}, ${selectedDate.dateNumber} ${selectedDate.monthName} at $selectedSlot',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pop();
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
          TextConstants.rescheduleTitle,
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
              const SizedBox(height: 12),

              // Clinic Card Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        AssetConstants.lobbyReception,
                        width: 58,
                        height: 58,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Container(
                          width: 58,
                          height: 58,
                          color: const Color(0xFFEFF6FF),
                          child: const Icon(
                            Icons.local_hospital_rounded,
                            color: ColorConstants.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.clinicName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.textHeadline,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFF59E0B),
                                size: 16,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                widget.rating,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.textHeadline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.location,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // "Select Date"
              const Text(
                TextConstants.selectDateTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 12),

              // Horizontal Date Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_dates.length, (index) {
                  final item = _dates[index];
                  final isSelected = index == _selectedDateIndex;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedDateIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 58,
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                            ? const [
                                BoxShadow(
                                  color: Color(0x331D61F2),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.dayName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.9)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.dateNumber,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? Colors.white
                                  : ColorConstants.textHeadline,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.monthName,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.9)
                                  : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 26),

              // "Available Slots"
              const Text(
                TextConstants.availableSlotsTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 12),

              // Vertical Slots List
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _slots.length,
                  itemBuilder: (context, index) {
                    final slot = _slots[index];
                    final isSelected = index == _selectedSlotIndex;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedSlotIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEFF6FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? ColorConstants.primaryBlue
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 1.6 : 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              slot,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? ColorConstants.primaryBlue
                                    : ColorConstants.textHeadline,
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? ColorConstants.primaryBlue
                                    : Colors.transparent,
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
                                      size: 13,
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

              // "Confirm Reschedule" Capsule Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B132B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    TextConstants.confirmRescheduleButton,
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

