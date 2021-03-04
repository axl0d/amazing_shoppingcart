part of 'product_list_cubit.dart';

enum ProductListStatus { initial, loading, success, failure }

class ProductListState extends Equatable {
  const ProductListState(
      {this.status = ProductListStatus.initial, this.products});

  final ProductListStatus status;
  final List<Product> products;

  ProductListState copyWith({
    ProductListStatus status,
    List<Product> products,
  }) {
    return ProductListState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [
        status,
        products,
      ];
}
