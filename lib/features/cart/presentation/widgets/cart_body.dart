import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shoppingcart/features/cart/domain/entities/product.dart';
import 'package:tul_shoppingcart/features/cart/presentation/bloc/cart_list_cubit.dart';

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartListCubit, CartListState>(builder: (context, state) {
      switch (state.status) {
        case CartListStatus.success:
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Card(
                      child: Column(
                        children: [
                          const Expanded(child: const SizedBox()),
                          Text(state.cart.products[index].productId.toString()),
                          Text(state.cart.products[index].quantity.toString()),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => context
                                    .read<CartListCubit>()
                                    .removeCartItem(
                                      Product(
                                          id: state
                                              .cart.products[index].productId),
                                    ),
                                icon: Icon(Icons.remove),
                              ),
                              const Expanded(child: const SizedBox()),
                              IconButton(
                                onPressed: () =>
                                    context.read<CartListCubit>().addCartItem(
                                          Product(
                                              id: state.cart.products[index]
                                                  .productId),
                                        ),
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                          TextButton(onPressed: null, child: Text('Quitar'))
                        ],
                      ),
                    ),
                    childCount: state.cart.products.length,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Total:'),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => context.read<CartListCubit>().order(),
                    child: Text('Order'),
                  )
                ]),
              )
            ],
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
