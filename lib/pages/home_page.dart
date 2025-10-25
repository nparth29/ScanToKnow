import 'package:flutter/material.dart';
import 'package:main_project_files/model/product_model.dart';
import 'package:main_project_files/service/product_info.dart';
import 'package:main_project_files/widgets/food_tile.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:main_project_files/service/product_detailed_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "Snacks";

  final List<Map<String, dynamic>> categories = [
    {"name": "Snacks", "icon": Icons.fastfood},
    {"name": "Drinks", "icon": Icons.local_drink_rounded},
    {"name": "Packaged", "icon": Icons.shopping_bag},
    {"name": "Fresh", "icon": Icons.eco},
  ];

  late List<ProductModel> products;
  late List<ProductModel> filteredProducts;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = getProducts();
    filteredProducts = List.from(products);

    _searchController.addListener(() {
      filterProducts(_searchController.text);
    });
  }

  void filterProducts(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      filteredProducts = products
          .where((product) => product.name.toLowerCase().contains(lowerQuery))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow[50],
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'images/intro_page_images/png_app_logo.png',
                height: 60,
                width: 60,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Know What You Eat 🍎",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search food item...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Category List
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category["name"] == selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category["name"];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orangeAccent
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color:
                            Colors.orangeAccent.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            category["icon"],
                            size: 28,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            category["name"],
                            style: TextStyle(
                              color:
                              isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Product Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            name: product.name,
                            image: product.image,
                            health: product.health,
                            price: product.price.toString(),
                            novaScore: 0,
                            nutriScore: "-",
                          ),
                        ),
                      );
                    },
                    child: FoodTile(
                      product.name,
                      product.image,
                      product.health,
                      product.nutriScore,
                      product.novaScore,
                    ),

                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.orangeAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanPage()),
            );
          },
          child: const Icon(
            Icons.camera_alt_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Scanner Page
class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: MobileScanner(
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            debugPrint('Detected: ${barcode.rawValue}');
          }
        },
      ),
    );
  }
}
