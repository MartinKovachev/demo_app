part of 'products_repository_impl.dart';

@visibleForTesting
extension ListProductDataModelExtension on List<ProductDataModel> {
  List<ProductEntity> toProductEntities() {
    return map((product) => product.toProductEntity()).toList();
  }
}

extension on ProductDataModel {
  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail,
    );
  }
}
