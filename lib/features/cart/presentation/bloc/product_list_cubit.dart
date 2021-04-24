import 'package:amazing_shoppingcart/features/cart/domain/entities/product.dart';
import 'package:amazing_shoppingcart/features/cart/domain/repositories/cart_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'product_list_state.dart';

@injectable
class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(this._repository) : super(ProductListState());
  final CartRepository _repository;

  Future<void> fetchProducts() async {
    emit(state.copyWith(status: ProductListStatus.loading));
    try {
      final products = await _repository.getProducts();
      emit(
        state.copyWith(
          products: products,
          status: ProductListStatus.success,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: ProductListStatus.failure));
    }
  }
}
