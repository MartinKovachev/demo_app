import 'package:demo_app/core/di/dependencies.dart';
import 'package:demo_app/core/di/di_registrar.dart';
import 'package:demo_app/domain/use_case/get_products_use_case.dart';

class DomainDependencies implements Dependencies {
  @override
  Future<void> register(DIRegistrar di) async {
    di.registerFactory(() => GetProductsUseCase(productsRepository: di()));
  }
}
