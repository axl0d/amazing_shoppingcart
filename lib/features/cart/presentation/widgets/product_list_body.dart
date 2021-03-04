import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shoppingcart/features/cart/presentation/bloc/cart_list_cubit.dart';
import 'package:tul_shoppingcart/features/cart/presentation/bloc/product_list_cubit.dart';

class ProductListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
      switch (state.status) {
        case ProductListStatus.success:
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            padding: const EdgeInsets.all(16),
            itemCount: state.products.length,
            itemBuilder: (context, index) => Card(
              child: Column(
                children: [
                  const Expanded(child: const SizedBox()),
                  Text(state.products[index].name),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context
                            .read<CartListCubit>()
                            .removeCartItem(state.products[index]),
                        icon: Icon(Icons.remove),
                      ),
                      const Expanded(child: const SizedBox()),
                      IconButton(
                        onPressed: () => context
                            .read<CartListCubit>()
                            .addCartItem(state.products[index]),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        default:
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }
    });
  }
}
