// // lib/models/food_item.dart
//
// class NutrimentSummary {
//   final double? energyKcal;
//   final double? sugarsG;
//
//   NutrimentSummary({this.energyKcal, this.sugarsG});
//
//   factory NutrimentSummary.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return NutrimentSummary();
//     double? parseNum(dynamic v) {
//       if (v == null) return null;
//       if (v is num) return v.toDouble();
//       if (v is String) {
//         final cleaned = v.trim();
//         if (cleaned.isEmpty) return null;
//         return double.tryParse(cleaned);
//       }
//       return null;
//     }
//
//     return NutrimentSummary(
//       energyKcal: parseNum(json['energy_kcal']) ?? parseNum(json['energy']) ?? parseNum(json['energy_kcal_value']),
//       sugarsG: parseNum(json['sugars_g']) ?? parseNum(json['sugars']) ?? parseNum(json['sugars_value']),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'energy_kcal': energyKcal,
//     'sugars_g': sugarsG,
//   };
// }
//
// class FoodItem {
//   final String? barcode;
//   final String productName;
//   final String? brands;
//   final String? quantity;
//   final String? thumbnail; // images.front (used as list thumbnail)
//   final String? nutriscore; // e.g. "a","b","c","d","e"
//   final int? novaGroup;
//   final NutrimentSummary nutrimentSummary;
//
//   FoodItem({
//     required this.productName,
//     this.barcode,
//     this.brands,
//     this.quantity,
//     this.thumbnail,
//     this.nutriscore,
//     this.novaGroup,
//     NutrimentSummary? nutrimentSummary,
//   }) : nutrimentSummary = nutrimentSummary ?? NutrimentSummary();
//
//   factory FoodItem.fromJson(Map<String, dynamic> json) {
//     // Some APIs return nested shapes. This factory is defensive.
//     final images = json['images'];
//     String? thumbnail;
//     if (json['thumbnail'] != null) {
//       thumbnail = json['thumbnail']?.toString();
//     } else if (images != null && images is Map<String, dynamic> && images['front'] != null) {
//       thumbnail = images['front']?.toString();
//     }
//
//     final nutrimentSummaryJson = json['nutriment_summary'] ?? json['nutriments'] ?? json['nutrimentSummary'];
//
//     int? parseInt(dynamic v) {
//       if (v == null) return null;
//       if (v is int) return v;
//       if (v is num) return v.toInt();
//       if (v is String) return int.tryParse(v);
//       return null;
//     }
//
//     return FoodItem(
//       barcode: json['barcode']?.toString(),
//       productName: json['product_name']?.toString() ?? json['productName']?.toString() ?? 'Unknown product',
//       brands: json['brands']?.toString(),
//       quantity: json['quantity']?.toString(),
//       thumbnail: thumbnail,
//       nutriscore: json['nutriscore'] == null ? null : json['nutriscore'].toString().toLowerCase(),
//
//       novaGroup: parseInt(json['nova_group'] ?? json['novaGroup']),
//       nutrimentSummary: NutrimentSummary.fromJson(nutrimentSummaryJson is Map ? nutrimentSummaryJson as Map<String, dynamic> : null),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'barcode': barcode,
//     'product_name': productName,
//     'brands': brands,
//     'quantity': quantity,
//     'thumbnail': thumbnail,
//     'nutriscore': nutriscore,
//     'nova_group': novaGroup,
//     'nutriment_summary': nutrimentSummary.toJson(),
//   };
// }


// lib/models/food_item.dart

class NutrimentSummary {
  final double? energyKcal;
  final double? sugarsG;

  NutrimentSummary({this.energyKcal, this.sugarsG});

  factory NutrimentSummary.fromJson(Map<String, dynamic>? json) {
    if (json == null) return NutrimentSummary();
    double? parseNum(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) {
        final cleaned = v.trim();
        if (cleaned.isEmpty) return null;
        return double.tryParse(cleaned);
      }
      return null;
    }

    return NutrimentSummary(
      energyKcal: parseNum(json['energy_kcal']) ?? parseNum(json['energy']) ?? parseNum(json['energy_kcal_value']),
      sugarsG: parseNum(json['sugars_g']) ?? parseNum(json['sugars']) ?? parseNum(json['sugars_value']),
    );
  }

  Map<String, dynamic> toJson() => {
    'energy_kcal': energyKcal,
    'sugars_g': sugarsG,
  };
}

class FoodItem {
  final String? barcode;
  final String productName;
  final String? brands;
  final String? quantity;
  final String? thumbnail;
  final String? nutriscore;
  final int? novaGroup;
  final NutrimentSummary nutrimentSummary;

  FoodItem({
    required this.productName,
    this.barcode,
    this.brands,
    this.quantity,
    this.thumbnail,
    this.nutriscore,
    this.novaGroup,
    NutrimentSummary? nutrimentSummary,
  }) : nutrimentSummary = nutrimentSummary ?? NutrimentSummary();

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    final images = json['images'];

    // ⭐ FIXED THUMBNAIL LOGIC WITH FALLBACK
    String thumbnail;
    if (json['thumbnail'] != null &&
        json['thumbnail'].toString().isNotEmpty) {
      thumbnail = json['thumbnail'].toString();
    }
    else if (images != null &&
        images is Map<String, dynamic> &&
        images['front'] != null &&
        images['front'].toString().isNotEmpty) {
      thumbnail = images['front'].toString();
    }
    else {
      // 🔥 fallback prevents blank UI
      thumbnail = "https://via.placeholder.com/200";
    }

    final nutrimentSummaryJson =
        json['nutriment_summary'] ?? json['nutriments'] ?? json['nutrimentSummary'];

    int? parseInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v);
      return null;
    }

    return FoodItem(
      barcode: json['barcode']?.toString(),
      productName: json['product_name']?.toString() ??
          json['productName']?.toString() ??
          'Unknown product',
      brands: json['brands']?.toString(),
      quantity: json['quantity']?.toString(),
      thumbnail: thumbnail,
      nutriscore: json['nutriscore'] == null
          ? null
          : json['nutriscore'].toString().toLowerCase(),
      novaGroup: parseInt(json['nova_group'] ?? json['novaGroup']),
      nutrimentSummary: NutrimentSummary.fromJson(
        nutrimentSummaryJson is Map<String, dynamic>
            ? nutrimentSummaryJson
            : nutrimentSummaryJson is Map
            ? Map<String, dynamic>.from(nutrimentSummaryJson)
            : null,
      ),

    );
  }

  Map<String, dynamic> toJson() => {
    'barcode': barcode,
    'product_name': productName,
    'brands': brands,
    'quantity': quantity,
    'thumbnail': thumbnail,
    'nutriscore': nutriscore,
    'nova_group': novaGroup,
    'nutriment_summary': nutrimentSummary.toJson(),
  };
}
