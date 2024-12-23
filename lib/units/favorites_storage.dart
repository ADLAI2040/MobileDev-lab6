import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

class FavoritesStorage {
  static const favoritesKey = 'isFavorite';

  static Future<void> saveFavorite(Product product) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteJsonList = prefs.getStringList(favoritesKey) ?? [];

    List<Product> favoriteProducts = favoriteJsonList
        .map((json) => Product.fromJson(jsonDecode(json)))
        .toList();

    favoriteProducts.removeWhere((item) => item.name == product.name);
    favoriteProducts.add(product);

    final updatedFavoriteJsonList = favoriteProducts
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await prefs.setStringList(favoritesKey, updatedFavoriteJsonList);
  }

  static Future<List<Product>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJsonList = prefs.getStringList(favoritesKey) ?? [];

    return favoriteJsonList
        .map((json) => Product.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> removeFavorite(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJsonList = prefs.getStringList(favoritesKey) ?? [];
    List<Product> favoriteProducts = favoriteJsonList
        .map((json) => Product.fromJson(jsonDecode(json)))
        .toList();

    favoriteProducts.removeWhere((item) => item.name == product.name);
    final updatedFavoriteJsonList = favoriteProducts
        .map((product) => jsonEncode(product.toJson()))
        .toList();

    await prefs.setStringList(favoritesKey, updatedFavoriteJsonList);
  }
}
