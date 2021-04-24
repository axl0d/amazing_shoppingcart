import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class LocalDataSourceModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get sp => SharedPreferences.getInstance();
}

@lazySingleton
class LocalDataSource {
  const LocalDataSource(
    this._sp,
  );

  final SharedPreferences _sp;

  String getPurchaseId() => _sp.getString('purchase_key');
  String getCartId() => _sp.getString('cart_key');

  void setPurchaseKey(String purchaseKey) =>
      _sp.setString('purchase_key', purchaseKey);

  void setCartKey(String cartKey) => _sp.setString('cart_key', cartKey);
}
