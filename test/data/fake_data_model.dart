import 'package:demo_app/data/data_model/product_data_model.dart';

class FakeDataModel {
  const FakeDataModel._();

  static ProductDataModel productDataModel({
    int? id,
    String? title,
    String? description,
    double? price,
    String? thumbnail,
  }) {
    return ProductDataModel(
      id: id ?? 1,
      title: title ?? 'title',
      description: description ?? 'description',
      price: price ?? 0.0,
      thumbnail: thumbnail ?? 'thumbnail',
    );
  }
}
