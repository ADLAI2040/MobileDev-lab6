import 'package:flutter/material.dart';
import '../models/product.dart';
import '../views/product_details.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback updateIsFavorite;

  const ProductCard({
    Key? key,
    required this.product,
    required this.updateIsFavorite,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void updateIsFavorite() {
    setState(() {
      widget.product;
    });
    widget.updateIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: widget.product.imageUrl.isNotEmpty
            ? Image.network(
                widget.product.imageUrl,
                height: 50,
                width: 50,
              )
            : const Icon(Icons.image_not_supported),
        title: Text(
          widget.product.name,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                product: widget.product,
                updateIsFavorite: updateIsFavorite,
              ),
            ),
          );
        },
      ),
    );
  }
}
