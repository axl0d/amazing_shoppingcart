// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import 'features/cart/data/data_sources/firestore_api_client.dart' as _i5;
import 'features/cart/data/data_sources/local_data_source.dart' as _i6;
import 'features/cart/data/repositories/firestore_repository.dart' as _i8;
import 'features/cart/domain/repositories/cart_repository.dart' as _i7;
import 'features/cart/presentation/bloc/cart_list_cubit.dart' as _i10;
import 'features/cart/presentation/bloc/product_list_cubit.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final fireStoreApiClientModule = _$FireStoreApiClientModule();
  final localDataSourceModule = _$LocalDataSourceModule();
  gh.lazySingleton<_i3.FirebaseFirestore>(
      () => fireStoreApiClientModule.fireStore);
  await gh.lazySingletonAsync<_i4.SharedPreferences>(
      () => localDataSourceModule.sp,
      preResolve: true);
  gh.lazySingleton<_i5.FireStoreApiClient>(
      () => _i5.FireStoreApiClient(get<_i3.FirebaseFirestore>()));
  gh.lazySingleton<_i6.LocalDataSource>(
      () => _i6.LocalDataSource(get<_i4.SharedPreferences>()));
  gh.lazySingleton<_i7.CartRepository>(() => _i8.FireStoreRepository(
      get<_i5.FireStoreApiClient>(), get<_i6.LocalDataSource>()));
  gh.factory<_i9.ProductListCubit>(
      () => _i9.ProductListCubit(get<_i7.CartRepository>()));
  gh.factory<_i10.CartListCubit>(
      () => _i10.CartListCubit(get<_i7.CartRepository>()));
  return get;
}

class _$FireStoreApiClientModule extends _i5.FireStoreApiClientModule {}

class _$LocalDataSourceModule extends _i6.LocalDataSourceModule {}
