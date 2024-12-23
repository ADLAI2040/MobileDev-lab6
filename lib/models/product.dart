class Product {
  final String name;
  final String imageUrl;
  final String calories;
  final String carbohydrates;
  final String fat;
  final String proteins;
  final String ingredients;
  final String allergens;
  bool isFavorite;

  Product({
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.carbohydrates,
    required this.fat,
    required this.proteins,
    required this.ingredients,
    required this.allergens,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['product_name_en']?.isNotEmpty == true
          ? json['product_name_en']
          : json['product_name']?.isNotEmpty == true
              ? json['product_name']
              : 'Unknown',
      imageUrl: json['image_url'] ?? '',
      calories: json['nutriments']['energy-kcal']?.toString() ?? '0',
      carbohydrates: json['nutriments']['carbohydrates']?.toString() ?? '0',
      fat: json['nutriments']['fat']?.toString() ?? '0',
      proteins: json['nutriments']['proteins']?.toString() ?? '0',
      ingredients: json['ingredients_text_en']?.isNotEmpty == true
          ? json['ingredients_text_en']
          : 'No information',
      allergens: json['allergens']?.isNotEmpty == true
          ? json['allergens']
          : 'No information',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name_en': name,
      'nutriments': {
        'energy-kcal': calories,
        'carbohydrates': carbohydrates,
        'fat': fat,
        'proteins': proteins,
      },
      'ingredients_text_en': ingredients,
      'image_url': imageUrl,
      'allergens': allergens,
      'isFavorite': isFavorite,
    };
  }
}
