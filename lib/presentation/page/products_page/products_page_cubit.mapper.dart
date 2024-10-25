part of 'product_page_cubit.dart';

extension on List<ProductEntity> {
  List<ProductViewModel> toProductViewModels() {
    return map((productEntity) => productEntity.toProductViewModel()).toList();
  }
}

extension on ProductEntity {
  ProductViewModel toProductViewModel() {
    return ProductViewModel(
      id: id,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail,
    );
  }
}
