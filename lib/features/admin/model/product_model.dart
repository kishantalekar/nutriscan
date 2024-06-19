class Product {
  final String id;
  final String name;
  final String brand;
  final String barcode;
  final int calories;
  final double protein;
  final double fat;
  final double carbohydrates;
  final String servingSize;
  final String ingredients;
  final String allergens;
  final String dietaryInfo;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.barcode,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
    required this.servingSize,
    required this.ingredients,
    required this.allergens,
    required this.dietaryInfo,
    this.imageUrl = "",
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      barcode: json['barcode'],
      calories: json['calories'],
      protein: json['protein'],
      fat: json['fat'],
      carbohydrates: json['carbohydrates'],
      servingSize: json['servingSize'],
      ingredients: json['ingredients'],
      allergens: json['allergens'],
      dietaryInfo: json['dietaryInfo'],
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  // Method to convert a Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'barcode': barcode,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbohydrates': carbohydrates,
      'servingSize': servingSize,
      'ingredients': ingredients,
      'allergens': allergens,
      'dietaryInfo': dietaryInfo,
      'imageUrl': imageUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.brand == brand &&
        other.barcode == barcode &&
        other.calories == calories &&
        other.protein == protein &&
        other.fat == fat &&
        other.carbohydrates == carbohydrates &&
        other.servingSize == servingSize &&
        other.ingredients == ingredients &&
        other.allergens == allergens &&
        other.dietaryInfo == dietaryInfo &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        brand.hashCode ^
        barcode.hashCode ^
        calories.hashCode ^
        protein.hashCode ^
        fat.hashCode ^
        carbohydrates.hashCode ^
        servingSize.hashCode ^
        ingredients.hashCode ^
        allergens.hashCode ^
        dietaryInfo.hashCode ^
        imageUrl.hashCode;
  }
}
