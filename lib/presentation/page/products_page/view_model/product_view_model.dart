import 'package:equatable/equatable.dart';

class ProductViewModel extends Equatable {
  const ProductViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  @override
  List<Object> get props => [
        id,
        title,
        description,
        price,
        thumbnail,
      ];
}
