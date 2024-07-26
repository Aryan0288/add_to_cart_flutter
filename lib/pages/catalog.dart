import 'dart:convert';

import 'package:add_to_cart/apiModel/catalog_merge.dart';
import 'package:add_to_cart/apifetch/catalog_api.dart';
import 'package:add_to_cart/pages/add_to_cart_show.dart';
import 'package:add_to_cart/providers/catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart' as badges;

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  //   print("fetch data");
  // }

  // fetchData() async {
  //   // CatalogApiModel().fetchCatalogApi();
  //   // void fetchCatalogApi() async {
  //   var catalogData = await rootBundle.loadString("assets/files/catalog.json");
  //   var decData = jsonDecode(catalogData);
  //   var procData = decData["products"];
  //   CataLogModel.item =
  //       List.from(procData).map<Item>((item) => Item.fromMap(item)).toList();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add to Cart".text.make(),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddToCartShow()));
            },
            child: Consumer<CatalogProvider>(
              builder: (context, value, child) => badges.Badge(
                badgeContent: Text(value.cartItemCount.toString()),
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<CatalogProvider>(
          builder: (context, value, child) => ListView.builder(
            // itemCount: CataLogModel.item.length,
            itemCount: value.items.length,
            itemBuilder: (context, index) {
              // final itemData = CataLogModel.item[index];
              final itemData = value.items[index];

              return Card(
                color: Colors.white,
                elevation: 10,
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network(itemData.image).wh(100, 200),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        itemData.name.text.xl.make(),
                        itemData.desc.text.make(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            itemData.price.text.xl2.make().pOnly(right: 8),
                            ElevatedButton(
                              onPressed: () {
                                value.addToCart(itemData,context);
                              },
                              child: "Add to Cart".text.make(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // child: Consumer<CatalogProvider>(
        //   builder: ((context, value, child) => Container(
        //       )),
        // ),
      ),
    );
  }
}
