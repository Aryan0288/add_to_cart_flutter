import 'dart:convert';

import 'package:add_to_cart/apiModel/catalog_merge.dart';
import 'package:add_to_cart/apifetch/catalog_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CatalogProvider extends ChangeNotifier {
  List<dynamic> catalogList = [];
  List<Item> list = [];

  List<Item> _items = [];

  List<Item> get items => _items;

  CatalogProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    var catalogData = await rootBundle.loadString("assets/files/catalog.json");
    var decData = jsonDecode(catalogData);
    var procData = decData["products"];
    _items =
        List.from(procData).map<Item>((item) => Item.fromMap(item)).toList();
    notifyListeners();
  }

  void addToCart(Item item,BuildContext context) {
    var jsonData = item.toMap();
    if (catalogList.any((element) => jsonEncode(element) == jsonEncode(jsonData))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item already added to the cart'),
        ),
      );
    } else {
      catalogList.add(jsonData);
      notifyListeners();
    }
  }

  void removeFromCart(dynamic item) {
    print("remove from cart");
    print(item);
    // var jsonData = item.toMap();
    catalogList.remove(item);
    notifyListeners();
  }

  int get cartItemCount => catalogList.length;
}
