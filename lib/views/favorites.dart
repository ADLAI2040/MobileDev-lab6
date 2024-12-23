import 'package:flutter/material.dart';
import '../models/product.dart';
import '../units/favorites_storage.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Product> favoriteProducts = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadFavorites();
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favorites = await FavoritesStorage.loadFavorites();
    setState(() {
      favoriteProducts = favorites;
    });
  }

  void refreshFavorites() {
    setState(() {
      favoriteProducts =
          favoriteProducts.where((product) => product.isFavorite).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Избранное',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text('В избранном пока ничего нет'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: favoriteProducts[index],
                  updateIsFavorite: refreshFavorites,
                );
              },
            ),
    );
  }
}
