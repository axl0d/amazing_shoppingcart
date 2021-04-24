import 'package:amazing_shoppingcart/features/cart/presentation/pages/home.dart';
import 'package:amazing_shoppingcart/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configurationInjection();
  runApp(CartApp());
}

class CartApp extends StatelessWidget {
  const CartApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazing Shopping Cart',
      home: HomePage(),
    );
  }
}
