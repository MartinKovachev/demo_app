import 'package:demo_app/core/di/dependencies.dart';
import 'package:demo_app/core/di/di_registrar.dart';
import 'package:demo_app/presentation/page/products_page/product_page_cubit.dart';

class PresentationDependencies implements Dependencies {
  @override
  Future<void> register(DIRegistrar di) async {
    di.registerFactory(() => ProductsPageCubit(getProductsUseCase: di()));
  }
}
