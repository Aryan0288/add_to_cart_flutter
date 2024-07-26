import 'package:add_to_cart/pages/catalog.dart';
import 'package:add_to_cart/providers/catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart' as badges;

class AddToCartShow extends StatefulWidget {
  const AddToCartShow({super.key});

  @override
  State<AddToCartShow> createState() => _AddToCartShowState();
}

class _AddToCartShowState extends State<AddToCartShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "All Carts".text.make(),
        centerTitle: true,
        actions: [
          Consumer<CatalogProvider>(
            builder: (context, value, child) => badges.Badge(
              onTap: () {},
              badgeContent: Text(value.cartItemCount.toString()),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: SafeArea(
        child: Consumer<CatalogProvider>(
          builder: (context, value, child) {
            if (value.cartItemCount == 0) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/empty_cart.png"),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>const CatalogPage()));
                      },
                      label: const Text("Add to Cart"),
                    )
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: value.cartItemCount,
                itemBuilder: (context, index) {
                  final itemData = value.catalogList[index];
                  // print("itemData");
                  // print(itemData['name']);
                  return Card(
                    color: Colors.white,
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(itemData['image']).wh(100, 200),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // itemData['name'].text.xl.make(),
                                // itemData['desc'].text.make(),
                                Text(itemData['name']),
                                Text(itemData['desc']),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // itemData['price'].text.xl2.make().pOnly(right: 8),
                                    Text(itemData['price'].toString()),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        value.removeFromCart(itemData);
                                      },
                                      child: const Icon(
                                          Icons.delete_forever_rounded),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).pOnly(left: 16),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
