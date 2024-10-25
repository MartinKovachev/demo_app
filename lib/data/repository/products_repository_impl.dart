import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/result.dart';
import 'package:demo_app/data/data_model/product_data_model.dart';
import 'package:demo_app/data/datasource/remote_products_datasource.dart';
import 'package:demo_app/domain/entity/product_entity.dart';
import 'package:demo_app/domain/repository/products_repository.dart';
import 'package:meta/meta.dart';

part 'products_repository_impl.mapper.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl({required RemoteProductsDataSource remoteProductsDataSource})
      : _remoteProductsDataSource = remoteProductsDataSource;

  final RemoteProductsDataSource _remoteProductsDataSource;

  @override
  Future<Result<List<ProductEntity>, AppException>> getProducts({
    required int limit,
    required int skip,
  }) async {
    final result = await _remoteProductsDataSource.getProducts(
      limit: limit,
      skip: skip,
    );

    if (result.isFailure) {
      return Result.failure(result.exception);
    }

    final productEntities = result.data.toProductEntities();

    return Result.success(productEntities);
  }
}
