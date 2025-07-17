import 'package:get_it/get_it.dart';
import 'package:data_service/data/product_service_impl.dart';
import 'package:data_service/data/cart_service_impl.dart';
import 'package:l12_get_it/data_bloc/data_bloc.dart';
import 'package:l12_get_it/cart_bloc/cart_bloc.dart';
import 'package:l12_get_it/detail_bloc/detail_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Register services
  getIt.registerLazySingleton<ProductServiceImpl>(() => ProductServiceImpl());
  getIt.registerLazySingleton<CartServiceImpl>(() => CartServiceImpl());

  // Register bloc factories
  getIt.registerFactory<DataBloc>(() => DataBloc(
    productService: getIt<ProductServiceImpl>(),
    cartService: getIt<CartServiceImpl>(),
  ));
  getIt.registerFactory<CartBloc>(() => CartBloc(
    cartService: getIt<CartServiceImpl>(),
  ));
  getIt.registerFactoryParam<DetailBloc, String, void>((productId, _) => 
    DetailBloc(
      productId: productId,
      productService: getIt<ProductServiceImpl>(),
    )
  );
} 