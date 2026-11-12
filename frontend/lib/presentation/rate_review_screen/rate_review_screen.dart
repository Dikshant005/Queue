import 'package:flutter/material.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';

class RateReviewScreen extends StatefulWidget {
  final String clinicName;
  final String rating;

  const RateReviewScreen({
    super.key,
    this.clinicName = TextConstants.sampleBusinessName,
    this.rating = TextConstants.sampleBusinessRating,
  });

  @override
  State<RateReviewScreen> createState() => _RateReviewScreenState();
}

class _RateReviewScreenState extends State<RateReviewScreen> {
  int _selectedStars = 4;
  final TextEditingController _reviewController = TextEditingController();
  final Set<String> _selectedTags = {'Cleanliness', 'Staff Behavior'};

  final List<String> _tags = const [
    TextConstants.chipCleanliness,
    TextConstants.chipStaffBehavior,
    TextConstants.chipServiceQuality,
    TextConstants.chipShortWaitTime,
  ];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Your review has been submitted.'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
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
          TextConstants.rateReviewTitle,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Clinic Card Banner
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
                        width: 72,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Container(
                          width: 72,
                          height: 52,
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
                          const SizedBox(height: 4),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Section: "Your Rating"
              const Text(
                TextConstants.yourRatingTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 14),

              // 5 Star Rating Row
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starNumber = index + 1;
                        final isFilled = starNumber <= _selectedStars;

                        return GestureDetector(
                          onTap: () => setState(() => _selectedStars = starNumber),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                              color: isFilled
                                  ? const Color(0xFFF59E0B)
                                  : const Color(0xFFCBD5E1),
                              size: 38,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_selectedStars out of 5',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.textHeadline,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Section: "Your Review (Optional)"
              const Text(
                TextConstants.yourReviewOptional,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 12),

              // Review Text Area
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    TextField(
                      controller: _reviewController,
                      maxLines: 4,
                      maxLength: 500,
                      onChanged: (val) => setState(() {}),
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorConstants.textHeadline,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: TextConstants.shareExperienceHint,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF94A3B8),
                        ),
                        counterText: '',
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '${_reviewController.text.length}/500',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section: "What did you like?"
              const Text(
                TextConstants.whatDidYouLike,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 12),

              // Chips
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _tags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTags.remove(tag);
                        } else {
                          _selectedTags.add(tag);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFEFF6FF)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? ColorConstants.primaryBlue
                              : const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? ColorConstants.primaryBlue
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 36),

              // Submit Review Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B132B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  child: const Text(
                    TextConstants.submitReviewButton,
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

