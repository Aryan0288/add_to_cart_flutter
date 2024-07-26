import 'package:add_to_cart/pages/home.dart';
import 'package:add_to_cart/providers/catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> CatalogProvider())
      ],
      child:const MaterialApp(
        home: Home(),
      ),
    );
  }
}
