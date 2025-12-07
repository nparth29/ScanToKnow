import 'package:flutter/material.dart';
import 'package:main_project_files/widgets/top_header.dart';
import 'package:main_project_files/pages/profile_page.dart';
import 'package:main_project_files/widgets/top_categories.dart';
import 'package:main_project_files/widgets/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  void _onTabSelected(int index) {
    // Keep selected tab stored so bottomNav can reflect initialIndex if needed
    setState(() => _selectedTab = index);

    // Navigate to placeholder pages for non-home tabs
    switch (index) {
      case 0:
      // Home — already here, do nothing
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoriesPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadPage()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SmartReadPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopHeader(
                avatarAsset: 'images/home_page_images/user_logo.png',
                onAvatarTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
              ),

              const SizedBox(height: 18),

              // Top categories row
              TopCategories(
                onCategoryTap: (id, title) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title tapped (placeholder)')),
                  );
                },
              ),

              const SizedBox(height: 18),

              // Advertisement carousel (placeholder)
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Ad ${index + 1} tapped (placeholder)')),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == 0 ? Colors.deepPurple.shade50 : Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      index == 0 ? 'Say hello to TIA' : (index == 1 ? 'Using Truthin — Rewards' : 'Eat Well. Live Well.'),
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Tap to learn more (placeholder)',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('CTA on ad ${index + 1} tapped (placeholder)')),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      ),
                                      child: const Text('Explore'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // right-side placeholder box
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Weekly Healthy Picks heading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Weekly Healthy Picks',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Placeholder grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
                      ),
                      child: Row(
                        children: [
                          Container(width: 48, height: 48, color: Colors.grey.shade200),
                          const SizedBox(width: 12),
                          const Expanded(child: Text('Healthy Pick', style: TextStyle(fontSize: 14))),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 80), // leave space for nav
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        initialIndex: _selectedTab,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

/* ---------------------------------------------------------------------------
   Below are simple placeholder pages for Search, Scan, Categories, Upload and SmartRead.
   Each is intentionally minimal so you can replace with real implementations later.
   --------------------------------------------------------------------------- */

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Center(
        child: Text(
          'Search page (placeholder)\nImplement search UI later.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Product')),
      body: const Center(
        child: Text(
          'Scan Product (placeholder)\nReplace with your mobile scanner page when ready.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Categories')),
      body: const Center(
        child: Text(
          'Categories page (placeholder)\nDisplay all categories here later.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Product')),
      body: const Center(
        child: Text(
          'Upload page (placeholder)\nImplement product upload / request flow here.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SmartReadPage extends StatelessWidget {
  const SmartReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Read')),
      body: const Center(
        child: Text(
          'Smart Read (OCR) placeholder\nThis will run OCR on images and extract ingredients/nutrition.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
