import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                          Text(state.cart.products[index].product.name
                              .toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => context
                                    .read<CartListCubit>()
                                    .removeCartItem(
                                      state.cart.products[index].product,
                                    ),
                                icon: Icon(Icons.remove),
                              ),
                              Text(state.cart.products[index].quantity
                                  .toString()),
                              IconButton(
                                onPressed: () => context
                                    .read<CartListCubit>()
                                    .addCartItem(
                                        state.cart.products[index].product),
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                          TextButton(onPressed: null, child: Text('Quitar')),
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
                      child: Text('Total: \$${state.cart.total}'),
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
