import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/asset_constants.dart';
import '../../constant/color_constants.dart';
import '../../constant/dimen_constants.dart';
import '../../constant/text_constants.dart';
import '../home_screen/home_screen.dart';
import 'otp_verification_screen/otp_verification_screen.dart';
import 'providers/auth_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final currentTab = ref.watch(authTabProvider);
    final isLogin = currentTab.isLogin;

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackground,
      body: Stack(
        children: [
          // Top-right layered fluid curved waves
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: Size(screenSize.width * 0.75, screenSize.height * 0.28),
              painter: _AuthTopRightWavesPainter(),
            ),
          ),

          // Bottom-left subtle fluid waves
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomPaint(
              size: Size(screenSize.width * 0.55, screenSize.height * 0.22),
              painter: _AuthBottomLeftWavesPainter(),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstants.screenHorizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: DimenConstants.spacingMedium),

                  // Header: Logo + FLOWGUARD brand name
                  Row(
                    children: [
                      Image.asset(
                        AssetConstants.logo,
                        height: DimenConstants.authLogoSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.waves_rounded,
                            size: DimenConstants.authLogoSize,
                            color: ColorConstants.primaryBlue,
                          );
                        },
                      ),
                      const SizedBox(width: DimenConstants.spacingSmall + 2),
                      const Text(
                        TextConstants.appName,
                        style: TextStyle(
                          fontSize: DimenConstants.fontSizeAuthBrand,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.8,
                          color: ColorConstants.textHeadline,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: DimenConstants.spacingExtraLarge),

                  // Dynamic Title & Subtitle
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Column(
                      key: ValueKey<bool>(isLogin),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLogin
                              ? TextConstants.welcomeBack
                              : TextConstants.createAccount,
                          style: const TextStyle(
                            fontSize: DimenConstants.fontSizeHeadline,
                            fontWeight: FontWeight.w800,
                            color: ColorConstants.textHeadline,
                          ),
                        ),
                        const SizedBox(height: DimenConstants.spacingSmall),
                        Text(
                          isLogin
                              ? TextConstants.signInSubtitle
                              : TextConstants.signUpSubtitle,
                          style: const TextStyle(
                            fontSize: DimenConstants.fontSizeSubtitle,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.textBody,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingExtraLarge),

                  // Login / Sign Up Tabs
                  _buildTabs(ref, currentTab),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // Form Fields
                  if (!isLogin) ...[
                    _buildTextField(
                      hint: TextConstants.nameInputHint,
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: DimenConstants.spacingMedium),
                  ],

                  _buildTextField(
                    hint: TextConstants.phoneInputHint,
                    icon: Icons.phone_iphone_rounded,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // Primary Action Button ("Send OTP")
                  SizedBox(
                    width: double.infinity,
                    height: DimenConstants.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OtpVerificationScreen(),
                          ),
                        );
                        // TODO: Call backend Authentication API to send SMS OTP code
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.darkButtonBackground,
                        foregroundColor: ColorConstants.textWhite,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            DimenConstants.radiusPill,
                          ),
                        ),
                      ),
                      child: const Text(
                        TextConstants.sendOtp,
                        style: TextStyle(
                          fontSize: DimenConstants.fontSizeSubtitle,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // "or" Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: ColorConstants.dividerLine,
                          thickness: 1.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimenConstants.spacingMedium,
                        ),
                        child: Text(
                          TextConstants.orDivider,
                          style: const TextStyle(
                            fontSize: DimenConstants.fontSizeSmall,
                            color: ColorConstants.textLight,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: ColorConstants.dividerLine,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // Continue with Google
                  _buildSocialButton(
                    onTap: () {},
                    label: TextConstants.continueWithGoogle,
                    iconWidget: Image.asset(
                      AssetConstants.googleLogo,
                      height: DimenConstants.socialIconSize,
                      width: DimenConstants.socialIconSize,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.g_mobiledata_rounded,
                          size: 26,
                          color: Colors.redAccent,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingMedium),

                  // Continue with Apple
                  _buildSocialButton(
                    onTap: () {},
                    label: TextConstants.continueWithApple,
                    iconWidget: const Icon(
                      Icons.apple,
                      size: DimenConstants.socialIconSize + 2,
                      color: ColorConstants.primaryDark,
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // Continue as Guest
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Bypass authentication and navigate to HomeScreen as guest
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HomeScreen(),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 400),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: ColorConstants.primaryBlue,
                      ),
                      child: const Text(
                        TextConstants.continueAsGuest,
                        style: TextStyle(
                          fontSize: DimenConstants.fontSizeBody,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingLarge),

                  // Legal Terms and Privacy Policy
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: DimenConstants.fontSizeTerms,
                          color: ColorConstants.textBody,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: '${TextConstants.termsNoticePrefix}\n',
                          ),
                          TextSpan(
                            text: TextConstants.termsOfService,
                            style: const TextStyle(
                              color: ColorConstants.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(
                            text: TextConstants.andConjunction,
                          ),
                          TextSpan(
                            text: TextConstants.privacyPolicy,
                            style: const TextStyle(
                              color: ColorConstants.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: DimenConstants.spacingExtraLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(WidgetRef ref, AuthTab currentTab) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    ref.read(authTabProvider.notifier).selectTab(AuthTab.login),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DimenConstants.spacingSmall,
                  ),
                  child: Center(
                    child: Text(
                      TextConstants.loginTab,
                      style: TextStyle(
                        fontSize: DimenConstants.fontSizeSubtitle,
                        fontWeight: currentTab.isLogin
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: currentTab.isLogin
                            ? ColorConstants.primaryBlue
                            : ColorConstants.tabInactiveText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    ref.read(authTabProvider.notifier).selectTab(AuthTab.signUp),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DimenConstants.spacingSmall,
                  ),
                  child: Center(
                    child: Text(
                      TextConstants.signUpTab,
                      style: TextStyle(
                        fontSize: DimenConstants.fontSizeSubtitle,
                        fontWeight: currentTab.isSignUp
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: currentTab.isSignUp
                            ? ColorConstants.primaryBlue
                            : ColorConstants.tabInactiveText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            // Base subtle horizontal line
            Container(
              height: 2.0,
              color: ColorConstants.subtleBorder,
            ),
            // Animated indicator underline
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: currentTab.isLogin
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: ColorConstants.tabIndicatorColor,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: DimenConstants.inputHeight,
      decoration: BoxDecoration(
        color: ColorConstants.inputBackground,
        borderRadius: BorderRadius.circular(DimenConstants.radiusInput),
        border: Border.all(
          color: ColorConstants.inputBorder.withValues(alpha: 0.8),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DimenConstants.spacingMedium,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22.0,
            color: ColorConstants.textBody,
          ),
          const SizedBox(width: DimenConstants.spacingMedium),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: DimenConstants.fontSizeBody,
                color: ColorConstants.textHeadline,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: DimenConstants.fontSizeBody,
                  color: ColorConstants.textLight,
                  fontWeight: FontWeight.w400,
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required String label,
    required Widget iconWidget,
  }) {
    return SizedBox(
      width: double.infinity,
      height: DimenConstants.socialButtonHeight,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorConstants.scaffoldBackground,
          side: const BorderSide(
            color: ColorConstants.socialButtonBorder,
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimenConstants.radiusPill),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: DimenConstants.spacingMedium),
            Text(
              label,
              style: const TextStyle(
                fontSize: DimenConstants.fontSizeSubtitle - 1,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textHeadline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for top-right layered fluid curved waves
class _AuthTopRightWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Light sky blue background wave
    final lightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          ColorConstants.splashWaveLight.withValues(alpha: 0.5),
          ColorConstants.splashWaveMedium.withValues(alpha: 0.6),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final path1 = Path();
    path1.moveTo(0, 0);
    path1.quadraticBezierTo(w * 0.4, h * 0.6, w, h * 0.45);
    path1.lineTo(w, 0);
    path1.close();
    canvas.drawPath(path1, lightPaint);

    // 2. Royal blue middle wave
    final midPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          ColorConstants.splashWaveMedium,
          ColorConstants.primaryBlue,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(w * 0.25, 0, w * 0.75, h));

    final path2 = Path();
    path2.moveTo(w * 0.25, 0);
    path2.quadraticBezierTo(w * 0.55, h * 0.85, w, h * 0.75);
    path2.lineTo(w, 0);
    path2.close();
    canvas.drawPath(path2, midPaint);

    // 3. Deep dark navy wave
    final darkPaint = Paint()..color = ColorConstants.splashWaveDark;

    final path3 = Path();
    path3.moveTo(w * 0.5, 0);
    path3.quadraticBezierTo(w * 0.75, h, w, h * 0.95);
    path3.lineTo(w, 0);
    path3.close();
    canvas.drawPath(path3, darkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for bottom-left subtle fluid waves
class _AuthBottomLeftWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final lightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          ColorConstants.splashWaveLight.withValues(alpha: 0.4),
          ColorConstants.splashWaveMedium.withValues(alpha: 0.25),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final path = Path();
    path.moveTo(0, h * 0.35);
    path.quadraticBezierTo(w * 0.55, h * 0.65, 0, h);
    path.close();
    canvas.drawPath(path, lightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

