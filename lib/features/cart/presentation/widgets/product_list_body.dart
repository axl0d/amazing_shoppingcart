import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amazing_shoppingcart/features/cart/domain/entities/product.dart';
import 'package:amazing_shoppingcart/features/cart/presentation/bloc/cubits.dart';
import 'package:amazing_shoppingcart/features/cart/presentation/widgets/title_item.dart';
import 'image_item.dart';
import 'loading.dart';

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
            itemBuilder: (context, index) => _ProductItem(
              product: state.products[index],
            ),
          );
        default:
          return Loading();
      }
    });
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({Key key, this.product}) : super(key: key);

  final Product product;

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
            children: [
              IconButton(
                onPressed: () =>
                    context.read<CartListCubit>().removeCartItem(product),
                icon: Icon(Icons.remove),
              ),
              const Expanded(child: const SizedBox()),
              IconButton(
                onPressed: () =>
                    context.read<CartListCubit>().addCartItem(product),
                icon: Icon(Icons.add),
              ),
            ],
          )
        ],
      ),
    );
  }
}
