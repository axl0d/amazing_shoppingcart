import 'package:amazing_shoppingcart/features/cart/presentation/bloc/cubits.dart';
import 'package:amazing_shoppingcart/features/cart/presentation/widgets/widgets.dart';
import 'package:amazing_shoppingcart/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProductListCubit>()..fetchProducts(),
        ),
        BlocProvider(
          create: (_) => getIt<CartListCubit>()..init(),
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
      appBar: AppBar(
        title: const Text('Amazing Shopping Cart'),
      ),
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
          const BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
