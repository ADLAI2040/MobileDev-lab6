import 'package:flutter/material.dart';
import '../models/product.dart';
import '../units/favorites_storage.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final VoidCallback updateIsFavorite;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
    required this.updateIsFavorite,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;

    setState(() {
      product;
    });

    if (product.isFavorite == true) {
      FavoritesStorage.saveFavorite(product);
    } else {
      FavoritesStorage.removeFavorite(product);
    }

    widget.updateIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            widget.product.name,
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product.imageUrl,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 200,
                    color: Colors.grey,
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Калории: ${widget.product.calories} ккал'),
              const SizedBox(height: 8),
              Text('Углеводы: ${widget.product.carbohydrates} г'),
              Text('Белки: ${widget.product.proteins} г'),
              Text('Жиры: ${widget.product.fat} г'),
              Text('Ингредиеты: ${widget.product.ingredients}'),
              Text('Аллергены: ${widget.product.allergens}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        toggleFavorite(widget.product);
                      });
                    },
                    icon: Icon(widget.product.isFavorite
                        ? Icons.star
                        : Icons.star_border),
                    label: Text(widget.product.isFavorite
                        ? 'Удалить из избранного'
                        : 'Добавить в избранное'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
