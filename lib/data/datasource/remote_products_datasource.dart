import 'package:demo_app/core/exception/app_exception.dart';
import 'package:demo_app/core/result.dart';
import 'package:demo_app/data/data_model/product_data_model.dart';
import 'package:demo_app/data/data_model/products_data_model.dart';
import 'package:demo_app/data/network/http_client.dart';

class RemoteProductsDataSource {
  const RemoteProductsDataSource({required HttpClient httpClient})
      : _httpClient = httpClient;

  final HttpClient _httpClient;

  static const _productsUrl = 'https://dummyjson.com/products';

  Future<Result<List<ProductDataModel>, AppException>> getProducts({
    int limit = 10,
    int skip = 0,
  }) {
    return _httpClient.get(
      url: _productsUrl,
      responseMapper: (json) => ProductsDataModel.fromJson(json).products,
      queryParameters: {
        'limit': limit,
        'skip': skip,
        'select': [
          'id',
          'title',
          'description',
          'price',
          'thumbnail',
        ].join(','),
      },
    );
  }
}
