import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tul_shoppingcart/features/cart/data/repositories/firestore_repository.dart';
import 'package:tul_shoppingcart/features/cart/domain/entities/product.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(this._repository) : super(ProductListState());
  final FireStoreRepository _repository;

  Future<void> fetchProducts() async {
    emit(state.copyWith(status: ProductListStatus.loading));
    try {
      final products = await _repository.getProducts();
      emit(state.copyWith(
          products: products, status: ProductListStatus.success));
    } on Exception {
      emit(state.copyWith(status: ProductListStatus.failure));
    }
  }
}
