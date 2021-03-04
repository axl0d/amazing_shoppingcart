part of 'cart_list_cubit.dart';

enum CartListStatus { initial, loading, success, failure, clean }

class CartListState extends Equatable {
  const CartListState({
    this.status = CartListStatus.initial,
    this.cart,
  });

  final CartListStatus status;
  final Cart cart;

  CartListState copyWith({
    CartListStatus status,
    Cart cart,
  }) {
    return CartListState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object> get props => [status, cart];
}
