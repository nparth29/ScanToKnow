// lib/widgets/product_card.dart

import 'package:flutter/material.dart';
import 'package:main_project_files/models/food_item.dart';

class ProductCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  Color _nutriColor(String? nutri) {
    switch (nutri?.toLowerCase()) {
      case "a":
        return Colors.green.shade700;
      case "b":
        return Colors.green.shade500;
      case "c":
        return Colors.orange.shade600;
      case "d":
        return Colors.orange.shade800;
      case "e":
        return Colors.red.shade700;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),

        padding: const EdgeInsets.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Product Thumbnail ----
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.thumbnail != null && item.thumbnail!.isNotEmpty
                  ? Image.network(
                item.thumbnail!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    Container(height: 100, color: Colors.grey.shade200),
              )
                  : Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported, size: 32),
              ),
            ),

            const SizedBox(height: 8),

            // ---- Product Name ----
            Text(
              item.productName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            Row(
              children: [
                // ---- NutriScore Badge ----
                if (item.nutriscore != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _nutriColor(item.nutriscore!),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.nutriscore!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                const SizedBox(width: 6),

                // ---- NOVA Group Badge ----
                if (item.novaGroup != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade700,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "NOVA ${item.novaGroup}",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
