import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/result.dart';
import 'package:demo_app/domain/entity/product_entity.dart';
import 'package:demo_app/domain/repository/products_repository.dart';

class GetProductsUseCase {
  const GetProductsUseCase({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository;

  final ProductsRepository _productsRepository;

  Future<Result<List<ProductEntity>, AppException>> call({
    required int limit,
    required int skip,
  }) {
    return _productsRepository.getProducts(
      limit: limit,
      skip: skip,
    );
  }
}
