import 'package:demo_app/core/di/dependencies.dart';
import 'package:demo_app/core/di/di_registrar.dart';
import 'package:demo_app/data/datasource/remote_products_datasource.dart';
import 'package:demo_app/data/repository/products_repository_impl.dart';
import 'package:demo_app/domain/repository/products_repository.dart';

class DataDependencies implements Dependencies {
  @override
  Future<void> register(DIRegistrar di) async {
    await _registerDataSources(di);
    await _registerRepositories(di);
  }

  Future<void> _registerDataSources(DIRegistrar di) async {
    di.registerLazySingleton(() => RemoteProductsDataSource(httpClient: di()));
  }

  Future<void> _registerRepositories(DIRegistrar di) async {
    di.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(remoteProductsDataSource: di()),
    );
  }
}
