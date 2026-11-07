import 'package:flutter/material.dart';
import '../../constant/color_constants.dart';
import '../../constant/text_constants.dart';
import '../ticket_details_screen/ticket_details_screen.dart';

class CreateSupportTicketScreen extends StatefulWidget {
  final String? defaultCategory;

  const CreateSupportTicketScreen({
    super.key,
    this.defaultCategory,
  });

  @override
  State<CreateSupportTicketScreen> createState() =>
      _CreateSupportTicketScreenState();
}

class _CreateSupportTicketScreenState extends State<CreateSupportTicketScreen> {
  String? _selectedCategory;
  int _selectedPriority = 1; // 0: Low, 1: Medium, 2: High
  final TextEditingController _descController = TextEditingController();
  bool _hasAttachment = false;

  final List<String> _categories = const [
    'Queue Issues',
    'Appointment Issues',
    'Payment & Refund',
    'Technical Problem',
    'Account & Login',
    'Report a Problem',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.defaultCategory;
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final issueText = _descController.text.trim().isNotEmpty
        ? _descController.text.trim()
        : 'Unable to join queue at Northside Family Clinic';

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => TicketDetailsScreen(
          issueDescription: issueText,
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
          TextConstants.createSupportTicketTitle,
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
              const SizedBox(height: 12),

              // 1. Issue Category
              const Text(
                TextConstants.issueCategoryLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 8),

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
                child: Row(
                  children: [
                    const Icon(
                      Icons.headset_mic_outlined,
                      color: ColorConstants.primaryBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          hint: const Text(
                            TextConstants.selectCategoryHint,
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
                          items: _categories.map((c) {
                            return DropdownMenuItem(
                              value: c,
                              child: Text(
                                c,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.textHeadline,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() => _selectedCategory = val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // 2. Priority Selector
              const Text(
                TextConstants.priorityLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  _buildPriorityPill(0, TextConstants.priorityLow),
                  const SizedBox(width: 12),
                  _buildPriorityPill(1, TextConstants.priorityMedium),
                  const SizedBox(width: 12),
                  _buildPriorityPill(2, TextConstants.priorityHigh),
                ],
              ),

              const SizedBox(height: 22),

              // 3. Description
              const Text(
                TextConstants.descriptionLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 8),

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
                      controller: _descController,
                      maxLines: 4,
                      maxLength: 1000,
                      onChanged: (val) => setState(() {}),
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorConstants.textHeadline,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: TextConstants.describeIssueHint,
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
                        '${_descController.text.length}/1000',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // 4. Attach Files (Optional)
              const Text(
                TextConstants.attachFilesOptional,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textHeadline,
                ),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: () {
                  setState(() => _hasAttachment = !_hasAttachment);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _hasAttachment
                            ? 'Screenshot_20261124.png attached (1.2 MB)'
                            : 'Attachment removed',
                      ),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _hasAttachment
                          ? ColorConstants.primaryBlue
                          : const Color(0xFFCBD5E1),
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _hasAttachment
                            ? Icons.check_circle_rounded
                            : Icons.attach_file_rounded,
                        color: ColorConstants.primaryBlue,
                        size: 26,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _hasAttachment
                            ? 'Screenshot_20261124.png'
                            : TextConstants.tapToUpload,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: _hasAttachment
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _hasAttachment
                              ? ColorConstants.textHeadline
                              : const Color(0xFF64748B),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // "Submit Ticket" Capsule Button
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
                    TextConstants.submitTicketButton,
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

  Widget _buildPriorityPill(int index, String label) {
    final isSelected = _selectedPriority == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 42,
          decoration: BoxDecoration(
            color: isSelected
                ? ColorConstants.primaryBlue
                : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(21),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

