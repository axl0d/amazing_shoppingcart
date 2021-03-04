import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shoppingcart/features/cart/data/repositories/firestore_repository.dart';
import 'package:tul_shoppingcart/features/cart/presentation/bloc/cart_list_cubit.dart';
import 'package:tul_shoppingcart/features/cart/presentation/bloc/product_list_cubit.dart';
import 'package:tul_shoppingcart/features/cart/presentation/widgets/cart_body.dart';
import 'package:tul_shoppingcart/features/cart/presentation/widgets/product_list_body.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductListCubit(
            context.read<FireStoreRepository>(),
          )..fetchProducts(),
        ),
        BlocProvider(
          create: (context) => CartListCubit(
            context.read<FireStoreRepository>(),
          )..init(),
        ),
      ],
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  @override
  __HomeViewState createState() => __HomeViewState();
}

class __HomeViewState extends State<_HomeView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          ProductListBody(),
          CartBody(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
