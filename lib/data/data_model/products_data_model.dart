import 'package:demo_app/data/data_model/product_data_model.dart';

class ProductsDataModel {
  const ProductsDataModel({required this.products});

  final List<ProductDataModel> products;

  factory ProductsDataModel.fromJson(Map<String, dynamic> json) {
    return ProductsDataModel(
      products: (json['products'] as List)
          .map((products) => ProductDataModel.fromJson(products))
          .toList(growable: false),
    );
  }
}
