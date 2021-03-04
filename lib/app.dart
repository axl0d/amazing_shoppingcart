import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shoppingcart/features/cart/presentation/pages/home.dart';

import 'features/cart/data/repositories/firestore_repository.dart';

class CartApp extends StatelessWidget {
  final FireStoreRepository repository;

  const CartApp({Key key, this.repository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: MaterialApp(
        title: 'Tul Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
