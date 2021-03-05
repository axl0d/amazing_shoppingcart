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
          primarySwatch: colorCustom,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(0, 100, 80, .1),
  100: Color.fromRGBO(0, 100, 80, .2),
  200: Color.fromRGBO(0, 100, 80, .3),
  300: Color.fromRGBO(0, 100, 80, .4),
  400: Color.fromRGBO(0, 100, 80, .5),
  500: Color.fromRGBO(0, 100, 80, .6),
  600: Color.fromRGBO(0, 100, 80, .7),
  700: Color.fromRGBO(0, 100, 80, .8),
  800: Color.fromRGBO(0, 100, 80, .9),
  900: Color.fromRGBO(0, 100, 80, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF006450, color);
