// lib/pages/tutorial_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// TutorialCoach is a small helper that shows a one-time tutorial
/// for the bottom navigation icons. Call:
///   TutorialCoach.showBottomNavTutorial(context, homeKey: ..., ...)
/// from your HomePage (after the first frame).
class TutorialCoach {
  /// Show the bottom-nav tutorial. Provide the same GlobalKeys you passed to BottomNavBar.
  /// Set forceShow=true to ignore SharedPreferences (handy during development).
  static Future<void> showBottomNavTutorial(
      BuildContext context, {
        required GlobalKey homeKey,
        required GlobalKey searchKey,
        required GlobalKey scanKey,
        required GlobalKey categoriesKey,
        required GlobalKey uploadKey,
        required GlobalKey smartReadKey,
        bool forceShow = true,
      }) async {
    // read pref
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('bottomNavTutorialSeen') ?? false;
    if (seen && !forceShow) return;

    // Build targets with styled content
    final List<TargetFocus> targets = <TargetFocus>[
      TargetFocus(
        identify: "Home",
        keyTarget: homeKey,
        shape: ShapeLightFocus.RRect,   // 👈 THIS MAKES THE SPOTLIGHT SQUARE/ROUNDED-RECTANGLE
        radius: 8,                      // 👈 corner radius (8–16 looks good)
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _tutorialCard(
              icon: Icons.home_rounded,
              title: "Home",
              message: "Return to your dashboard to access all main features.",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Search",
        keyTarget: searchKey,
        shape: ShapeLightFocus.RRect,
        radius: 10,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: _tutorialCard(
              icon: Icons.search_rounded,
              title: "Search",
              message: "Find products, ingredients, or recipes quickly.",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Scan",
        keyTarget: scanKey,
        shape: ShapeLightFocus.RRect,
        radius: 10,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: _tutorialCard(
              icon: Icons.qr_code_scanner_rounded,
              title: "Scan",
              message: "Tap here to scan a barcode or label and get instant info.",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Categories",
        keyTarget: categoriesKey,
        shape: ShapeLightFocus.RRect,
        radius: 10,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: _tutorialCard(
              icon: Icons.grid_view_rounded,
              title: "Categories",
              message: "Browse curated food categories and collections.",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Upload",
        keyTarget: uploadKey,
        shape: ShapeLightFocus.RRect,
        radius: 10,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: _tutorialCard(
              icon: Icons.cloud_upload_rounded,
              title: "Upload",
              message: "Request a product or share its details so it can be added to the app.",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "SmartRead",
        keyTarget: smartReadKey,
        shape: ShapeLightFocus.RRect,
        radius: 10,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: _tutorialCard(
              icon: Icons.document_scanner_rounded,
              title: "Smart Read",
              message: "Run Smart Read (OCR) on images to extract ingredients and nutrition.",
            ),
          ),
        ],
      ),
    ];

    // small safety delay so render boxes exist
    await Future.delayed(const Duration(milliseconds: 200));

    // ensure the widget/context is still available
    if (!context.mounted) return;

    // Create and show the tutorial. Use named parameters and call show(context:).
    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.8),
      paddingFocus: 0.0005, // controls spotlight "padding" (bigger number = larger circle)
      textSkip: "SKIP",
      // called when tutorial finishes normally
      onFinish: () async {
        await prefs.setBool('bottomNavTutorialSeen', true);
      },
      // called when user presses Skip — must return true to close
      onSkip: () {
        prefs.setBool('bottomNavTutorialSeen', true);
        return true;
      },
      // optional callbacks:
      // onClickTarget: (target) { /* ... */ },
      // beforeFocus: (target) async { /* ... */ },
    ).show(context: context);
  }

  // ------------------------------------------
  // Private helper: builds a pretty tooltip card
  // ------------------------------------------
  static Widget _tutorialCard({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        // rich purple card — matches your app look while staying readable
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade400.withOpacity(0.98),
            Colors.deepPurple.shade300.withOpacity(0.98),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.28),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon circle
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),

          const SizedBox(width: 12),

          // text column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.92),
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
