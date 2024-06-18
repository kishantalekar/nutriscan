class FoodItem {
  int? id;
  String name;
  String category;
  DateTime expiryDate;
  int quantity;
  String photoPath;

  FoodItem({
    this.id,
    required this.name,
    required this.category,
    required this.expiryDate,
    required this.quantity,
    required this.photoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'expiryDate': expiryDate.toIso8601String(),
      'quantity': quantity,
      'photoPath': photoPath,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      expiryDate: DateTime.parse(map['expiryDate']),
      quantity: map['quantity'],
      photoPath: map['photoPath'],
    );
  }

  @override
  String toString() {
    return 'FoodItem{id: $id, name: $name, category: $category, expiryDate: $expiryDate, quantity: $quantity, photoPath: $photoPath}';
  }
}
