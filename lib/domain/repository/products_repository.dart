import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/result.dart';
import 'package:demo_app/domain/entity/product_entity.dart';

abstract interface class ProductsRepository {
  Future<Result<List<ProductEntity>, AppException>> getProducts({
    required int limit,
    required int skip,
  });
}
