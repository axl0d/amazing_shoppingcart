import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shoppingcart/features/cart/data/repositories/firestore_repository.dart';
import 'package:tul_shoppingcart/features/cart/presentation/bloc/cubits.dart';
import 'package:tul_shoppingcart/features/cart/presentation/widgets/widgets.dart';

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
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo_tul_blanco.png',
              height: kToolbarHeight * 0.5,
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Shopping Cart'),
            )
          ],
        ),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
