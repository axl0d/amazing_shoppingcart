import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shoppingcart/features/cart/domain/entities/entities.dart';
import 'package:tul_shoppingcart/features/cart/presentation/bloc/cart_list_cubit.dart';
import 'package:tul_shoppingcart/features/cart/presentation/widgets/image_item.dart';
import 'package:tul_shoppingcart/features/cart/presentation/widgets/title_item.dart';

import 'loading.dart';

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartListCubit, CartListState>(builder: (context, state) {
      switch (state.status) {
        case CartListStatus.success:
          return CustomScrollView(
            slivers: [
              state.cart.products.isNotEmpty
                  ? SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _CartItem(
                            product: state.cart.products[index].product,
                            quantity: state.cart.products[index].quantity,
                          ),
                          childCount: state.cart.products.length,
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([
                        Expanded(
                            child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ))
                      ]),
                    ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Total: \$${state.cart.total}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.all(16),
                      onPressed: () => context.read<CartListCubit>().order(),
                      child: Text(
                        'Order'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ]),
              )
            ],
          );
        default:
          return Loading();
      }
    });
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({Key key, this.product, this.quantity}) : super(key: key);
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ImageItem(
            image: product.image,
          ),
          TitleItem(
            title: product.name,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.read<CartListCubit>().removeCartItem(
                      product,
                    ),
                icon: Icon(Icons.remove),
              ),
              Text(quantity.toString()),
              IconButton(
                onPressed: () =>
                    context.read<CartListCubit>().addCartItem(product),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          TextButton(onPressed: null, child: Text('Quitar')),
        ],
      ),
    );
  }
}
