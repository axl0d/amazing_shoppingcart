import 'package:amazing_shoppingcart/features/cart/domain/entities/entities.dart';
import 'package:amazing_shoppingcart/features/cart/presentation/bloc/cart_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_item.dart';
import 'loading.dart';
import 'title_item.dart';

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartListCubit, CartListState>(
      listener: (_, state) {
        if (state.status == CartListStatus.clean)
          showDialog(
            context: context,
            builder: (_) => _CustomAlertDialog(
              title: 'Se realizó la compra',
              icons: Icons.check,
              color: Colors.green,
            ),
          );
      },
      builder: (_, state) {
        switch (state.status) {
          case CartListStatus.success:
            return CustomScrollView(
              slivers: [
                state.cart.products.isNotEmpty
                    ? _CartBodyList(
                        cart: state.cart,
                      )
                    : _CartBodyEmpty(),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Total: \$${state.cart.totalLabel}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    OrderButton(
                      isDisabled: state.cart.products.isEmpty,
                    ),
                  ]),
                )
              ],
            );
          default:
            return Loading();
        }
      },
    );
  }
}

class _CartBodyList extends StatelessWidget {
  const _CartBodyList({Key key, this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _CartItem(
            product: cart.products[index].product,
            quantity: cart.products[index].quantity,
          ),
          childCount: cart.products.length,
        ),
      ),
    );
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
          TextButton(
            onPressed: () => context.read<CartListCubit>().popCartItem(product),
            child: Text('Quitar'),
          ),
        ],
      ),
    );
  }
}

class _CartBodyEmpty extends StatelessWidget {
  const _CartBodyEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: Text(
              'No hay elementos',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        )
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  OrderButton({Key key, this.isDisabled}) : super(key: key);

  final bool isDisabled;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
        ),
        onPressed: widget.isDisabled
            ? null
            : () => context.read<CartListCubit>().order(),
        child: Text(
          'Order'.toUpperCase(),
        ),
      ),
    );
  }
}

class _CustomAlertDialog extends StatelessWidget {
  const _CustomAlertDialog({Key key, this.title, this.icons, this.color})
      : super(key: key);

  final String title;
  final IconData icons;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Icon(
            icons,
            color: color,
          )
        ],
      ),
    );
  }
}
