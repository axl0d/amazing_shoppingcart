import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tul_shoppingcart/features/cart/data/repositories/firestore_repository.dart';
import 'package:tul_shoppingcart/features/cart/domain/entities/cart.dart';
import 'package:tul_shoppingcart/features/cart/domain/entities/product.dart';

part 'cart_list_state.dart';

class CartListCubit extends Cubit<CartListState> {
  CartListCubit(this._repository) : super(CartListState());
  final FireStoreRepository _repository;

  Future<void> init() async {
    emit(state.copyWith(status: CartListStatus.loading));
    try {
      final cart = await _repository.init();
      emit(state.copyWith(cart: cart, status: CartListStatus.success));
    } on Exception {
      emit(state.copyWith(status: CartListStatus.failure));
    }
  }

  Future<void> removeCartItem(Product product) async {
    emit(state.copyWith(status: CartListStatus.loading));
    if (state.cart.products.isEmpty) {
      emit(state.copyWith(status: CartListStatus.success, cart: state.cart));
    } else {
      final updatedProducts = state.cart.products
          .map((i) => product.id != i.product.id
              ? i
              : i.quantity > 1
                  ? i.copyWith(quantity: i.quantity - 1)
                  : null)
          .where((element) => element != null)
          .toList();
      await _repository.updateCart(
          cart: state.cart.copyWith(products: updatedProducts));
      emit(state.copyWith(
        status: CartListStatus.success,
        cart: state.cart.copyWith(
          products: updatedProducts,
        ),
      ));
    }
  }

  Future<void> addCartItem(Product product) async {
    emit(state.copyWith(status: CartListStatus.loading));
    if (state.cart.products.isEmpty) {
      state.cart.products.add(Item(quantity: 1, product: product));
      await _repository.updateCart(cart: state.cart);
      emit(state.copyWith(status: CartListStatus.success, cart: state.cart));
    } else {
      final containts =
          state.cart.products.where((i) => product.id == i.product.id);
      if (containts.isEmpty) {
        state.cart.products.add(Item(quantity: 1, product: product));
        await _repository.updateCart(cart: state.cart);
        emit(state.copyWith(status: CartListStatus.success, cart: state.cart));
      } else {
        final updatedProducts = state.cart.products
            .map((i) => product.id == i.product.id
                ? i.copyWith(quantity: i.quantity + 1)
                : i)
            .toList();
        await _repository.updateCart(
            cart: state.cart.copyWith(products: updatedProducts));
        emit(state.copyWith(
          status: CartListStatus.success,
          cart: state.cart.copyWith(
            products: updatedProducts,
          ),
        ));
      }
    }
  }

  Future<void> popCartItem(Product product) async {
    emit(state.copyWith(status: CartListStatus.loading));
    final updatedProducts =
        state.cart.products.where((i) => i.product.id != product.id).toList();
    await _repository.updateCart(
        cart: state.cart.copyWith(products: updatedProducts));
    emit(state.copyWith(
      status: CartListStatus.success,
      cart: state.cart.copyWith(
        products: updatedProducts,
      ),
    ));
  }

  Future<void> order() async {
    emit(state.copyWith(status: CartListStatus.loading));
    await _repository.order(cartId: state.cart.cartId);
    emit(state.copyWith(status: CartListStatus.clean));
    final cart = await _repository.init();
    emit(state.copyWith(cart: cart, status: CartListStatus.success));
  }
}
