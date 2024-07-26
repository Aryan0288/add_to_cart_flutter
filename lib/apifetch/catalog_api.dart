import 'dart:convert';

import 'package:add_to_cart/apiModel/catalog_merge.dart';
import 'package:flutter/services.dart';

class CatalogApiModel {
  
  void fetchCatalogApi() async {
    var catalogData = await rootBundle.loadString("assets/files/catalog.json");
    var decData = jsonDecode(catalogData);
    var procData = decData["products"];
    CataLogModel.item =
        List.from(procData).map<Item>((item) => Item.fromMap(item)).toList();
  }
}
